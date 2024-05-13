import 'package:flutter/material.dart';
import 'package:profesor_autoescuela_app/UI/screens/calendar_screen.dart';
import 'package:profesor_autoescuela_app/UI/widgets/Dialogs/alumnos_dialog.dart';
import 'package:profesor_autoescuela_app/blocs/alumnos_cubit.dart';
import 'package:profesor_autoescuela_app/UI/screens/dashboard_screen.dart';
import 'package:profesor_autoescuela_app/UI/screens/alumnos_screen.dart';
import 'package:profesor_autoescuela_app/UI/widgets/bars/app_bar_custom.dart';
import 'package:profesor_autoescuela_app/UI/widgets/bars/bottom_bar.dart';
import 'package:profesor_autoescuela_app/UI/widgets/buttons/IconButtons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profesor_autoescuela_app/infraestructure/services/firebase/firebase_authService.dart';

class MiPantallaPrincipal extends StatefulWidget {
  const MiPantallaPrincipal({super.key});

  @override
  MiPantallaPrincipalState createState() => MiPantallaPrincipalState();
}

class MiPantallaPrincipalState extends State<MiPantallaPrincipal> {
  int _indiceSeleccionado = 0;

  final List<Widget> _bodies = [
    const DashboardScreen(),
    const CalendarScreen(),
    const AlumnosCubitScreen(),
    const AlumnosCubitScreen(),
  ];

  final List<String> _titulos = [
    'Dashboard',
    'Agenda',
    'Notificaciones',
    'Alumnos'
  ];

  void _onItemTapped(int index) {
    setState(() {
      _indiceSeleccionado = index;
    });
  }

  List<Widget> getAccionesAppBar() {
    switch (_indiceSeleccionado) {
      case 0: // DashboardScreen
        return [
          LogOutIconButton(
            onPressed: () => FirebaseAuthService().logOut(context),
          ),
        ];
      case 3: // Alumnos
        return [
          FilterIconButton(onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlumnoDialog(
                    titulo: 'Filtrar Alumnos',
                    textRButton: 'Aplicar',
                    textLButton: 'Limpiar',
                    fLButton: () =>
                        BlocProvider.of<AlumnosCubit>(context).cargarAlumnos(),
                    fRButton: (context, alumno) => context
                        .read<AlumnosCubit>()
                        .filtrarAlumnosCubit(alumno));
              },
            );
          }),
          SyncronizeIconButton(
            onPressed: () =>
                context.read<AlumnosCubit>().sincronizarCubit(context),
          )
        ];

      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: _titulos[_indiceSeleccionado], actions: getAccionesAppBar()),
      body: _bodies.elementAt(_indiceSeleccionado),
      bottomNavigationBar: BarraNavegacion(onItemTapped: _onItemTapped),
    );
  }
}
