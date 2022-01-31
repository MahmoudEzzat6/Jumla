import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumla/shared/shop_cubit/shop_cubit.dart';
import 'package:jumla/componanes/componanets.dart';
import 'package:jumla/layouts/shop_search.dart';
import 'package:jumla/shared/shop_cubit/shop_cubit.dart';
import 'package:jumla/shared/shop_cubit/states.dart';


class HomeLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ProductStates>(
        listener: (BuildContext context, Object? state) {},
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                  'jumla',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: 24)),
              actions: [
                IconButton(
                    onPressed:( ){
                      navigateTo(context,ShopSearch());
                    },
                    icon: Icon(Icons.search))
              ],
            ),
            body: ShopCubit.get(context).navBar[cubit.currentIndex],
              bottomNavigationBar: BottomNavyBar(
                itemCornerRadius: 25.0,
                animationDuration:Duration(milliseconds: 450,),
                selectedIndex: cubit.currentIndex,
                showElevation: true, // use this to remove appBar's elevation
                onItemSelected: (index) {
                  cubit.onChangePage(index);
                },
                items: [
                  BottomNavyBarItem(
                    icon: Icon(Icons.home),
                    title: Text('Home'),
                    activeColor: Colors.red,
                  ),
                  BottomNavyBarItem(
                      icon: Icon(Icons.category),
                      title: Text('category'),
                      activeColor: Colors.purpleAccent
                  ),
                  BottomNavyBarItem(
                      icon: Icon(Icons.favorite_rounded),
                      title: Text('Favourite'),
                      activeColor: Colors.pink
                  ),
                  BottomNavyBarItem(
                      icon: Icon(Icons.settings),
                      title: Text('Settings'),
                      activeColor: Colors.blue
                  ),
                ],
              ),
          );
        });
  }
}
