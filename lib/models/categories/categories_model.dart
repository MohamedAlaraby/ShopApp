class CategoriesModel{
 late final bool status;
 late final CategoriesDataModel data;

 CategoriesModel.fromJson(dynamic json){
     status=json['status'];
     data=CategoriesDataModel.fromJson(json['data']);
 }


}

class CategoriesDataModel{
    late final dynamic currentPage;
    late final List<CategoryModel> categories=[];

    CategoriesDataModel.fromJson(dynamic json){
      currentPage=json['current_page'];
      json['data'].forEach((category){
          categories.add(CategoryModel.fromJson(category));
      });
    }
}

//the third model class
class CategoryModel{
 late final dynamic id;
 late final String name;
 late final String image;


 CategoryModel.fromJson(dynamic json){
        id=json['id'];
        name=json['name'];
        image=json['image'];
  }


}