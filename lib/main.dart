
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/themes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await DioHelper.init();
  await CacheHelper.init();

  bool? onBoarding= CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print("the token is :::$token");

    Widget? widget;
    if(onBoarding != null){
    //this means the user saw the on boarding screen before.
        if(token != null ){
          //this means the user logged in before and didn't make log out.
           widget =const ShopLayout();
        }else{
          //this means the user didn't log in before or made log out.
          widget = LoginScreen();
        }
  }else{
    //this means the user didn't open the app before.
    widget = const OnBoardingScreen();
  }

  runApp(MyApp(widget));
}
class MyApp extends StatelessWidget {
  final Widget startingWidget;
  MyApp(this.startingWidget);


  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
      child: MaterialApp(
        debugShowCheckedModeBanner:false,
        title: 'Salla',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
         home:startingWidget,
      ),
    );
  }
}
