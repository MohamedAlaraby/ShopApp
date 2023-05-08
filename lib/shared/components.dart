
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/shared/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
void navigateTo(context,nextScreen){
    Navigator.push(context, MaterialPageRoute(builder: (context) => nextScreen,));
}
void navigateAndFinish(context,nextScreen){
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => nextScreen,),
        (route)=>false,//to eliminate the last screen.
    );
}


Widget DefaultTextFormField({
    required TextEditingController controller,
    required TextInputType textInputType,
    required String? Function(String? string)? validator,//Function refers to an anonymous function.
    required String label,
    required IconData prefix,
    IconButton? suffix,
    Function(String string)? onFieldSubmitted,
    Function(String string)? onChange,
    Function()? onTap,
    bool isClickable = true,
    bool isPassword =  false, //the default is to hide the password.
}) {
    return TextFormField(
        validator: validator,
        controller: controller,
        obscureText: isPassword,//do you want to show the password or not.
        decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(prefix),
            suffixIcon: suffix ?? null,
            border:const OutlineInputBorder(),
        ),
        keyboardType: textInputType,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChange,
        onTap: onTap,
        enabled: isClickable,
    );
}
Widget DefaultButton({
double width=double.infinity,
Color backgroundColor=defaultColor,
//null safety::
// A Function can be anything, like Function(), Function(int), etc,
// which is why with Dart null safety, you should explicitly tell what that Function is
// you can replace the void Function() by VoidCallback
required final void Function() function,
required String text,
double radius=5.0
})=>Container(
    width: width,
    child: Container(
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius:BorderRadius.circular(radius)
        ),
        child: MaterialButton(
            onPressed : function,
            child: Text(
                text.toUpperCase(),
                style:const TextStyle(
                    color: Colors.white,
                ),
            ),
        ),
    ),
);
void makeToast({required String message,required ToastStates toastState})=>
    Fluttertoast.showToast(
        msg:message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(toastState),
        textColor: Colors.white,
        fontSize: 16.0
    );
enum ToastStates{SUCCESS,ERROR,WARNING}


Color? chooseToastColor(ToastStates states){
    Color? color;
    switch(states){
       case ToastStates.SUCCESS:
       {
           color= Colors.green;
           break;
       }
       case ToastStates.ERROR:
       {
          color= Colors.red;
          break;
       }
       case ToastStates.WARNING:
       {
          color= Colors.amber;
          break;
       }
   }
   return color;
}