import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightTheme =ThemeData(
  primarySwatch: Colors.deepOrange,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.deepOrange),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    backgroundColor: Colors.white,
    elevation: 5.0,
    titleSpacing: 8.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.deepOrange,
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    elevation: 30.0,
    unselectedItemColor: Colors.grey,
    backgroundColor: Colors.white,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.deepOrange,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.black,
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
    ),
    subtitle1: TextStyle(
      color: Colors.black,
      fontSize: 18.8,
      fontWeight: FontWeight.w700,
    ),
    subtitle2: TextStyle(
      color: Colors.black,
      fontSize: 16.8,
      fontWeight: FontWeight.w700,
    ),
  ),
);



ThemeData darkTheme =ThemeData(
  primarySwatch: Colors.deepOrange,
  appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: Colors.deepOrange),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: HexColor('333739'),
      elevation: 5.0,
      titleSpacing: 8.0,
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.deepOrange,
          statusBarIconBrightness: Brightness.light)),
  scaffoldBackgroundColor: HexColor('333739'),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: HexColor('333739'),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.deepOrange,
  ),
  textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: Colors.white,
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
      ),
      subtitle1: TextStyle(
        color: Colors.white,
        fontSize: 18.8,
        fontWeight: FontWeight.w700,
      ),
      subtitle2: TextStyle(
      color: Colors.white,
      fontSize: 16.8,
      fontWeight: FontWeight.w700,
    ),
  ),

);