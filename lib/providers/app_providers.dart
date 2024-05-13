// app_providers.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:profesor_autoescuela_app/blocs/connectivity_cubit.dart';
import 'package:profesor_autoescuela_app/blocs/alumnos_cubit.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AlumnosCubit>(
          create: (context) => AlumnosCubit(),
        ),
        BlocProvider<ConectividadCubit>(
          create: (context) => ConectividadCubit(Connectivity()),
        ),
      ],
      child: child,
    );
  }
}
