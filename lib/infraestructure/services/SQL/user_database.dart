import 'package:profesor_autoescuela_app/infraestructure/services/global_data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLService {
  Database? _database;

  Future<Database> get database async {
    // Si _database es null, abre la base de datos
    _database ??= await initDataBase();
    return _database!;
  }

  static String getDatabaseName() {
    String userId = GlobalData.userId;
    return 'database_$userId.db';
  }

  static Future<Database> initDataBase() async {
    String dbName = getDatabaseName();

    // Obtiene la ruta de la base de datos
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, dbName);

    // Abre la base de datos
    return await openDatabase(
      dbPath,
      version: 6,
      onCreate: (db, version) async {
        // Crea la tabla si no existe
        await db.execute(
            'CREATE TABLE IF NOT EXISTS alumnos (id INTEGER PRIMARY KEY, nombre TEXT, apellidos TEXT, permiso TEXT)');
        await db.execute(
            'CREATE TABLE IF NOT EXISTS eventos (id INTEGER PRIMARY KEY, titulo TEXT, descripcion TEXT, hora_inicio TEXT, hora_final)');
      },
    );
  }
}
