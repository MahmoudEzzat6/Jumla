import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/componanes/componanets.dart';
import 'package:shop_app/layouts/home_layout.dart';
import 'package:shop_app/layouts/login_screen.dart';
import 'package:shop_app/modouls/shop_model.dart';
import 'package:shop_app/shared/local/shared_pref.dart';
import 'package:shop_app/shared/shop_cubit/shop_cubit.dart';
import 'package:shop_app/shared/shop_cubit/states.dart';

String token = '';

void signOut(context) {
  CashHelper.removeData(key: CashHelper.getData(key: 'token'));
  navigateAndFinish(context, LoginScreen());
    ShopCubit.get(context).currentIndex = 0;
}
