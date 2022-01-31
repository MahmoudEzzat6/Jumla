
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumla/modouls/shop_model.dart';
import 'package:jumla/shared/cubit/register_states.dart';
import 'package:jumla/shared/local/shared_pref.dart';
import 'package:jumla/shared/remote/dio_helper.dart';
import 'package:jumla/shared/remote/end_points.dart';

class RegisterCubit extends Cubit<ShopRegisterStates>{
  RegisterCubit() : super(ShopRegisterInitialStates());

  static RegisterCubit get(context)=>BlocProvider.of(context);

  ShopModel? loginModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  })
  {
    emit(ShopRegisterLoadingStates());

    DioHelper.postData(
        url: REGISTER ,
        token: CashHelper.getData(key: 'token'),
        data: {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone,

        }
    ).then((value) {

      loginModel=ShopModel.fromjson(value.data);

      emit(ShopRegisterSuccessStates(loginModel!));
      print(loginModel);

    }).catchError((error){
      print('${error.toString()}');
      emit(ShopRegisterErrorStates(error.toString()));
    });
  }
  IconData suffix=Icons.visibility_off_outlined;
  bool isPassword=true;
  void changeSuffixRegisterScreen(){
    isPassword =!isPassword;
    suffix= isPassword ? Icons.visibility_off_outlined :Icons.visibility_outlined;
    emit(ShopRegisterSuffixIconsStates());


  }


}