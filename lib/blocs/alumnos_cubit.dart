import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profesor_autoescuela_app/domain/entities/alumno.dart';
import 'package:profesor_autoescuela_app/infraestructure/services/firebase/alumnos_service.dart';
import 'package:profesor_autoescuela_app/infraestructure/services/SQL/alumnos_service.dart';
import 'package:flutter/material.dart';
import 'package:profesor_autoescuela_app/infraestructure/services/gestion_alumnos.dart';
import 'package:equatable/equatable.dart';
part 'alumnos_state.dart';

class AlumnosCubit extends Cubit<AlumnosState> {
  //AlumnosCubit(super.initialState);

  AlumnosCubit() : super(AlumnosInicial());

  Future<void> cargarAlumnos() async {
    try {
      emit(AlumnosCargando());
      List<Alumno> alumnosFireBase = await obtenerAlumnos();
      List<Alumno> alumnosSQL = await SqlAlumnos.obtenerAlumnos();
      List<Alumno> alumnosCombinados = alumnosFireBase + alumnosSQL;
      emit(AlumnosCargados(alumnosCombinados));
    } catch (e) {
      emit(CargaFallida());
    }
  }

  void anadirAlumnoCubit(BuildContext context, Alumno alumno) {
    anadir(context, alumno);
  }

  void sincronizarCubit(BuildContext context) async {
    await sincronizarAlumnos(context);
  }

  void eliminarAlumnoCubit(Alumno alumno) {
    eliminarAlumno(alumno);
  }

  void modificarAlumnoCubit(BuildContext context, Alumno alumno) {
    modificarAlumno(context, alumno);
  }

  void filtrarAlumnosCubit(Alumno alumno) async {
    try {
      emit(AlumnosFiltrando());
      List<Alumno> alumnosFiltradosFireBase =
          await filtrarAlumnosFB(alumno: alumno);
      List<Alumno> alumnosFiltradosSQL =
          await SqlAlumnos.filtrarAlumnos(alumno);
      List<Alumno> alumnosFiltradosCombinados =
          alumnosFiltradosFireBase + alumnosFiltradosSQL;
      emit(AlumnosFiltradosCargados(alumnosFiltradosCombinados));
    } catch (e) {
      emit(FiltradoFallido());
    }
  }
}
