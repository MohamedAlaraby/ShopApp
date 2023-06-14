import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shop_app/models/categories/categories_model.dart';
import 'package:shop_app/models/home/HomeProduct.dart';
import 'package:shop_app/shared/colors.dart';
import '../../models/home/Products.dart';
import '../../shared/components.dart';

class ProductsScreen extends StatelessWidget {
   ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopSuccessChangeFavoritesState){
          if(state.changeFavoritesModel.status==true){
            makeToast(
                message:state.changeFavoritesModel.message,
                toastState:ToastStates.SUCCESS
            );
          }else{
            makeToast(
                message:state.changeFavoritesModel.message,
                toastState:ToastStates.ERROR
            );
          }

        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null  &&  cubit.categoriesModel != null,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) => ProductsBuilder(cubit.homeModel,cubit.categoriesModel,context),
        );
      },
    );
  }
  List<String> images=[];
  void getList(HomeModel model){
      for(int i=0 ;i<4;i++ ){
          model.data?.banners?.forEach((element) {
            if(element.id == 12||element.id == 17||element.id == 24||element.id == 25 ){
               images.add(element.image);
           }
          });

      }
  }
  Widget ProductsBuilder(HomeModel? homeModel,CategoriesModel? categoriesModel,context) {
    getList(homeModel!);

    return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
            items:[
            Image(
            image: NetworkImage( images[0],),
            width: double.infinity,
            fit: BoxFit.cover,
            ),
            Image(
              image: NetworkImage( images[1], ),
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Image(
              image: NetworkImage( images[2],),
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Image(
              image: NetworkImage(images[3],),
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ],
          options: CarouselOptions(
            viewportFraction: 0.8,
            height: 250.0,
            initialPage: 0,
            scrollDirection: Axis.horizontal,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(seconds: 1),
            reverse: false,
            autoPlayCurve: Curves.fastOutSlowIn,

          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Categories',
                style:TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                height: 100,
                child: ListView.separated(
                  physics:const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder:(context, index)=>buildCategoriesItem(categoriesModel.data.categories[index]),
                  separatorBuilder:(context, index) =>const SizedBox(width: 10,),
                  itemCount: categoriesModel!.data.categories.length,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                'New Products',
                style:TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.grey[200],
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            childAspectRatio: 1 / 1.4,
            children: List.generate(
              homeModel!.data!.products!.length,
                  (index) => buildGridProduct(homeModel.data!.products![index],context),
            ),
          ),
        )
      ],
    ),
  );}
  Widget buildGridProduct(Products? model,context) => Container(
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
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
                    fit:BoxFit.contain ,
                    width: double.infinity,
                    height: 120,
                  ),
                  if(model.discount > 0)
                  Container(
                    color: Colors.red,
                    padding:const EdgeInsets.all(4),
                    child:const Text(
                      'DISCOUNT',
                      maxLines: 1,
                      style:  TextStyle(
                          height: 1.2,
                          fontSize: 7.0,
                        color: Colors.white
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Expanded (
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      textAlign:TextAlign.start,
                      model.name!,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(height: 1, fontSize: 12.0),
                    ),
                    Row(
                      children: [
                        Text(
                          '${model.price!}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                              height: 1.3,
                              fontSize: 10.0,
                              color: defaultColor
                          ),
                        ),
                        const SizedBox(
                            width:10.0
                        ),
                        if(model.discount > 0)
                          Text(
                          '${model.oldPrice!}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                            height: 1.3,
                            fontSize:10.0,
                            color:Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: Icon(
                              Icons.favorite,
                              color:ShopCubit.get(context).favorites[model.id]! ? Colors.red :Colors.grey[300]
                          ),
                          color: Colors.white,
                          iconSize:30,
                          onPressed:() {
                              print(model.id);
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
  Widget buildCategoriesItem(CategoryModel category)=> Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
         Image(
            image: NetworkImage(
              category.image
            ),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            ),
           Container(
             width: 100,
             color: Colors.black.withOpacity(0.7,),
             child: Text(
               category.name,
            style:const TextStyle(
            fontSize: 14,

            color: Colors.white
            ),
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow:TextOverflow.ellipsis  ,
             ),
        ),
      ],
  );
}
