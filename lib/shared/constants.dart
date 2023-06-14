import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

void signOut(context){

  CacheHelper.removeData(key: 'token').then((value) {
    token="";
    navigateAndFinish(context, LoginScreen());
  });

}
void printFullText(String? text){
  final pattern=RegExp('.{1,800}');//800 size of each chunk.
  pattern.allMatches(text!).forEach((match) {
   print(match.group(0)) ;
  });

}
//to be able to get the token from any screen in the app as long as the app is alive.
String? token=' ';