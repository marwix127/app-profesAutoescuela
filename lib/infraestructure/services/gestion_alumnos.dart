import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:profesor_autoescuela_app/domain/entities/alumno.dart';
import 'package:profesor_autoescuela_app/infraestructure/services/SQL/user_database.dart';
import 'package:profesor_autoescuela_app/infraestructure/services/firebase/alumnos_service.dart';
import 'package:profesor_autoescuela_app/infraestructure/services/SQL/alumnos_service.dart';
import 'package:profesor_autoescuela_app/blocs/connectivity_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profesor_autoescuela_app/infraestructure/services/utils/global_functions.dart';
import 'package:sqflite/sqflite.dart';

void eliminarAlumno(Alumno alumno) async {
  if (alumno.isSynchronized == true) {
    await eliminarAlumnoFB(alumno.id);
  } else {
    await SqlAlumnos.eliminarAlumnoBD(alumno.id);
  }
}

void anadir(BuildContext context, Alumno nuevoAlumno) async {
  final conectividadCubit = context.read<ConectividadCubit>();
  ConnectivityState connectivityState =
      await conectividadCubit.checkConnectivity();

  if (connectivityState == ConnectivityState.connected) {
    // Acciones si está conectado

    await crearAlumnoFB(nuevoAlumno);
  } else {
    // Acciones si está desconectado

    await SqlAlumnos().insertarAlumno(nuevoAlumno);
  }
}

Future<void> sincronizarAlumnos(BuildContext context) async {
  final conectividadCubit = context.read<ConectividadCubit>();
  ConnectivityState connectivityState =
      await conectividadCubit.checkConnectivity();
  if (connectivityState == ConnectivityState.connected) {
    // hay conexión a Internet

    try {
      final db = await openDatabase(
        join(await getDatabasesPath(), SQLService.getDatabaseName()),
      );

      // Consultar la tabla 'alumnos'
      final List<Map<String, dynamic>> maps = await db.query('alumnos');

      // Iterar sobre cada alumno de la tabla
      for (var alumnos in maps) {
        // Extraer los datos individuales del alumno
        Alumno nuevoAlumno = Alumno("0", alumnos['nombre'],
            alumnos['apellidos'], alumnos['permiso'], true);

        // Llamar a la función crearAlumno con los datos del alumno actual
        crearAlumnoFB(nuevoAlumno);
        // Eliminar de la BD local
        await SqlAlumnos.eliminarAlumnoBD(alumnos['id'].toString());
      }
    } catch (e) {
      // En caso de algún error durante la sincronización
      showToast('Error durante la Sincronizacion');
    }
    showToast('Sincronizacion completada');
  } else {
    showToast('Sin Conexion');
  }
}

Future<void> modificarAlumno(
  BuildContext context,
  Alumno alumno,
) async {
  final conectividadCubit = context.read<ConectividadCubit>();
  ConnectivityState connectivityState =
      await conectividadCubit.checkConnectivity();

  if (connectivityState == ConnectivityState.connected) {
    // El dispositivo está online
    if (!alumno.isSynchronized) {
      SqlAlumnos.modificarAlumno(alumno);
    } else {
      await modificarAlumnoFB(alumno);
    }
  } else {
    // El dispositivo está offline
    if (alumno.isSynchronized) {
      showToast('Error de conexión.No se han podido guardar los cambios');
    } else {
      SqlAlumnos.modificarAlumno(alumno);
    }
  }
}
