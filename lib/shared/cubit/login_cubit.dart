import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumla/constant/constant.dart';
import 'package:jumla/modouls/shop_model.dart';
import 'package:jumla/shared/cubit/states.dart';
import 'package:jumla/shared/local/shared_pref.dart';
import 'package:jumla/shared/remote/dio_helper.dart';
import 'package:jumla/shared/remote/end_points.dart';
import 'package:jumla/shared/shop_cubit/states.dart';

class LoginCubit extends Cubit<ShopLoginStates>{
  LoginCubit() : super(ShopLoginInitialStates());

 static LoginCubit get(context)=>BlocProvider.of(context);

  ShopModel? loginModel;

  void userLogin({
  required String email,
  required String password,
})
  {
    emit(ShopLoginLoadingStates());

    DioHelper.postData(
        url: Login ,
        token: CashHelper.getData(key: 'token'),
        data: {
          'email':email,
          'password':password

        }
    ).then((value) {

     loginModel=ShopModel.fromjson(value.data);
     token = '${loginModel?.data?.token}';
      emit(ShopLoginSuccessStates(loginModel!));

    }).catchError((error){
      print('${error.toString()}');
      emit(ShopLoginErrorStates(error.toString()));
    });
  }
  IconData suffix=Icons.visibility_off_outlined;
  bool isPassword=true;
  void changeSuffixLoginScreen(){
    isPassword =!isPassword;
    suffix= isPassword ? Icons.visibility_off_outlined :Icons.visibility_outlined;
    emit(ShopLoginSuffixIconsStates());
  }


}