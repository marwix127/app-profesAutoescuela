import 'package:flutter/material.dart';
import 'package:profesor_autoescuela_app/UI/widgets/Dialogs/eventos_dialog.dart';
import 'package:profesor_autoescuela_app/UI/widgets/buttons/agregar_button.dart';
import 'package:profesor_autoescuela_app/UI/widgets/calendar.dart';
import 'package:profesor_autoescuela_app/domain/entities/evento.dart';
import 'package:profesor_autoescuela_app/infraestructure/services/SQL/eventos_service.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  CalendarScreenState createState() => CalendarScreenState();
}

class CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDay = DateTime.now();
  void _onDaySelected(DateTime day) {
    setState(() {
      _selectedDay = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2, // Ajusta la proporción si es necesario
              child: AgendaCalendar(onDaySelected: _onDaySelected),
            ),
            Expanded(
              flex:
                  2, // Ajusta la proporción según necesites más espacio para la lista
              child: FutureBuilder<List<Event>>(
                future: _cargarEventos(), // La función que carga los eventos
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child:
                            CircularProgressIndicator()); // Mostrar un indicador de carga
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: Text(
                            "Error al cargar los eventos")); // Manejo de errores
                  } else if (snapshot.hasData) {
                    // Construir la lista de eventos si hay datos
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final evento = snapshot.data![index];
                        return ListTile(
                          title: Text(evento.title +
                              ' ' +
                              evento.horaInicial.toString() +
                              '-' +
                              evento.horaFinal
                                  .toString()), // Asegúrate de que tu clase Event tenga un miembro titulo
                          // Agrega más propiedades según tu clase Event
                        );
                      },
                    );
                  } else {
                    return const Center(
                        child: Text(
                            "No hay eventos disponibles")); // Manejar el caso de lista vacía
                  }
                },
              ),
            ),
          ],
        ),
        floatingActionButton: AgregarButton(onPressed: () => _onPressed()));
  }

  Future<List<Event>> _cargarEventos() async {
    List<Event> eventos = await SqlEvents().obtainEvents();
    return eventos;
  }

  void _onPressed() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CreateEventDialog(
            dia: _selectedDay,
            fRButton: (event) => SqlEvents().addEvent(event),
          );
        });
  }
}
