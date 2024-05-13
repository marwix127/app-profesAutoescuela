import 'package:flutter/material.dart';

final ThemeData autoescuelAppTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.black87,
  colorScheme: const ColorScheme.light(
    primary: Color.fromARGB(255, 52, 52, 52),
    secondary: Colors.black,
  ),
  //Scaffold
  scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
  //Appbar
  appBarTheme: const AppBarTheme(
    color: Colors.black87,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  //Elevated Button
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black87,
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  ),
  //Bottom Navigation Bar
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.green,
    selectedItemColor: Color.fromARGB(255, 239, 239, 239),
    unselectedItemColor: Colors.white,
  ),
  radioTheme: RadioThemeData(
    fillColor:
        MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.blue; // Color seleccionado
      }
      return Colors.grey; // Color no seleccionado
    }),
  ),
);
