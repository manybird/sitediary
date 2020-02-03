

class PagingItemCollection<T> {
  final List<T> items;
  final int totalProducts;
  final int pageNumber;
  final int pageSize;

  PagingItemCollection({this.items, this.totalProducts, this.pageNumber, this.pageSize});

}