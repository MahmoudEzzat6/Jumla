
import 'package:buildcondition/buildcondition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumla/componanes/componanets.dart';
import 'package:jumla/layouts/product_data.dart';
import 'package:jumla/modouls/category_model.dart';
import 'package:jumla/modouls/home_model.dart';
import 'package:jumla/shared/shop_cubit/shop_cubit.dart';
import 'package:jumla/shared/shop_cubit/states.dart';
import 'package:loading_gifs/loading_gifs.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    ShopCubit cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ProductStates>(
      listener: (BuildContext context, state) {
        if (state is OnSuccessFavChangeStates) {
          if (cubit.changeFavModel!.status == false) {
            toastShow('Check Internet Connection...', ToastStates.Error);
          }
        }
        },
      builder: (BuildContext context, Object? state) {
        return BuildCondition(
          condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoryModel!=null,
          builder: (context) =>
              productBuilder(ShopCubit.get(context).homeModel,ShopCubit.get(context).categoryModel,context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productBuilder(HomeModel? model,CategoryModel? catModel, context) => SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model!.data.banners
                  .map(
                    (e) =>  CachedNetworkImage(
                      width: double.infinity,
                      fit: BoxFit.cover,
                      imageUrl: e.image,
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 210.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 2),
                autoPlayAnimationDuration: Duration(seconds: 2),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1.0,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2.0,
                  ),
                  Text(
                    'Categories',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 75,
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,int index) => builCatItem( catModel!.data.dataModel[index]),
                        separatorBuilder: (context, index) => SizedBox(
                              width: 6,
                            ),
                        itemCount: catModel!.data.dataModel.length
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    'New Products',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),

                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                shrinkWrap: true,
                childAspectRatio: 1 / 1.46,
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(
                    model.data.products.length,
                    (index) =>
                        buildGridProduct(model.data.products[index], context),
                ),
              ),
            ),
          ],
        ),
      );

  Widget builCatItem(DataModel model) => Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          FadeInImage.assetNetwork(
            height: 100.0,
            width: 100.0,
            fit: BoxFit.cover,
            placeholder:circularProgressIndicatorSmall ,
            image:model.image ,
            imageErrorBuilder:  (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return imageError();
            },

          ),
          Container(
            width: 100.0,
            color: Colors.black.withOpacity(0.8),
            child: Text(
              model.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
  Widget buildGridProduct(ProductModel model, context) => InkWell(
    onTap: (){

      navigateTo(context, ProductsData());
    },

    child: Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              CachedNetworkImage(
                imageUrl: model.image,
                  height: 120.0,
                  width: double.infinity,

              ),
              if (model.discount != 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  color: Colors.redAccent,
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                ),

            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()} EG',
                      style: TextStyle(fontSize: 14.0, color: Colors.blue),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round()}',
                        style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeFav(model.id);
                          },
                      icon: CircleAvatar(
                        radius: 18.0,
                        backgroundColor: Colors.grey[200],
                        child: Icon(
                          ShopCubit.get(context).favorites[model.id] == true
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                        ),
                      ),
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
  Widget circleLoading()=>CircularProgressIndicator();
}
