import 'dart:async';

import 'package:sitediary/datas/eform/eform_record.dart';
import 'package:sitediary/persistence/location_camera.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';


class GoogleMapViewerApp extends StatefulWidget {

  static String routeName = '/GoogleMap';
  final LocationCamera locationCamera;// = loc(22.278647962659637, 114.17130086570978);
  final EFormRecordDetail recordDetail;

  GoogleMapViewerApp(this.locationCamera,{this.recordDetail});

  @override
  State<GoogleMapViewerApp> createState() => GoogleMapViewerAppState();
}

class GoogleMapViewerAppState extends State<GoogleMapViewerApp> {

  final Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  final Completer<GoogleMapController> _controller = Completer();
  CameraPosition _kGooglePlex;

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async{
        Future.delayed(Duration(milliseconds: 100)).then((v){
          try{
          }catch  (ex){
          }
        });
        return true;
      },
      child: new Scaffold(
        appBar: AppBar(
          title: Text('Map'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.gps_fixed),
              onPressed: (){
                _goToCurrentLocation(true);
              },
            ),
          ],
        ),
        body: GoogleMap(
          markers: Set<Marker>.of(markers.values), // YOUR MARKS IN MAP
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            print('onMapCreated: ');
          },
          onCameraMove: (CameraPosition cp){

            final loc = widget.locationCamera;
            //loc.latitude = cp.target.latitude;
            //loc.longitude = cp.target.longitude;
            loc.zoom = cp.zoom;
            loc.rotation = cp.bearing;

          },
          onCameraIdle: (){
            print('onCameraIdle: ${widget.locationCamera}');
          },

          onTap: (LatLng pos){
            final loc = widget.locationCamera;
            loc.latitude = pos.latitude;
            loc.longitude = pos.longitude;
            _createMarker(widget.locationCamera,true);
          },
          onCameraMoveStarted: (){
            //print('onCameraMoveStarted: ');
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: isGettingAddress?null: (){
            if (markers.length==0) {
              if (widget.recordDetail != null) {
                widget.recordDetail.itemValue = '';
                widget.recordDetail.itemThumbPath = '';
              }

              Navigator.pop(context, null);
              return;
            }

            final marker = markers.values.first;
            final locationCameraOut = LocationCamera();

            locationCameraOut .latitude = marker.position.latitude;
            locationCameraOut.longitude = marker.position.longitude;

            locationCameraOut.zoom = widget.locationCamera.zoom;
            locationCameraOut.rotation = widget.locationCamera.rotation;

            if (widget.recordDetail!=null){
              widget.recordDetail.itemThumbPath = locationCameraOut.toString();
              widget.recordDetail.itemValue = widget.locationCamera.featureName;
            }

            Navigator.pop(context,locationCameraOut);
          },
          label: Container(
            width: MediaQuery .of(context) .size .width - 80,
            child: Row(
              children: <Widget>[
                Flexible(
                    child: Text('Select "${widget.locationCamera.featureName}"')
                ),
              ],
            ),
          ),
          //icon:  Icon( isGettingAddress?Icons.autorenew: Icons.select_all),
          backgroundColor: isGettingAddress? Colors.grey:Colors.orangeAccent,
        ),
      ),
    );
  }

  var location = new Location();
  @override
  void initState() {
    super.initState();

    final loc = widget.locationCamera;

    final hasLocation = loc.hasLocation;

    location.requestPermission().then((bool hasPermission){
      print('requestPermission: $hasPermission');
    }).whenComplete((){
      if (!hasLocation){
        _goToCurrentLocation(false).then((v){
          _createMarker(loc,true);
        });
      }else{
        _createMarker(loc,false);
      }
    });

    if (!loc.hasLocation) {
      loc.setDefault();
    }

    _kGooglePlex = CameraPosition(
      target: LatLng(loc.latitude, loc.longitude),
      zoom: loc.zoom,
      bearing: loc.rotation,
    );
  }


  _createMarker( LocationCamera loc, bool needGetAddress){


    final MarkerId markerId = MarkerId('Location') ;

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(loc.latitude,loc.longitude),
      infoWindow: InfoWindow(
        title: '${loc.featureName}', snippet: '',
      ),
      onTap: () {
        //_onMarkerTapped(markerId);
      },
    );

    setState(() {
      // adding a new marker to map
      markers[markerId] = marker;
    });

    if (needGetAddress){
      _createAddress(loc);
    }
  }

  bool isGettingAddress = false;
  _createAddress(LocationCamera loc){
    widget.locationCamera.featureName = '';
    widget.locationCamera.addressLine = '';
    setState(() { isGettingAddress  =true; });
    final coordinates = new Coordinates(loc.latitude,loc.longitude);


    //final geoCoder = Geocoder.google('AIzaSyATUyhDVKmdwBACEbALc2UELBZnMVSlSVE', language: 'en');
    final geoCoder = Geocoder.local;

    geoCoder.findAddressesFromCoordinates(coordinates).then((addresses){
      Address address = addresses.first;
      print("${address.featureName} : ${address.addressLine}");

      loc.featureName = address.featureName;
      loc.addressLine = address.addressLine;

      _createMarker(loc,false);
    }).whenComplete((){
      setState(() { isGettingAddress  =false; });
    });
  }

  _onMarkerTapped(MarkerId markerID){
    markers.remove(markerID);
  }

  Future<void> _goToCurrentLocation(bool isAnimated) async {
    //final GoogleMapController controller = await _controller.future;
    //controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));

    try {
      bool has = await location.requestService();
      if (!has) return;
    }catch  (e){
      print('requestPermission error: $e');
       return;
    }

    location.getLocation().then((LocationData locationData) async{
      try {
        print('requestPermission: $locationData');
        final loc = widget.locationCamera;

        loc.latitude = locationData.latitude;
        loc.longitude = locationData.longitude;
        final lastXY = LatLng(locationData.latitude, locationData.longitude);
        _kGooglePlex = CameraPosition(
          target: lastXY,
          zoom: loc.zoom,
          bearing: loc.rotation,
        );

        final GoogleMapController controller = await _controller.future;
        final c = CameraUpdate.newCameraPosition(_kGooglePlex);
        if (isAnimated)
          controller.animateCamera(c);
        else
          controller.moveCamera(c);



      }catch(e){
        print(' location.getLocation() error: $e');
      }
    });

  }


}