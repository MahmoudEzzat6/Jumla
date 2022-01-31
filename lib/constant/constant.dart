import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumla/componanes/componanets.dart';
import 'package:jumla/layouts/login_screen.dart';
import 'package:jumla/shared/local/shared_pref.dart';
import 'package:jumla/shared/shop_cubit/shop_cubit.dart';

String token = '';

void signOut(context) {
  CashHelper.removeData(key: CashHelper.getData(key: 'token'));
  navigateAndFinish(context, LoginScreen());
    ShopCubit.get(context).currentIndex = 0;
}
