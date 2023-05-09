import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shop_app/models/home/HomeProduct.dart';
import 'package:shop_app/shared/colors.dart';

import '../../models/home/Products.dart';
import '../../shared/constants.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) => ProductsBuilder(cubit.homeModel),
        );
      },
    );
  }

  Widget ProductsBuilder(HomeModel? homeModel) => SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              //the function map is doing looping on the list elements to take something from each element.
              items: homeModel?.data?.banners
                  ?.map(
                    (element) => Image(
                      image: NetworkImage(element.image.toString()),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                viewportFraction: 1.0,
                height: 250.0,
                initialPage: 0,
                scrollDirection: Axis.horizontal,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(seconds: 1),
                reverse: false,
                autoPlayCurve: Curves.fastOutSlowIn,

              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              color: Colors.grey[200],
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.6,
                children: List.generate(
                  homeModel!.data!.products!.length,
                  (index) => buildGridProduct(homeModel.data!.products![index]),
                ),
              ),
            )
          ],
        ),
      );

  Widget buildGridProduct(Products? model) => Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children:[
                Image(
                  image: NetworkImage(
                    model!.image!,
                  ),
                  width: double.infinity,
                  height: 250.0,
                ),
                if(model.discount != 0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.all(4),
                  child:const Text(
                    'DISCOUNT',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style:  TextStyle(
                        height: 1.3,
                        fontSize: 10.0,
                      color: Colors.white
                    ),
                  ),
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(height: 1.3, fontSize: 14.0),
                    ),
                    Row(
                      children: [
                        Text(
                          '${model.price!}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,

                          style: const TextStyle(
                              height: 1.3,
                              fontSize: 14.0,
                              color: defaultColor
                          ),
                        ),
                        const SizedBox(
                            width:10.0
                        ),
                        if(model.discount != 0)
                          Text(
                          '${model.oldPrice!}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                            height: 1.3,
                            fontSize: 12.0,
                            color:Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon:const Icon(Icons.favorite_border),
                            onPressed:() {

                            },

                        ),
                      ],
                    ),
                  ],
                ),
            ),


          ],
        ),
  );
}
