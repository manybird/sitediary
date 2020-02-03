import 'package:sitediary/data_cache/repository_service.dart';
import 'package:sitediary/model/Product.dart';
import 'package:sitediary/model/data_http.dart';
import 'package:flutter/material.dart';
import 'dart:async';


final ThemeData _kTheme = new ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.teal,
  accentColor: Colors.redAccent,
);

class LazyLoadMain extends StatefulWidget {

  static String routeName = '/lay_load_main';

  @override
  createState() => LazyLoadMainState();
}

class LazyLoadMainState extends State<LazyLoadMain> {
  final ProductDataService dataService = ProductDataService();
  Future getDataFunction(int pageIndex, int pageSize) async{
    return dataService.getProducts(pageIndex,pageSize);
  }
  RepositoryService _repo;
  @override
  void initState() {
    super.initState();
    _repo = RepositoryService(getDataFunction, 10);
  }

  void onItemReceived( product) {
    setState(() {});
  }

  int _counter=0;

  @override
  Widget build(BuildContext context) {
    // Need to pull something to know at least how many products do we have
   if(_counter%100 == 1) print('Build fired ${_counter++}');
   else _counter ++;

   _repo.getItem(0).then(onItemReceived);

     //print('build fire');
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallaby'),
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          _repo.clearAll();
          return _repo.getItem(0);
        },
        child: _buildSuggestions(),
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: (_repo.totalProducts??0) * 2,
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();

        //int index1 = i ~/ 2;
        //double index2 = i / 2;
        final index = i ~/ 2;
        return _buildProductRow(_repo.getItem(index));
      },
    );
  }

  Widget _buildProductRow(Future<dynamic> productFuture) {
    if (productFuture == null) {
      return Text("error loading item");
    } else {
      return FutureBuilder<dynamic>(
        future: productFuture,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return _buildProductCard(snapshot.data);
          } else {
            return Text("");
          }
        },
      );
    }
  }

  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: () {
        showProductDetails(context, product);
      },
      child: Row(children: [
        Container(
          height: 64.0,
          width: 64.0,
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Container(),// Image.network(product.productImage),
        ),
        Expanded(
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Flexible(
              child: Text(
                product.productName,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ]),
        ),
        new Container(
          margin: const EdgeInsets.only(left: 8.0),
          child: Text(
            product.price,
            textAlign: TextAlign.end,
          ),
        ),
      ]),
    );
  }




  void showProductDetails(BuildContext context, Product product) {
    Navigator.push(
        context,
        MaterialPageRoute<void>(
          settings: const RouteSettings(name: '/flute/product'),
          builder: (BuildContext context) {
            return Theme(
              data: _kTheme.copyWith(platform: Theme.of(context).platform),
              child: _buildProductDetailsPage(product),
            );
          },
        ));
  }

  Widget _buildProductDetailsPage(Product product) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.productName),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              //Image.network(product.productImage),
              Flexible(
                child: Text(
                  product.price,
                  textAlign: TextAlign.right,
                  maxLines: 3,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                      fontSize: 24.0),
                ),
              ),
              Expanded(
                flex: 10,
                child: SingleChildScrollView(
                  child: RichText(
                    text: TextSpan(
                      text: product.longDescription,
                      style: TextStyle(color: Colors.black87, fontSize: 14.0),
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }

}
