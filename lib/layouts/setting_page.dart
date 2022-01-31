import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jumla/componanes/componanets.dart';
import 'package:jumla/constant/constant.dart';
import 'package:jumla/shared/shop_cubit/shop_cubit.dart';
import 'package:jumla/shared/shop_cubit/states.dart';

class SettingPage extends StatelessWidget {

  var emailController=TextEditingController();
  var nameController=TextEditingController();
  var phoneController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ProductStates>(
      listener: (context,state) {},
      builder: (context,state){
        var model =ShopCubit.get(context).loginModel;
        nameController.text=model!.data!.name!;
        emailController.text=model.data!.email!;
        phoneController.text=model.data!.phone!;
        return BuildCondition(
         condition: ShopCubit.get(context).loginModel !=null,
          builder:(context)=> Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultTextField(

                        prefix: Icons.person,
                        validate: (String? name ) {
                          if(name==null){
                            return('can\'t be empty');
                          }
                        },
                        controller: nameController,
                        label: 'UserName',color: Colors.indigo),
                    SizedBox(
                      height: 15.0,
                    ),

                    defaultTextField(
                      textColor: Colors.black,
                        prefix: Icons.email_outlined,
                        validate: (String? mail ) {
                          if(mail==null){
                            return('can\'t be empty');
                          }
                        },
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        label: 'E-mail',color: Colors.indigo),
                    SizedBox(
                      height: 15.0,
                    ),

                    defaultTextField(
                        prefix: Icons.phone_android,
                        validate: (String? phone ) {
                          if(phone==null){
                            return('can\'t be empty');
                          }
                        },
                        controller: phoneController,
                        type: TextInputType.phone,
                        label: 'Phone',color: Colors.indigo),

                    SizedBox(
                      height: 20.0,
                    ),

                   state is ShopLoadingUpdateUserDataState ? LinearProgressIndicator():
                   defaultButton(
                     textColor: Colors.white,
                      background: Colors.indigo,
                      text: 'Update',
                    onTap: () {
                      ShopCubit.get(context).getUpdateUserData(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text);

                                toastShow('Updated Successfully',
                                    ToastStates.Success);}
                  ),
                    SizedBox(
                      height: 20.0,
                    ),

                    defaultButton(
                        textColor: Colors.white,
                        background: Colors.indigo,
                        text: 'LOGOUT',
                        onTap: () {
                          signOut(context);
                          print(token);
                        }

                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
