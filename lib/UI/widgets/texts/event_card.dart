import 'package:flutter/material.dart';

import 'package:profesor_autoescuela_app/domain/entities/alumno.dart';

import 'package:profesor_autoescuela_app/domain/entities/evento.dart';

class AlumnoCardCubit extends StatelessWidget {
  final Event event;

  const AlumnoCardCubit({super.key, required this.event});

  void eliminarAlumnoCallback(BuildContext context, Alumno alumno) {}

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Container(
        color: Colors.green,
        child: ListTile(
          title: Text('${event.title} ${event.horaInicial}'
              ' - '
              '${event.horaFinal}'),
          trailing: Row(
              mainAxisSize: MainAxisSize.min, // Importante para evitar overflow
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.edit),
                  color: Colors.black,
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  color: Colors.black,
                  onPressed: () {},
                ),
              ]),
        ),
      ),
    );
  }
}
