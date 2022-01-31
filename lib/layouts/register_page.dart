import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumla/componanes/componanets.dart';
import 'package:jumla/constant/constant.dart';
import 'package:jumla/shared/cubit/register_cubit.dart';
import 'package:jumla/shared/cubit/register_states.dart';
import 'package:jumla/shared/local/shared_pref.dart';
import 'package:jumla/shared/shop_cubit/shop_cubit.dart';

import 'home_layout.dart';


var mailController = TextEditingController();
var passwordController = TextEditingController();
var phoneController = TextEditingController();
var nameController = TextEditingController();
var formKey = GlobalKey<FormState>();

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, ShopRegisterStates>(
          listener: (context, state) {
        if (state is ShopRegisterSuccessStates) {
          if (state.loginModel.data != null) {
            CashHelper.saveData(
                    key: 'token', value: state.loginModel.data!.token)
                .then((value) {
              token = state.loginModel.data!.token!;

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => BlocProvider.value(
                      value: ShopCubit()
                        ..getHomeData()
                        ..getCategoryData()
                        ..getFavoriteData()
                        ..getUserData(),
                      child: HomeLayout()),
                ),
                (Route<dynamic> route) => false,
              );
            });
          } else {
            toastShow('${state.loginModel.message}', ToastStates.Error);
          }
        }
      }, builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.indigo,
          appBar: AppBar(
            backgroundColor: Colors.indigo,
            iconTheme: IconThemeData(color: Colors.white),
            elevation: 0.9,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Register',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Register Now to Buy what you need',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.white70,
                              fontSize: 18.0,
                            ),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      defaultTextField(
                          label: 'Name',
                          color: Colors.white,
                          prefix: Icons.person,
                          type: TextInputType.text,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'This Filed can\'t be empty';
                            }
                          },
                          controller: nameController),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultTextField(
                          label: 'Email',
                          color: Colors.white,
                          prefix: Icons.email_outlined,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value.toString().isEmpty) {
                              return 'This Filed can\'t be empty';
                            }
                          },
                          controller: mailController),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultTextField(
                          color: Colors.white,
                          label: 'Password',
                          prefix: Icons.lock_outline_rounded,
                          type: TextInputType.text,
                          isPassword: RegisterCubit.get(context).isPassword,
                          suffix: RegisterCubit.get(context).suffix,
                          suffixPress: () {
                            RegisterCubit.get(context)
                                .changeSuffixRegisterScreen();
                          },
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'This Filed can\'t be empty';
                            }
                          },
                          controller: passwordController),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultTextField(
                          color: Colors.white,
                          label: 'Phone',
                          prefix: Icons.phone_android_rounded,
                          type: TextInputType.phone,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'This Filed can\'t be empty';
                            }
                          },
                          controller: phoneController),
                      SizedBox(
                        height: 20.0,
                      ),
                      state is ShopRegisterLoadingStates
                          ? Center(child: LinearProgressIndicator())
                          : Center(
                              child: defaultButton(
                                  width: 300,
                                  background: Colors.white,
                                  textColor: Colors.indigo,
                                  text: 'Register',
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      RegisterCubit.get(context).userRegister(
                                        email: mailController.text,
                                        password: passwordController.text,
                                        name: nameController.text,
                                        phone: phoneController.text,
                                      );
                                    } else {
                                      return null;
                                    }
                                  }),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
