import 'package:shop_app/models/home/Products.dart';
import 'Banners.dart';
class Data {
 late final List<Banners>? banners;
 late final  List<Products>? products;
 //to get data
  Data.fromJson(dynamic json) {
    if (json['banners'] != null) {
      banners = [];
      json['banners'].forEach((banner) {
        banners?.add(Banners.fromJson(banner));
      });
    }


    if (json['products'] != null) {
      products = [];
      json['products'].forEach((product) {
        products?.add(Products.fromJson(product));
      });
    }


  }

  //to post data
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (banners != null) {
      map['banners'] = banners?.map((v) => v.toJson()).toList();
    }
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}