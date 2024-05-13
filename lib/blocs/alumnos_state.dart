part of 'alumnos_cubit.dart';

abstract class AlumnosState extends Equatable {
  @override
  List<Object> get props => [];
}

class AlumnosInicial extends AlumnosState {}

class AlumnosCargando extends AlumnosState {}

class AlumnosCargados extends AlumnosState {
  final List<Alumno> alumnosCombinados;

  AlumnosCargados(this.alumnosCombinados);

  @override
  List<Object> get props => [alumnosCombinados];
}

class CargaFallida extends AlumnosState {}

class AlumnosFiltrando extends AlumnosState {}

class AlumnosFiltradosCargados extends AlumnosState {
  final List<Alumno> alumnosFiltradosCombinados;

  AlumnosFiltradosCargados(this.alumnosFiltradosCombinados);

  @override
  List<Object> get props => [alumnosFiltradosCombinados];
}

class FiltradoFallido extends AlumnosState {}
