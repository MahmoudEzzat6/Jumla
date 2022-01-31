import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumla/componanes/componanets.dart';
import 'package:jumla/layouts/category_page.dart';
import 'package:jumla/layouts/fav_page.dart';
import 'package:jumla/layouts/product_page.dart';
import 'package:jumla/layouts/setting_page.dart';
import 'package:jumla/modouls/category_model.dart';
import 'package:jumla/modouls/fav_model.dart';
import 'package:jumla/modouls/get_fav_model.dart';
import 'package:jumla/modouls/home_model.dart';
import 'package:jumla/modouls/products_details_model.dart';
import 'package:jumla/modouls/shop_model.dart';
import 'package:jumla/shared/local/shared_pref.dart';
import 'package:jumla/shared/remote/dio_helper.dart';
import 'package:jumla/shared/remote/end_points.dart';
import 'package:jumla/shared/shop_cubit/states.dart';


class ShopCubit extends Cubit<ProductStates> {
  ShopCubit() : super(ShopInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  late Map<dynamic, dynamic> favorites = {};

  List<Widget> navBar = [
    ProductPage(),
    CategoryPage(),
    FavPage(),
    SettingPage(),
  ];

  void onChangePage(index) {
    currentIndex = index;
    emit(OnChangeStates());
  }

  HomeModel? homeModel;

  void getHomeData() {
    emit(OnLoadingGetDataStates());
    DioHelper.getData(url: Home, token: CashHelper.getData(key: 'token'))
        .then((value) {
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel?.data.banners[0].image);

      homeModel!.data.products.forEach((element) {
        favorites.addAll({element.id: element.inFavourite});
      });
      emit(OnSuccessGetDataStates());
    }).catchError((error) {
      emit(OnErrorGetDataStates());
      print(error.toString());
    });
  }

  CategoryModel? categoryModel;

  void getCategoryData() {
    DioHelper.getData(
      url: GetCategory,
    ).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);

      emit(OnSuccessGetCategoryDataStates());
    }).catchError((error) {
      emit(OnSuccessGetCategoryDataStates());
      print(error.toString());
    });
  }

  ChangeFavModel? changeFavModel;

  void changeFav(int productID) {
    favorites[productID] = !favorites[productID];
    emit(ChangeFavoritesManuallySuccessState());

    DioHelper.postData(
      url: FAVORITES,
      data: {'product_id': productID},
      token: CashHelper.getData(key: 'token'),
    ).then((value) {
      changeFavModel = ChangeFavModel.fromJson(value.data);
      if (changeFavModel!.status == false)
        favorites[productID] = !favorites[productID];
      else {
        getFavoriteData();
      }
      emit(OnSuccessFavChangeStates(changeFavModel!));
      //print(changeFavModel!.message);
    }).catchError((error) {
      favorites[productID] = !favorites[productID];
      emit(OnErrorFavChangeStates());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavoriteData() {
    DioHelper.getData(
      url: FAVORITES,
      token: CashHelper.getData(key: 'token'),
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      print(value.data);
      emit(ShopSuccessFavoritesState());
    }).catchError((error) {
      emit(ShopErrorFavoritesState());
    });
  }

  ShopModel? loginModel;

  void getUserData() {
    DioHelper.getData(
      url: PROFILE,
      token: CashHelper.getData(key: 'token'),
    ).then((value) {
      loginModel = ShopModel.fromjson(value.data);
      //print(value.data);
      emit(ShopSuccessUserDataState(loginModel!));
    }).catchError((error) {
      emit(ShopErrorUserDataState());
    });
  }

  void getUpdateUserData({
    required name,
    required email,
    required phone,
  }) {
    emit(ShopLoadingUpdateUserDataState());

    DioHelper.putData(
      url: UPDATE,
      token: CashHelper.getData(key: 'token'),
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      loginModel = ShopModel.fromjson(value.data);
      emit(ShopSuccessUpdateUserDataState(loginModel!));
    }).catchError((error) {
      emit(ShopErrorUpdateUserDataState());
      toastShow('error', ToastStates.Error);
    });
  }

  ProductDetailsModel? productDetailsModel;

  void getProductData() {
    emit(ShopLoadingProductsDetailsDataState());
    DioHelper.getData(
      url: 'products/',
      token: CashHelper.getData(key: 'token'),
    ).then((value) {
      productDetailsModel = ProductDetailsModel.fromJson(value.data);
      print(value.data);
      emit(ShopSuccessProductsDetailsDataState());
    }).catchError((error) {
      emit(ShopErrorProductsDetailsDataState());
      print(error.toString());
    });
  }
}
