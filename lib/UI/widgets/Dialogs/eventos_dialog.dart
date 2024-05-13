import 'package:flutter/material.dart';
import 'package:profesor_autoescuela_app/UI/widgets/buttons/button.dart';
import 'package:intl/intl.dart';
import 'package:profesor_autoescuela_app/domain/entities/evento.dart';

class CreateEventDialog extends StatefulWidget {
  final Function fRButton;
  final DateTime dia;
  const CreateEventDialog(
      {super.key, required this.dia, required this.fRButton});

  @override
  CreateEventDialogState createState() => CreateEventDialogState();
}

class CreateEventDialogState extends State<CreateEventDialog> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  TimeOfDay? _horaInicio;
  TimeOfDay? _horaFin;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _seleccionarHoraInicio(BuildContext context) async {
    final TimeOfDay? horaSeleccionada = await showTimePicker(
      context: context,
      initialTime: _horaInicio ?? TimeOfDay.now(),
    );
    if (horaSeleccionada != null && horaSeleccionada != _horaInicio) {
      setState(() {
        _horaInicio = horaSeleccionada;
      });
    }
  }

  Future<void> _seleccionarHoraFin(BuildContext context) async {
    final TimeOfDay? horaSeleccionada = await showTimePicker(
      context: context,
      initialTime: _horaFin ?? TimeOfDay.now(),
    );
    if (horaSeleccionada != null && horaSeleccionada != _horaFin) {
      setState(() {
        _horaFin = horaSeleccionada;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(DateFormat('dd MMMM yyyy', 'es_ES').format(widget.dia)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Titulo'),
              controller: _titleController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Descripción'),
              controller: _descriptionController,
            ),
            ListTile(
              title: Text(
                  'Hora de inicio: ${_horaInicio?.format(context) ?? 'Seleccionar'}'),
              leading: const Icon(Icons.access_time),
              onTap: () {
                _seleccionarHoraInicio(context);
              },
            ),
            ListTile(
              title: Text(
                  'Hora de finalización: ${_horaFin?.format(context) ?? 'Seleccionar'}'),
              leading: const Icon(Icons.access_time),
              onTap: () {
                _seleccionarHoraFin(context);
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
                text: 'Cancelar', onPressed: () => lAction(context)),
            CustomElevatedButton(
              text: 'Guardar',
              onPressed: () => rAction(context),
            )
          ],
        ),
      ],
    );
  }

  void rAction(BuildContext context) {
    Event event = Event('', _titleController.text, _descriptionController.text,
        _horaInicio.toString(), _horaFin.toString());
    widget.fRButton(event);
    Navigator.of(context).pop();
  }

  void lAction(BuildContext context) {
    Navigator.of(context).pop();
  }
}
