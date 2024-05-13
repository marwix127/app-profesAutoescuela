import 'package:profesor_autoescuela_app/domain/entities/alumno.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:profesor_autoescuela_app/infraestructure/services/SQL/user_database.dart';

class SqlAlumnos {
  Future<Alumno> insertarAlumno(Alumno alumno) async {
    // Obtén la instancia de la base de datos
    final db = await SQLService().database;

    // Inserta el alumno en la base de datos
    await db.insert(
      'alumnos',
      {
        'nombre': alumno.nombre,
        'apellidos': alumno.apellidos,
        'permiso': alumno.permiso,
      },
      conflictAlgorithm: ConflictAlgorithm.replace, // O el que sea adecuado
    );
    return alumno;
  }

  static Future<List<Alumno>> obtenerAlumnos() async {
    final db = await openDatabase(
      join(await getDatabasesPath(), SQLService.getDatabaseName()),
    );

    final List<Map<String, dynamic>> maps = await db.query('alumnos');

    // Convertir cada Map en un objeto Alumno
    return List<Alumno>.from(maps.map((map) => Alumno.fromMapoffline(map)));
  }

  static Future<void> eliminarAlumnoBD(String id) async {
    final db = await openDatabase(
      join(await getDatabasesPath(), SQLService.getDatabaseName()),
    );

    await db.delete(
      'alumnos',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<void> modificarAlumno(Alumno alumno) async {
    final db = await openDatabase(
      join(await getDatabasesPath(), SQLService.getDatabaseName()),
    );
    if (alumno.nombre.isNotEmpty) {
      await db.update(
        'alumnos',
        {'nombre': alumno.nombre},
        where: "id = ?",
        whereArgs: [alumno.id],
      );
    }
    if (alumno.apellidos.isNotEmpty) {
      await db.update(
        'alumnos',
        {'apellidos': alumno.apellidos},
        where: "id = ?",
        whereArgs: [alumno.id],
      );
    }
    if (alumno.permiso.isNotEmpty) {
      await db.update(
        'alumnos',
        {'permiso': alumno.permiso},
        where: "id = ?",
        whereArgs: [alumno.id],
      );
    }
  }

  static Future<List<Alumno>> filtrarAlumnos(Alumno alumno) async {
    final db = await openDatabase(
      join(await getDatabasesPath(), SQLService.getDatabaseName()),
    );
    // Lista para almacenar las cláusulas WHERE
    List<String> clausulas = [];
    List<Object> argumentos = [];

    // Agregar condiciones a la consulta en base a los parámetros
    if (alumno.permiso.isNotEmpty) {
      clausulas.add('permiso = ?');
      argumentos.add(alumno.permiso);
    }
    if (alumno.nombre.isNotEmpty) {
      clausulas.add('nombre = ?');
      argumentos.add(alumno.nombre);
    }
    if (alumno.apellidos.isNotEmpty) {
      clausulas.add('apellidos = ?');
      argumentos.add(alumno.apellidos);
    }

    // Construir la consulta SQL final
    String? whereString = clausulas.isNotEmpty ? clausulas.join(' AND ') : null;

    // Ejecutar la consulta
    final List<Map<String, dynamic>> maps = await db.query(
      'alumnos',
      where: whereString,
      whereArgs: argumentos.isNotEmpty ? argumentos : null,
    );
    // Convertir cada Map en un objeto Alumno
    return List<Alumno>.from(maps.map((map) => Alumno.fromMapoffline(map)));
  }

  static Future<void> deleteDatabase() async {
    final db = await openDatabase(
      join(await getDatabasesPath(), SQLService.getDatabaseName()),
    );
    await db.delete('alumnos');
  }

  Future<void> closeDatabase() async {
    // Espera a obtener la instancia de la base de datos.
    final db = await SQLService().database;
    // Una vez obtenida la instancia, cierra la base de datos.
    await db.close();
  }
}
