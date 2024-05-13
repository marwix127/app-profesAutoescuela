import 'package:flutter/material.dart';
import 'package:profesor_autoescuela_app/UI/screens/calendar_screen.dart';
import 'package:profesor_autoescuela_app/UI/screens/main_screen.dart';
import 'package:profesor_autoescuela_app/UI/screens/alumnos_screen.dart';
import 'package:profesor_autoescuela_app/UI/screens/login_screen.dart';
import 'package:profesor_autoescuela_app/UI/screens/register_screen.dart';
// Importa el resto de las pantallas aquí

Map<String, WidgetBuilder> getAppRoutes() {
  return {
    '/home': (context) => const MiPantallaPrincipal(),
    '/login': (context) => const LoginScreen(),
    '/register': (context) => const RegisterScreen(),
    '/alumnosCubit': (context) => const AlumnosCubitScreen(),
    '/agenda': (context) => const CalendarScreen()
    // Define el resto de las rutas aquí
  };
}
