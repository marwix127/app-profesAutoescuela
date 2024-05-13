// ignore_for_file: unnecessary_const
import 'package:flutter/material.dart';
import 'package:profesor_autoescuela_app/infraestructure/services/SQL/user_database.dart';
import 'package:profesor_autoescuela_app/infraestructure/services/firebase/firebase_authService.dart';
import 'package:profesor_autoescuela_app/infraestructure/services/utils/global_functions.dart';
import 'package:profesor_autoescuela_app/UI/widgets/buttons/IconButtons.dart';
import 'package:profesor_autoescuela_app/UI/widgets/bars/app_bar_custom.dart';
import 'package:profesor_autoescuela_app/UI/widgets/buttons/button.dart';
import 'package:profesor_autoescuela_app/UI/widgets/texts/rounded_text_box.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  Map<String, TextEditingController> controladores = {
    'email': TextEditingController(),
    'password': TextEditingController(),
    'nombre': TextEditingController(),
    'apellidos': TextEditingController(),
    'autoescuela': TextEditingController(),
  };

  FirebaseAuthService authService = FirebaseAuthService();

  String checkEmptyField() {
    for (String key in controladores.keys) {
      if (controladores[key]!.text.isEmpty) {
        return key; // Retorna la clave (identificador) del campo vacío
      }
    }
    return '0'; //if(emailController.tex)
  }

  void _buttonRegister() async {
    String validation = checkEmptyField();
    if (validation == '0') {
      bool result = await authService.register(
          controladores['email']!.text,
          controladores['password']!.text,
          controladores['nombre']!.text,
          controladores['apellidos']!.text,
          controladores['autoescuela']!.text);

      if (result) {
        SQLService.initDataBase();
        Navigator.pushNamed(context, '/home');
      } else {
        //Error
      }
    } else {
      showToast('campo $validation vacio');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Registro',
        actions: <Widget>[
          GoBackIconButton(onPressed: () {
            Navigator.pushNamed(context, '/login');
          }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 70.0),
            CustomTextField(
              controller: controladores['nombre']!,
              labelText: 'Nombre',
              hintText: 'Nombre',
            ),
            const SizedBox(height: 16.0),
            CustomTextField(
              controller: controladores['apellidos']!,
              labelText: 'Apellidos',
              hintText: 'Apellidos',
            ),
            const SizedBox(height: 16.0),
            CustomTextField(
              controller: controladores['autoescuela']!,
              labelText: 'Autoescuela',
              hintText: 'Autoescuela',
            ),
            const SizedBox(height: 16.0),
            CustomTextField(
              controller: controladores['email']!,
              labelText: 'Email',
              hintText: 'Email',
            ),
            const SizedBox(height: 16.0),
            CustomTextField(
              controller: controladores['password']!,
              labelText: 'Contraseña',
              hintText: 'Contraseña',
              obscureText: true,
            ),
            const SizedBox(height: 36.0),
            SizedBox(
              width: 300,
              child: Align(
                child: CustomElevatedButton(
                    text: 'Registrarse', onPressed: _buttonRegister),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
