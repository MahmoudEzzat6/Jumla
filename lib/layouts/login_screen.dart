import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumla/componanes/componanets.dart';
import 'package:jumla/constant/constant.dart';
import 'package:jumla/layouts/register_page.dart';
import 'package:jumla/shared/cubit/login_cubit.dart';
import 'package:jumla/shared/cubit/states.dart';
import 'package:jumla/shared/local/shared_pref.dart';
import 'package:jumla/shared/shop_cubit/shop_cubit.dart';

import 'home_layout.dart';

var mailController = TextEditingController();
var passwordController = TextEditingController();
var formKey = GlobalKey<FormState>();

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child:
          BlocConsumer<LoginCubit, ShopLoginStates>(listener: (context, state) {
        if (state is ShopLoginSuccessStates) {
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
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Market in your hand',
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    color: Colors.white,
                                    fontSize: 28,
                                  ),
                        ),
                      ),
                      Center(
                          child: Image(
                        image: AssetImage('assets/images/shop.png'),
                        height: 250,
                        width: 250,
                      )),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultTextField(
                          color: Colors.white,
                          label: 'Email',
                          prefix: Icons.email_outlined,
                          colors: Colors.white,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value.toString().isEmpty) {
                              return 'This Filed can\'t be empty';
                            }
                          },
                          controller: mailController),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultTextField(
                          color: Colors.white,
                          label: 'Password',
                          prefix: Icons.lock_outline_rounded,
                          type: TextInputType.text,
                          isPassword: LoginCubit.get(context).isPassword,
                          suffix: LoginCubit.get(context).suffix,
                          suffixPress: () {
                            LoginCubit.get(context).changeSuffixLoginScreen();
                          },
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'This Filed can\'t be empty';
                            }
                          },
                          controller: passwordController),
                      SizedBox(
                        height: 20.0,
                      ),
                      state is ShopLoginLoadingStates
                          ? Center(
                              child: CircularProgressIndicator(
                              color: Colors.white60,
                            ))
                          : Center(
                              child: defaultButton(
                                  background: Colors.white,
                                  textColor: Colors.indigo,
                                  text: 'LOGIN',
                                  width: 200,
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      LoginCubit.get(context).userLogin(
                                        email: mailController.text,
                                        password: passwordController.text,
                                      );
                                      passwordController.clear();
                                      // print(token);

                                    } else {
                                      return null;
                                    }
                                  }),
                            ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have account ?',
                            style: TextStyle(color: Colors.white70),
                          ),
                          TextButton(
                              onPressed: () {
                                navigateTo(context, RegisterScreen());
                              },
                              child: Text('Register here'),
                              style:
                                  TextButton.styleFrom(primary: Colors.white)),
                        ],
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
