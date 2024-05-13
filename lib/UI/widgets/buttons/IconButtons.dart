import 'package:flutter/material.dart';

class SyncronizeIconButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SyncronizeIconButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.sync),
        onPressed: onPressed,
        color: Colors.white // Estilo específico para el botón de sincronizar
        // Estilo específico para el botón de eliminar
        );
  }
}

class LogOutIconButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LogOutIconButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.logout),
        onPressed: onPressed,
        color: Colors.white // Estilo específico para el botón de editar
        );
  }
}

class GoBackIconButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoBackIconButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: onPressed,
        color: Colors.white // Estilo específico para el botón de editar
        );
  }
}

class FilterIconButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FilterIconButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.search),
        onPressed: onPressed,
        color: Colors.white // Estilo específico para el botón de editar
        );
  }
}
