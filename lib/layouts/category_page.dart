import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumla/componanes/componanets.dart';
import 'package:jumla/modouls/category_model.dart';
import 'package:jumla/shared/shop_cubit/shop_cubit.dart';
import 'package:jumla/shared/shop_cubit/states.dart';
import 'package:loading_gifs/loading_gifs.dart';


class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ProductStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        return ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return Divider(height: 1,);
            },
          itemCount: ShopCubit.get(context).categoryModel!.data.dataModel.length
          ,
          itemBuilder: (BuildContext context, int index) =>buildCatItem(ShopCubit.get(context).categoryModel!.data.dataModel[index]),
        );
      },
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        FadeInImage.assetNetwork(
          height: 90.0,
          width: 90.0,
          fit: BoxFit.cover,
          placeholder:circularProgressIndicatorSmall ,
          image:model.image ,
          imageErrorBuilder:  (BuildContext context, Object exception,
              StackTrace? stackTrace) {
            return imageError();
          },
        ),
        SizedBox(width: 10.0,),
        Text(model.name),
        Spacer(),
        Icon(Icons.arrow_forward_ios),
      ],
    ),
  );

}
