import 'package:bloc/bloc.dart';
import 'package:shop_app/models/login/login_model.dart';

import '../../models/favorites/change_favorites_model.dart';

abstract class ShopStates{}
class ShopInitialState extends ShopStates{}
class ShopChangeBottomNavState extends  ShopStates{}


class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{}

class ShopSuccessCategoryState extends ShopStates{}
class ShopErrorCategoryState extends ShopStates{}

class ShopSuccessChangeFavoritesState extends ShopStates{
  final ChangeFavoritesModel changeFavoritesModel;
  ShopSuccessChangeFavoritesState({required this.changeFavoritesModel});
}
class ShopChangeFavoritesState extends ShopStates{}
class ShopErrorChangeFavoritesState extends ShopStates{}

class ShopSuccessGetFavoritesState extends ShopStates{}
class ShopErrorGetFavoritesState extends ShopStates{}
class ShopLoadingGetFavoritesState extends ShopStates{}

class  ShopSuccessUserDataState extends ShopStates{
  final LoginModel? userModelFromState;
  ShopSuccessUserDataState(this.userModelFromState);
}
class ShopErrorUserDataState extends ShopStates{}
class ShopLoadingUserDataState extends ShopStates{}


class ShopLoadingUpdateUserDataState extends ShopStates{}
class  ShopSuccessUpdateUserDataState extends ShopStates{
  final LoginModel? userModelFromState;
  ShopSuccessUpdateUserDataState(this.userModelFromState);
}
class ShopErrorUpdateUserDataState extends ShopStates{}