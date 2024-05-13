import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profesor_autoescuela_app/UI/widgets/Dialogs/alumnos_dialog.dart';
import 'package:profesor_autoescuela_app/domain/entities/alumno.dart';
import 'package:profesor_autoescuela_app/UI/widgets/Dialogs/eliminar_dialog.dart';
import 'package:profesor_autoescuela_app/blocs/alumnos_cubit.dart';

class AlumnoCardCubit extends StatelessWidget {
  final Alumno alumno;

  const AlumnoCardCubit({super.key, required this.alumno});

  void eliminarAlumnoCallback(BuildContext context, Alumno alumno) {
    final alumnoCubit = BlocProvider.of<AlumnosCubit>(context);
    alumnoCubit.eliminarAlumnoCubit(alumno);
  }

  @override
  Widget build(BuildContext context) {
    Color containerColor = alumno.isSynchronized
        ? const Color.fromARGB(120, 40, 154, 247)
        : const Color.fromARGB(55, 108, 180, 239);

    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Container(
        color: containerColor,
        child: ListTile(
          title: Text('${alumno.nombre} ${alumno.apellidos}'
              '  ['
              '${alumno.permiso}'
              ']'),
          trailing: Row(
              mainAxisSize: MainAxisSize.min, // Importante para evitar overflow
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.edit),
                  color: Colors.black,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlumnoDialog(
                          titulo: 'Modificar Alumno',
                          textLButton: 'Cancelar',
                          textRButton: 'Guardar',
                          fLButton: () {},
                          fRButton: (context, alumno) => context
                              .read<AlumnosCubit>()
                              .modificarAlumnoCubit(context, alumno),
                          alumno: alumno,
                        );
                      },
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  color: Colors.black,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return EliminarDialog(
                          eliminar: () =>
                              eliminarAlumnoCallback(context, alumno),
                        );
                      },
                    );
                  },
                ),
              ]),
        ),
      ),
    );
  }
}
