import 'package:shop_app/models/home/Data.dart';

class HomeModel {
 late final  dynamic message;
 late final  Data? data;


  HomeModel.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

 //to post home product
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}