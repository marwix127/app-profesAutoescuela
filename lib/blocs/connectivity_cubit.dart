import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

enum ConnectivityState { connected, disconnected }

class ConectividadCubit extends Cubit<ConnectivityState> {
  final Connectivity _connectivity;

  ConectividadCubit(this._connectivity)
      : super(ConnectivityState.disconnected) {
    _init();
  }

  Future<ConnectivityState> checkConnectivity() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.ethernet ||
        connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      emit(ConnectivityState.connected);
      return ConnectivityState.connected;
    } else {
      emit(ConnectivityState.disconnected);
      return ConnectivityState.disconnected;
    }
  }

  void _init() {
    _connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.ethernet ||
          connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        emit(ConnectivityState.connected);
      } else {
        emit(ConnectivityState.disconnected);
      }
    });
  }
}
