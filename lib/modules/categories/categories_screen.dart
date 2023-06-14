import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories/categories_model.dart';
import 'package:shop_app/shared/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CategoryModel>? list;
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {  },
      builder:(context, state) {
      var cubit=ShopCubit.get(context);
      return  ListView.separated(
        physics:const  BouncingScrollPhysics(),
          separatorBuilder: (context, index) =>myDivider(),
          itemBuilder: (context, index) => buildCatItem(cubit.categoriesModel?.data.categories[index]),
          itemCount: cubit.categoriesModel!.data.categories.length,
        );
      },
    );
  }

  Widget buildCatItem(CategoryModel? category)=>Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      children: [
        Image(image: NetworkImage(
            category!.image
        ),
          width:120,
          height: 120,
        ),
        const SizedBox(width: 16,),
        Text(
          category.name,
          style:const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 16.0
          ) ,
        ),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios)

      ],

    ),
  );
}

