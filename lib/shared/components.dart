import 'package:flutter/material.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/models/favorites/get_favorites_model.dart';
import 'package:shop_app/models/search/search_model.dart';
import 'package:shop_app/shared/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateTo(context, nextScreen) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => nextScreen,
      ));
}

void navigateAndFinish(context, nextScreen) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => nextScreen,
    ),
    (route) => false, //to eliminate the last screen.
  );
}

Widget DefaultTextFormField({
  required TextEditingController controller,
  required TextInputType textInputType,
  required String? Function(String? string)?
      validator, //Function refers to an anonymous function.
  required String label,
  required IconData prefix,
  IconButton? suffix,
  Function(String string)? onFieldSubmitted,
  Function(String string)? onChange,
  Function()? onTap,
  bool isClickable = true,
  bool isPassword = false, //the default is to hide the password.
}) {
  return TextFormField(
    validator: validator,
    controller: controller,
    obscureText: isPassword,
    //do you want to show the password or not.
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(prefix),
      suffixIcon: suffix ?? null,
      border: const OutlineInputBorder(),
    ),
    keyboardType: textInputType,
    onFieldSubmitted: onFieldSubmitted,
    onChanged: onChange,
    onTap: onTap,
    enabled: isClickable,
  );
}

Widget DefaultButton(
        {double width = double.infinity,
        Color backgroundColor = defaultColor,
//null safety::
// A Function can be anything, like Function(), Function(int), etc,
// which is why with Dart null safety, you should explicitly tell what that Function is
// you can replace the void Function() by VoidCallback
        required final void Function() function,
        required String text,
        double radius = 5.0}) =>
    Container(
      width: width,
      child: Container(
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(radius)),
        child: MaterialButton(
          onPressed: function,
          child: Text(
            text.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );

void makeToast({required String message, required ToastStates toastState}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(toastState),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color? chooseToastColor(ToastStates states) {
  Color? color;
  switch (states) {
    case ToastStates.SUCCESS:
      {
        color = Colors.green;
        break;
      }
    case ToastStates.ERROR:
      {
        color = Colors.red;
        break;
      }
    case ToastStates.WARNING:
      {
        color = Colors.amber;
        break;
      }
  }
  return color;
}

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 20.0),
      child: Container(
        height: 1,
        color: Colors.grey[500],
      ),
    );

Widget buildFavouritesListItem(
  Product model,
  context,
) {
  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      width: screenWidth,
      height: screenHeight * 0.2,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(
                  model!.image!,
                ),
                height: 120,
                width: 120,
              ),
              if (model.discount > 0 )
                Container(
                  color: Colors.red,
                  padding: const EdgeInsets.all(4),
                  child: const Text(
                    'DISCOUNT',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        height: 1.3, fontSize: 10.0, color: Colors.white),
                  ),
                ),
            ],
          ),
          const SizedBox(
            width: 16.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(height: 1.3, fontSize: 14.0),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      model.price!.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                          height: 1.3, fontSize: 12.0, color: defaultColor),
                    ),
                    const SizedBox(width: 10.0),
                    if (model.discount > 0)
                      Text(
                        model.oldPrice!.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                          height: 1.3,
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: ShopCubit.get(context).favorites[model.id]! ? Colors.red: Colors.grey[300],
                      ),
                      iconSize: 30,
                      onPressed: () {
                        print('The favorite product id ${model.id!.toString()}');
                        ShopCubit.get(context).changeFavorites(model.id!);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}


Widget buildSearchListItem(
    model,
    context,
    ) {
  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      width: screenWidth,
      height: screenHeight * 0.2,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(
                  model!.image!,
                ),
                height: 120,
                width: 120,
              ),
            ],
          ),
          const SizedBox(
            width: 16.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(height: 1.3, fontSize: 14.0),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      model.price!.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                          height: 1.3, fontSize: 12.0, color: defaultColor),
                    ),
                    const SizedBox(width: 10.0),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}