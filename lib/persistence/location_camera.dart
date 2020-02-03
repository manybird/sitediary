

class LocationCamera{
  double latitude;
  double longitude;
  double zoom = 15;
  double rotation =0;

  String featureName='';
  String addressLine='';

  LocationCamera({this.latitude=0,this.longitude=0,this.zoom =0, this.rotation=0});

  bool get hasLocation{
    return (zoom ??0) > 0;
  }

  setDefault(){
    final loc = this;
    loc.zoom = 15;
    loc.latitude = 22.27;
    loc.longitude = 114.17;
  }

  factory LocationCamera.fromString(String s){

    double lat = 0;
    double lon = 0;
    double zoom = 0;
    double rotation = 0;

    if (s!=null){
      final ary = s.split(";");
      if (ary.length >0) lat = double.tryParse(ary[0]);
      if (ary.length >1) lon = double.tryParse(ary[1]);
      if (ary.length >2) zoom = double.tryParse(ary[2]);
      if (ary.length >3) rotation = double.tryParse(ary[3]);
    }

    final lc = LocationCamera();
    lc.latitude = lat;
    lc.longitude = lon;
    lc.zoom = zoom;
    lc.rotation = rotation;

    return lc;
  }

  @override
  String toString() {
    return '$latitude;$longitude;$zoom;$rotation';
  }

}