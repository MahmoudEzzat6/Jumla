import 'package:flutter/material.dart';


 ThemeData themedata = ThemeData(
   appBarTheme: AppBarTheme(
      color: Colors.white24,
       elevation: 0.0,
     foregroundColor: Colors.black,

   ),
bottomNavigationBarTheme:  BottomNavigationBarThemeData(

 unselectedIconTheme: IconThemeData(
  color: Colors.grey
 ),
 selectedItemColor: Colors.blue,
 type: BottomNavigationBarType.shifting
),
   textTheme: TextTheme(
     bodyText2:  TextStyle(
       fontWeight: FontWeight.bold,
       fontSize: 18.0
     ),
   ),


);