import 'package:path/path.dart';
import 'package:profesor_autoescuela_app/domain/entities/evento.dart';
import 'package:profesor_autoescuela_app/infraestructure/services/SQL/user_database.dart';
import 'package:sqflite/sqflite.dart';

class SqlEvents {
  void addEvent(Event event) async {
    final db = await SQLService().database;

    // Inserta el alumno en la base de datos
    await db.insert(
      'eventos',
      {
        'titulo': event.title,
        'descripcion': event.description,
        'hora_inicio': event.horaInicial,
        'hora_final': event.horaFinal
      },
      conflictAlgorithm: ConflictAlgorithm.replace, // O el que sea adecuado
    );
  }

  Future<List<Event>> obtainEvents() async {
    final db = await openDatabase(
      join(await getDatabasesPath(), SQLService.getDatabaseName()),
    );

    final List<Map<String, dynamic>> maps = await db.query('eventos');

    // Convertir cada Map en un objeto Alumno
    return List<Event>.from(maps.map((map) => Event.fromMapoffline(map)));
  }
}
