class Banners {
 late final  int id;
 late final  String image;
 late final  dynamic category;
 late final  dynamic product;


  Banners.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
    category = json['category'];
    product = json['product'];
  }

 //to post banner
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    map['category'] = category;
    map['product'] = product;
    return map;
  }

}