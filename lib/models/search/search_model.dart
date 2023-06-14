class SearchModel {
  bool? status;
  String? message;
  Data? data;

  SearchModel({this.status, this.message, this.data});

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  dynamic currentPage;
  List<SearchProduct>? data;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <SearchProduct>[];
      json['data'].forEach((v) {
        data!.add( SearchProduct.fromJson(v));
      });
    }
  }

}

class SearchProduct {
  int? id;
  dynamic price;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool? inFavorites;
  bool? inCart;

  SearchProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
