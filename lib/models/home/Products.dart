class Products {
  late final int? id;
  late final  dynamic price;
  late final  dynamic oldPrice;
  late final  dynamic discount;
  late final  String? image;
  late final  String? name;
  late final  bool? inFavorites;
  late final  bool? inCart;

  Products.fromJson(dynamic json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

 //to post product
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['price'] = price;
    map['old_price'] = oldPrice;
    map['discount'] = discount;
    map['image'] = image;
    map['name'] = name;
    map['in_favorites'] = inFavorites;
    map['in_cart'] = inCart;
    return map;
  }

}