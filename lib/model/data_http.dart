import 'dart:async';
import 'Product.dart';



import '../data_cache//paging_data.dart';

class ProductDataService {

  Future<PagingItemCollection<Product>> getProducts(int pageNumber, int pageSize) async {

    await Future.delayed(Duration(seconds: 1));

    final list = List<Product>();

    int total = 1000;
    int starting = pageSize * pageNumber;

    for(int i = starting;i <= total ; i ++){
      Product p = Product(
        productId: i.toString(), productName: 'Produce $i',
        price: 'Price $i',
        reviewRating: i * 1.0,
      );
      list.add(p);
    }

    return PagingItemCollection(items: list,totalProducts: total,pageNumber: pageNumber,pageSize: pageSize);

  }
}

class FetchDataException implements Exception {
  String _message;

  FetchDataException(this._message);

  String toString() {
    return "Exception: $_message";
  }
}
