import 'package:flutter/material.dart';
import 'package:profesor_autoescuela_app/UI/widgets/buttons/button.dart';
import 'package:profesor_autoescuela_app/domain/entities/alumno.dart';

class AlumnoDialog extends StatefulWidget {
  final String titulo;
  final String textRButton;
  final String textLButton;
  final void Function(BuildContext context, Alumno alumno) fRButton;
  final Function fLButton;
  final Alumno? alumno;

  const AlumnoDialog(
      {super.key,
      required this.titulo,
      required this.textRButton,
      required this.textLButton,
      required this.fLButton,
      required this.fRButton,
      this.alumno});

  @override
  AlumnoDialogState createState() => AlumnoDialogState();
}

class AlumnoDialogState extends State<AlumnoDialog> {
  late TextEditingController _nombreController;
  late TextEditingController _apellidosController;
  late String _permisoValue;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController();
    _apellidosController = TextEditingController();
    _permisoValue = widget.alumno?.permiso ?? 'A';
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidosController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.titulo),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration:
                  InputDecoration(labelText: widget.alumno?.nombre ?? 'Nombre'),
              controller: _nombreController,
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: widget.alumno?.apellidos ?? 'Apellidos'),
              controller: _apellidosController,
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Permiso'),
              value: _permisoValue,
              items: <String>['A', 'B', 'C', 'D'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _permisoValue = newValue!;
                });
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomElevatedButton(
                text: widget.textLButton, onPressed: () => lAction(context)),
            CustomElevatedButton(
              text: widget.textRButton,
              onPressed: () => rAction(context),
            )
          ],
        ),
      ],
    );
  }

  void lAction(BuildContext context) {
    widget.fLButton();
    Navigator.of(context).pop();
  }

  void rAction(BuildContext context) {
    Alumno alumno = Alumno(
        widget.alumno?.id ?? '',
        _nombreController.text,
        _apellidosController.text,
        _permisoValue,
        widget.alumno?.isSynchronized ?? false);
    widget.fRButton(context, alumno);
    Navigator.of(context).pop();
  }
}
