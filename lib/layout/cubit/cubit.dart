import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories/categories_model.dart';
import 'package:shop_app/models/favorites/change_favorites_model.dart';
import 'package:shop_app/models/favorites/get_favorites_model.dart';
import 'package:shop_app/models/home/HomeProduct.dart';
import 'package:shop_app/models/login/login_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/network/endpoints.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit <ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
     ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
     SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  // int  >>id of the product
  // bool >>is it with us in the favorites or not.
  Map<int ,bool> favorites={};


  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token:token,
    ).then((value) {
      emit(ShopSuccessHomeDataState());
      homeModel = HomeModel.fromJson(value.data);
      printFullText('The name of the product is :::${homeModel?.data?.products?[0].name}');

      homeModel?.data?.products?.forEach((element) {
           favorites.addAll({
             element.id!:element.inFavorites!
           });
      });

      print(favorites);
    }).catchError((error) {
      emit(ShopErrorHomeDataState());
      print(error.toString());
    });
  }
  CategoriesModel? categoriesModel;
  void getCategories() {
    DioHelper.getData(url: GET_CATEGORY,token:token,)
      .then((value) {
        emit(ShopSuccessCategoryState());
        categoriesModel = CategoriesModel.fromJson(value.data);
       // printFullText('The name of the category is :::${categoriesModel?.data.categories[0].name}');
    }).catchError((error) {
      emit(ShopErrorCategoryState());
      print("elaraby error is ::::${error.toString()}");
    });
  }
  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId){
            favorites[productId]=!favorites[productId]!;
            //emit the state here to change the color if fav icon immediately

            emit(ShopChangeFavoritesState());
        DioHelper.postData(
             url: FAVORITES,
             token:token,
             data:{'product_id':productId}
         ).then((value) {
                   //post the change of the favorites on the server.
                   changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
                   print(value.data);
                   if(changeFavoritesModel?.status==false){
                     //eliminate the change of the color on the ui because it will not happen on the server.
                     favorites[productId]=!favorites[productId]!;
                   }else{
                       getFavorites();
                   }
                          emit(ShopSuccessChangeFavoritesState(changeFavoritesModel: changeFavoritesModel!));
         }
        ).catchError((error){
          favorites[productId]=!favorites[productId]!;
          emit(ShopErrorChangeFavoritesState());
          //eliminate the change of the color on the ui because it will not happen on the server.

        });
  }

  FavoritesModel? favoritesModel;
  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(url: FAVORITES,token:token,)
        .then((value) {
      emit(ShopSuccessGetFavoritesState());
      favoritesModel = FavoritesModel.fromJson(value.data);
    }).catchError((error) {
      emit(ShopErrorGetFavoritesState());
      print("elaraby error when getting the favorites  is ::::${error.toString()}");
    });
  }

  LoginModel? userModel;
  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
       url: PROFILE,
      token:token,
    )
        .then((value) {

      userModel = LoginModel.fromJson(value.data);
      emit(ShopSuccessUserDataState(userModel!));
      print('elaraby user details are:::${value.data}');
    }).catchError((error) {
      emit(ShopErrorUserDataState());
      print("elaraby error when getting the user data  is ::::${error.toString()}");
    });
  }


  void updateUserData({
    required String name,
    required String email,
    required String phone,
   }){
    emit(ShopLoadingUpdateUserDataState());
    DioHelper.updateData(
       url: UPDATE,
       token:token,
       data: {
          'name':name,
          'email':email ,
          'phone':phone
       },
     ) .then((value) {
      userModel = LoginModel.fromJson(value.data);

      emit(ShopSuccessUpdateUserDataState(userModel!));
      print('elaraby UpdateUser success details are:::${value.data}');
    }).catchError((error) {
      emit(ShopErrorUpdateUserDataState());
      print("elaraby error when getting the UpdateUser data  is ::::${error.toString()}");
    });
  }

}
