import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/models/login/login_model.dart';
import 'package:shop_app/modules/login/cubit/login_states.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import '../../../shared/network/endpoints.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() :super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  LoginModel? loginModel;
  void loginUser({required String email,required String password,required BuildContext context}) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url:LOGIN,
      data:{
        'email':email,
        'password':password
      },
    ).then((value){
       print(value);
       //take object from login model which contain all the response
       loginModel=LoginModel.fromJson(value.data);
       CacheHelper.saveData(key: 'token', value: loginModel?.data?.token)
           .then((value) {
         navigateAndFinish(context,const ShopLayout());

         token=CacheHelper.getData(key: 'token');
         print('your token is $token');

       } );


       emit(LoginSuccessState(loginModel!));
    }).catchError((error){
      print("the error happened :::${error.toString()}");
      emit(LoginErrorState(error.toString()));
    });
  }


  IconData suffix=Icons.visibility;
  bool isPassword=true;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix=isPassword?Icons.visibility:Icons.visibility_off;
    emit(LoginChangePasswordVisibilityState());
  }


}