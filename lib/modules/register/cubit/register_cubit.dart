import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login/login_model.dart';
import 'package:shop_app/modules/login/cubit/login_states.dart';
import 'package:shop_app/modules/register/cubit/register_states.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import '../../../shared/network/endpoints.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() :super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  LoginModel? loginModel;



  void registerUser({
    required String name,
    required String email,
    required String password,
    required String phone,
   }){
    emit(RegisterLoadingState());
    DioHelper.postData(
      url:REGISTER,
      data:{
         'name':name,
         'phone':phone,
         'email':email,
         'password':password,
      },
    ).then((value){
       print(value);
       //take object from Register model which contain all the response
       loginModel=LoginModel.fromJson(value.data);

       emit(RegisterSuccessState(loginModel!));
       print(loginModel!.message.toString());
    }).catchError((error){
      print("the error happened :::${error.toString()}");
      emit(RegisterErrorState(error.toString()));
    });
  }
  IconData suffix=Icons.visibility;
  bool isPassword=true;


  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix=isPassword?Icons.visibility:Icons.visibility_off;
    emit(RegisterChangePasswordVisibilityState());
  }


}