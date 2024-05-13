import 'package:flutter/material.dart';
import 'package:profesor_autoescuela_app/UI/widgets/Dialogs/alumnos_dialog.dart';
import 'package:profesor_autoescuela_app/domain/entities/alumno.dart';
import 'package:profesor_autoescuela_app/UI/widgets/buttons/agregar_button.dart';
import 'package:profesor_autoescuela_app/UI/widgets/texts/alumno_card.dart';
import 'package:profesor_autoescuela_app/blocs/alumnos_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//Pantalla de alumno

class AlumnosCubitScreen extends StatefulWidget {
  const AlumnosCubitScreen({super.key});

  @override
  AlumnosCubitScreenState createState() => AlumnosCubitScreenState();
}

class AlumnosCubitScreenState extends State<AlumnosCubitScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final alumnosCubit = context.read<AlumnosCubit>();
    alumnosCubit.cargarAlumnos();
    return Scaffold(
      body: BlocBuilder<AlumnosCubit, AlumnosState>(
        builder: (context, state) {
          // Inicia con la verificación del primer estado.
          if (state is AlumnosCargados) {
            return _buildAlumnosCargados(state);
          } else if (state is AlumnosCargando) {
            return const Center(child: Text('Cargando...'));
          } else if (state is CargaFallida) {
            return const Center(child: Text('Error al cargar los alumnos'));
          } else if (state is AlumnosFiltradosCargados) {
            return _buildAlumnosFiltradosCargados(state);
          } else if (state is FiltradoFallido) {
            return const Center(child: Text('Error al filtrar los alumnos'));
          } else {
            return const Center(child: Text('Error'));
          }
        },
      ),
      floatingActionButton: AgregarButton(onPressed: () => onPressed()),
    );
  }

  void onPressed() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlumnoDialog(
            titulo: 'Añadir Alumno',
            textRButton: 'Añadir',
            textLButton: 'Cancelar',
            fRButton: (context, alumno) =>
                context.read<AlumnosCubit>().anadirAlumnoCubit(context, alumno),
            fLButton: () {},
          );
        });
  }

// Método para construir el widget cuando los alumnos están cargados.
  Widget _buildAlumnosCargados(AlumnosCargados state) {
    return ListView.builder(
      itemCount: state.alumnosCombinados.length,
      itemBuilder: (context, index) {
        Alumno alumno = state.alumnosCombinados[index];
        return AlumnoCardCubit(alumno: alumno);
      },
    );
  }

// Método para construir el widget cuando los alumnos filtrados están cargados.
  Widget _buildAlumnosFiltradosCargados(AlumnosFiltradosCargados state) {
    return ListView.builder(
      itemCount: state.alumnosFiltradosCombinados.length,
      itemBuilder: (context, index) {
        Alumno alumno = state.alumnosFiltradosCombinados[index];
        return AlumnoCardCubit(alumno: alumno);
      },
    );
  }
}
