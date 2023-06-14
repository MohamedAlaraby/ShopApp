import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/components.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {  },
      builder:(context, state) {
        var cubit=ShopCubit.get(context);

        return  ConditionalBuilder(
          condition:state is !ShopLoadingGetFavoritesState ,
          fallback:(context) =>const Center(child:CircularProgressIndicator())  ,
          builder:(context) {
             return ListView.separated(
                physics:const  BouncingScrollPhysics(),
                separatorBuilder: (context, index) =>myDivider(),
                itemBuilder: (context, index) => buildFavouritesListItem(cubit.favoritesModel!.data!.listOfFav![index].product!,context),
                itemCount:cubit.favoritesModel!.data!.listOfFav!.length,
              );
          }
        );
      },
    );
  }



  }

















