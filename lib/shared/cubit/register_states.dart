import 'package:shop_app/modouls/shop_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialStates extends ShopRegisterStates {}

class ShopRegisterSuccessStates extends ShopRegisterStates {

  final ShopModel loginModel;
  ShopRegisterSuccessStates(this.loginModel);}

class ShopRegisterLoadingStates extends ShopRegisterStates {}

class ShopRegisterErrorStates extends ShopRegisterStates {
  final String error;

  ShopRegisterErrorStates(this.error);
}

class ShopRegisterSuffixIconsStates extends ShopRegisterStates {}
