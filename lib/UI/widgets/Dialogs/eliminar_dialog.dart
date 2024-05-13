import 'package:flutter/material.dart';
import 'package:profesor_autoescuela_app/UI/widgets/buttons/button.dart';

class EliminarDialog extends StatelessWidget {
  final VoidCallback eliminar;
  const EliminarDialog({
    super.key,
    required this.eliminar,
  });

  void botonEliminar(BuildContext context) {
    eliminar();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('¿Estás seguro?'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Esta acción no se puede deshacer'),
        ],
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomElevatedButton(
              text: 'Cancelar',
              onPressed: () => Navigator.of(context).pop(),
            ),
            CustomElevatedButton(
                text: 'Eliminar', onPressed: () => botonEliminar(context))
          ],
        ),
      ],
    );
  }
}
