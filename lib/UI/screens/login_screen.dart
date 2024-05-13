import 'package:flutter/material.dart';
import 'package:profesor_autoescuela_app/infraestructure/services/SQL/user_database.dart';
import 'package:profesor_autoescuela_app/infraestructure/services/firebase/firebase_authService.dart';
import 'package:profesor_autoescuela_app/UI/widgets/bars/app_bar_custom.dart';
import 'package:profesor_autoescuela_app/UI/widgets/texts/rounded_text_box.dart';
import 'package:profesor_autoescuela_app/UI/widgets/buttons/button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String _loginMessage = '';
  FirebaseAuthService authService = FirebaseAuthService();

  void _updateLoginMessage(String message) {
    setState(() {
      _loginMessage = message;
    });
  }

  void _buttonLogin() async {
    String result = await authService.signInWithFirebase(
        emailController.text, passwordController.text);
    if (result == '200') {
      SQLService.initDataBase();
      Navigator.pushNamed(context, '/home');
    } else if (result == '-1') {
      _updateLoginMessage('Error');
    } else {
      _updateLoginMessage(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Login',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              controller: emailController,
              labelText: 'Email',
              hintText: 'Email',
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: passwordController,
              labelText: 'Password',
              hintText: 'Password',
              obscureText: true,
            ),
            const SizedBox(height: 16),
            CustomElevatedButton(text: 'Login', onPressed: _buttonLogin),
            const SizedBox(height: 8),
            if (_loginMessage.isNotEmpty)
              Text(
                _loginMessage,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const Text(
                'No tienes cuenta? Regístrate',
                style: TextStyle(
                  color: Colors.blue, // Color azul para simular un enlace
                  // Subrayado para simular un enlace
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
