// @author: Marcel El Mouhajir Moncunill
// @date: December 2023
// App para la gestión de un profesor de autoescuela
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:profesor_autoescuela_app/infraestructure/services/SQL/user_database.dart';
import 'package:profesor_autoescuela_app/providers/app_providers.dart';
import 'firebase_options.dart';
import 'config/themes/app_theme.dart';
import 'package:profesor_autoescuela_app/config/routes/routes.dart';
import 'package:intl/date_symbol_data_local.dart';

//Inicializa las bases de datos y la App
void main() async {
  //Inicializa los widgets
  WidgetsFlutterBinding.ensureInitialized();
  //Inicializa la base de datos de Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //Inicializa la base de datos local
  SQLService.initDataBase();
  await initializeDateFormatting(
      'es_ES', null); // Inicializa los datos de formato de fecha
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
//
  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Aplicación Profesor Autoescuela Flutter',
        theme: autoescuelAppTheme,
        home: getAppRoutes()['/login']!(context),
        routes: getAppRoutes(),
      ),
    );
  }
}
