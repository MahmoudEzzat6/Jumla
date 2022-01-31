import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:shop_app/componanes/componanets.dart';
import 'package:shop_app/modouls/category_model.dart';
import 'package:shop_app/modouls/get_fav_model.dart';
import 'package:shop_app/modouls/home_model.dart';
import 'package:shop_app/modouls/products_details_model.dart';
import 'package:shop_app/modouls/products_model.dart';
import 'package:shop_app/modouls/shop_model.dart';
import 'package:shop_app/shared/shop_cubit/shop_cubit.dart';
import 'package:shop_app/shared/shop_cubit/states.dart';

class ProductsData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ProductStates>(
      listener: (BuildContext context, state) {
        int? index = ShopCubit
            .get(context)
            .loginModel!
            .data!
            .id;
      },
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          appBar: AppBar(),
          body: buildCatItem(ShopCubit
              .get(context)
              .homeModel
              ?.data
              .products[0]
          ),
        );
      },

    );
  }

  Widget buildCatItem(ProductModel? model) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    FadeInImage.assetNetwork(
                      height: 200.0,
                      width: 200.0,
                      placeholder: circularProgressIndicatorSmall,
                      image: model!.image,
                      imageErrorBuilder: (BuildContext context,
                          Object exception,
                          StackTrace? stackTrace) {
                        return imageError();
                      },
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
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.name,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${model.price.round()} EG',
                            style: TextStyle(
                                fontSize: 16.0, color: Colors.blue),
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
                        ],
                      ),
                      Divider(
                        height: 25.0, color: Colors.grey, thickness: 0.3,),
                      Text(
                        'Description',
                        style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                      ),
                      SizedBox(height: 10,),
                      Text('''
Size: 6.7 inches

Resolution: 2778 x 1284 pixels, 458 PPI

Technology: OLED

Screen-to-body: 87.45 %

Peak brightness: 1200 cd/m2 (nit)

Features: HDR video support, Oleophobic coating, Scratch-resistant glass (Ceramic Shield), Ambient light sensor, Proximity sensor                       HARDWARE

System chip: Apple A14 Bionic

Processor: Hexa-core, 64-bit, 5 nm

GPU: Yes

RAM: 6GB LPDDR5

Internal storage: 128GB (NVMe), not expandable

Device type: Smartphone

OS: iOS (14.x)

BATTERY
  Type: Li - Ion, Not user replaceable
  Charging: USB Power Delivery, Qi wireless charging, MagSafe wireless charging
  Max charge speed: Wireless: 15.0W

CAMERA:
  Rear: Triple camera'
  Main camera: 12 MP (OIS, PDAF)'
  Specifications: Ap''',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16.0,

                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
