import 'package:jumla/shared/remote/dio_helper.dart';

 class ChangeFavModel{

 late bool status;
  String? message;

 ChangeFavModel.fromJson(Map<String,dynamic> json)
 {
   status=json['status'];
   message=json['message'];
 }
}