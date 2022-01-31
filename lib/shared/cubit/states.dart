import 'package:jumla/modouls/shop_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialStates extends ShopLoginStates {}

class ShopLoginSuccessStates extends ShopLoginStates {

  final ShopModel loginModel;
  ShopLoginSuccessStates(this.loginModel);}

class ShopLoginLoadingStates extends ShopLoginStates {}

class ShopLoginErrorStates extends ShopLoginStates {
  final String error;

  ShopLoginErrorStates(this.error);
}

class ShopLoginSuffixIconsStates extends ShopLoginStates {}
