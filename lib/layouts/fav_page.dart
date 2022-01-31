import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumla/componanes/componanets.dart';
import 'package:jumla/shared/shop_cubit/shop_cubit.dart';
import 'package:jumla/shared/shop_cubit/states.dart';
import 'package:loading_gifs/loading_gifs.dart';


class FavPage extends StatelessWidget {
  var favController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ProductStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          return ListView.separated(
            physics: BouncingScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                height: 1,
              );
            },

            itemCount: ShopCubit.get(context).favoritesModel!.data.data.length,
            itemBuilder: (BuildContext context, int index) => buildFavListItem(
                ShopCubit.get(context).favoritesModel!.data.data[index].product,
                context),
          );

        }
        );
  }

  Widget buildFavListItem(model, BuildContext context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 135.0,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  FadeInImage.assetNetwork(
                    height: 100.0,
                    width: 100.0,
                    placeholder:circularProgressIndicatorSmall ,
                    image:model.image ,
                    imageErrorBuilder:  (BuildContext context, Object exception,
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
                width: 20.0,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${model.name}',
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            '${model.price} EG',
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.blue),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          if (model.discount != 0)
                            Text(
                              '${model.oldPrice}',
                              style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              ShopCubit.get(context)
                                  .changeFav(model.id);

                            },
                            icon: CircleAvatar(
                                radius: 18.0,
                                backgroundColor: Colors.grey[200],
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                                // ),
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
