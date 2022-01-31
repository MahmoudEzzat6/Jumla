import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/home_layout.dart';
import 'package:shop_app/layouts/on_boarding_screen.dart';
import 'package:shop_app/layouts/login_screen.dart';
import 'package:shop_app/shared/cubit/blocObserve.dart';
import 'package:shop_app/shared/cubit/search_cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/local/shared_pref.dart';
import 'package:shop_app/shared/shop_cubit/shop_cubit.dart';
import 'package:shop_app/shared/shop_cubit/states.dart';
import 'package:shop_app/style/theme.dart';

import 'shared/cubit/login_cubit.dart';


Widget homeScreen = LoginScreen();

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CashHelper.init();
  bool? onBoarding = CashHelper.getData(key: 'Boarding');
  String? token = CashHelper.getData(key: 'token');

  if (onBoarding != null) {
    if (token != null) {
      homeScreen = HomeLayout();
    } else {
      homeScreen = LoginScreen();
    }
  } else {
    homeScreen = OnBoardingScreen();
  }


  runApp(MyApp(HomeScreen: homeScreen));
}

class MyApp extends StatelessWidget {


  final Widget HomeScreen;

  MyApp({required this.HomeScreen, homeScreen});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) =>ShopCubit()..getHomeData()..getCategoryData()..getFavoriteData()..getUserData()),
        BlocProvider(
            create: (BuildContext context) =>LoginCubit()),
        BlocProvider(
            create: (BuildContext context) =>SearchCubit()),



      ],
      child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themedata,
            home: homeScreen
        ),
      );

  }
}
