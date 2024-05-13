import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:profesor_autoescuela_app/infraestructure/services/global_data.dart';
import 'package:profesor_autoescuela_app/infraestructure/services/utils/global_functions.dart';

class FirebaseAuthService {
  //*final
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  FirebaseAuth get auth => _auth;

  set auth(FirebaseAuth newAuth) {
    // Aquí podrías realizar alguna validación si es necesario
    _auth = newAuth;
  }

  Future<String> signInWithFirebase(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      GlobalData.userId = _auth.currentUser?.uid ?? '';
      return '200'; // Retorna el usuario en caso de éxito
    } on FirebaseAuthException catch (e) {
      return (e.code);
    } catch (e) {
      return '-1';
    }
  }

  Future<UserCredential> createUser(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      showToast(e.toString());
      rethrow;
    }
  }

  Future<void> createUserProfile(
      User user, String name, String lastName, String autoescuela) async {
    DocumentReference profesorRef = _db.collection('User').doc(user.uid);

    await profesorRef.set({
      'Nombre': name,
      'Apellidos': lastName,
      'Autoescuela': autoescuela,
      // Agrega aquí otros campos que necesites
    });

    DocumentReference alumnoRef = profesorRef.collection('alumnos').doc();
    await alumnoRef.set({
      'nombre': '',
      'apellidos': '',
      'estado': '',
      'tipo_permiso': '',
      // otros datos relevantes
    });
  }

  Future<bool> register(email, password, autoescuela, nombre, apellidos) async {
    try {
      var userCredential = await createUser(
        email,
        password,
      );
      if (userCredential.user != null) {
        await createUserProfile(
          userCredential.user!,
          nombre,
          apellidos,
          autoescuela,
        );
        GlobalData.userId = _auth.currentUser?.uid ?? '';
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  void logOut(BuildContext context) async {
    await signOut();
    Navigator.pushNamed(context, '/login');
  }

  Future<void> signOut() async {
    GlobalData.userId = '';
    await _auth.signOut();
  }
}
