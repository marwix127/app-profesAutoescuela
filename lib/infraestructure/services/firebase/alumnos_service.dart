import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:profesor_autoescuela_app/domain/entities/alumno.dart';
import 'package:profesor_autoescuela_app/infraestructure/services/global_data.dart';
import 'package:profesor_autoescuela_app/infraestructure/services/utils/global_functions.dart';

Future<String?> crearAlumnoFB(Alumno nuevoAlumno) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  try {
    await firestore
        .collection('User')
        .doc(GlobalData.userId)
        .collection('alumnos')
        .add({
      'nombre': nuevoAlumno.nombre,
      'apellidos': nuevoAlumno.apellidos,
      'permiso': nuevoAlumno.permiso,
      'estado': 'pendiente',
    });

    return 'Alumno creado con éxito';
  } catch (e) {
    return 'Error al crear alumno';
  }
}

Future<String?> eliminarAlumnoFB(String alumnoId) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  try {
    await firestore
        .collection('User')
        .doc(GlobalData.userId)
        .collection('alumnos')
        .doc(alumnoId)
        .delete();
    return 'Eliminado correctamente';
  } catch (e) {
    return 'error al eliminar alumno';
  }
}

Future<List<Alumno>> obtenerAlumnos() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  try {
    QuerySnapshot querySnapshot = await firestore
        .collection('User')
        .doc(GlobalData.userId)
        .collection('alumnos')
        .get();

    List<Alumno> alumnos = querySnapshot.docs.map((doc) {
      Map<String, dynamic> alumnoData = doc.data() as Map<String, dynamic>;
      alumnoData['id'] = doc.id; // Incluir el ID del documento
      return Alumno.fromMap(alumnoData);
    }).toList();

    return alumnos;
  } catch (e) {
    return [];
  }
}

Future<void> modificarAlumnoFB(Alumno alumno) async {
  var alumnosCollection = FirebaseFirestore.instance
      .collection('User')
      .doc(GlobalData.userId)
      .collection('alumnos');

  try {
    if (alumno.nombre.isNotEmpty) {
      await alumnosCollection.doc(alumno.id).update({'nombre': alumno.nombre});
    }
    if (alumno.apellidos.isNotEmpty) {
      await alumnosCollection
          .doc(alumno.id)
          .update({'apellidos': alumno.apellidos});
    }
    if (alumno.permiso.isNotEmpty) {
      await alumnosCollection
          .doc(alumno.id)
          .update({'permiso': alumno.permiso});
    }
    showToast('Actualizado correctamente');
  } catch (e) {
    showToast('Error al modificar alumno: $e');
  }
}

Future<List<Alumno>> filtrarAlumnosFB({required Alumno alumno}) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  try {
    // Iniciar la consulta con la colección base
    Query query = firestore
        .collection('User')
        .doc(GlobalData.userId)
        .collection('alumnos');

    // Aplicar filtros según los parámetros proporcionados
    if (alumno.nombre.isNotEmpty) {
      query = query.where('nombre', isEqualTo: alumno.nombre);
    }
    if (alumno.apellidos.isNotEmpty) {
      query = query.where('apellidos', isEqualTo: alumno.apellidos);
    }
    if (alumno.permiso.isNotEmpty) {
      query = query.where('permiso', isEqualTo: alumno.permiso);
    }

    // Ejecutar la consulta
    QuerySnapshot querySnapshot = await query.get();

    // Procesar y devolver los resultados
    List<Alumno> alumnos = querySnapshot.docs.map((doc) {
      Map<String, dynamic> alumnoData = doc.data() as Map<String, dynamic>;
      alumnoData['id'] = doc.id; // Incluir el ID del documento
      return Alumno.fromMap(alumnoData);
    }).toList();

    return alumnos;
  } catch (e) {
    return [];
  }
}
