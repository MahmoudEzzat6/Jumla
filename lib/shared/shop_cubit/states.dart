import 'package:jumla/modouls/fav_model.dart';
import 'package:jumla/modouls/shop_model.dart';

abstract class ProductStates {}

class ShopInitialStates extends ProductStates {}

class OnChangeStates extends ProductStates {}

class OnLoadingGetDataStates extends ProductStates {}

class OnSuccessGetDataStates extends ProductStates {}

class OnErrorGetDataStates extends ProductStates {}

class OnSuccessGetCategoryDataStates extends ProductStates {}

class OnErrorGetCategoryDataStates extends ProductStates {}

class OnSuccessFavChangeStates extends ProductStates {
  late final OnSuccessFavChangeStates changeFavModel;

  OnSuccessFavChangeStates(ChangeFavModel changeFavModel);
}

class OnErrorFavChangeStates extends ProductStates {}

class ChangeFavoritesManuallySuccessState extends ProductStates {}

class ShopSuccessFavoritesState extends ProductStates {}

class ShopErrorFavoritesState extends ProductStates {}

class ShopSuccessUserDataState extends ProductStates {
  final ShopModel loginModel;

  ShopSuccessUserDataState(this.loginModel);
}

class ShopErrorUserDataState extends ProductStates {}

class ShopSuccessUpdateUserDataState extends ProductStates {
  final ShopModel loginModel;

  ShopSuccessUpdateUserDataState(this.loginModel);
}

class ShopLoadingUpdateUserDataState extends ProductStates {}

class ShopErrorUpdateUserDataState extends ProductStates {}

class ShopSuccessProductsDetailsDataState extends ProductStates {}

class ShopLoadingProductsDetailsDataState extends ProductStates {}

class ShopErrorProductsDetailsDataState extends ProductStates {}
