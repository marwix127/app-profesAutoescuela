import 'package:flutter/material.dart';

class AgregarButton extends StatelessWidget {
  final Function onPressed;

  const AgregarButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
        onPressed: () => onPressed());
  }
}
