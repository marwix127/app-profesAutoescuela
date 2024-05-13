class Alumno {
  String id;
  String nombre = '';
  String apellidos = '';
  String permiso = '';
  bool isSynchronized;

  Alumno(
      this.id, this.nombre, this.apellidos, this.permiso, this.isSynchronized);

  Alumno.fromMap(Map<String, dynamic> map)
      : id = map['id'].toString(),
        nombre = map['nombre'] ?? '',
        apellidos = map['apellidos'] ?? '',
        permiso = map['permiso'] ?? '',
        isSynchronized =
            true; // Asumiendo que los registros de la base de datos están sincronizados

  Alumno.fromMapoffline(Map<String, dynamic> map)
      : id = map['id'].toString(),
        nombre = map['nombre'] ?? '',
        apellidos = map['apellidos'] ?? '',
        permiso = map['permiso'] ?? '',
        isSynchronized = false;
}
