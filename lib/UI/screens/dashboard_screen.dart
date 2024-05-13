import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  final String name = 'Nombre y Apellidos';
  final String url =
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 50, // Ajusta este valor según el tamaño deseado
            backgroundImage: NetworkImage(url),
          ),
          const SizedBox(height: 20), // Espacio entre la imagen y el texto
          Text(
            name,
            style: const TextStyle(
              fontSize: 16, // Ajusta este valor según el tamaño deseado
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
