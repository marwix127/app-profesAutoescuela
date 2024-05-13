class Event {
  String id = "";
  String title = '';
  String description = '';
  String horaInicial = '';
  String horaFinal = '';

  Event(
    this.id,
    this.title,
    this.description,
    this.horaInicial,
    this.horaFinal,
  );

  Event.fromMapoffline(Map<String, dynamic> map)
      : id = map['id'].toString(),
        title = map['titulo'] ?? '',
        description = map['descripcion'] ?? '',
        horaInicial = map['hora_inicio'] ?? '',
        horaFinal = map['hora_final'];
}
