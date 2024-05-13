import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AgendaCalendar extends StatefulWidget {
  final Function onDaySelected;
  const AgendaCalendar({super.key, required this.onDaySelected});

  @override
  AgendaCalendarState createState() => AgendaCalendarState();
}

class AgendaCalendarState extends State<AgendaCalendar> {
  @override
  void initState() {
    super.initState();
  }

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
        locale: "es_ES",
        headerStyle:
            const HeaderStyle(formatButtonVisible: false, titleCentered: true),
        availableGestures: AvailableGestures.all,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        focusedDay: _focusedDay,
        firstDay: DateTime.utc(2010),
        lastDay: DateTime.utc(2030),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
          // Aquí es donde se notifica al widget padre sobre la selección del día
          widget.onDaySelected(selectedDay);
        },
        calendarStyle: const CalendarStyle(
          // Color de fondo para el día actual
          todayDecoration: BoxDecoration(
            color: Color.fromARGB(194, 72, 151,
                215), // Ajusta el color de fondo para el día actual
            shape: BoxShape.circle,
          ),
          // Color de fondo para el día enfocado
          selectedDecoration: BoxDecoration(
            color: Color.fromARGB(255, 13, 125,
                200), // Ajusta el color de fondo para el día enfocado/seleccionado
            shape: BoxShape.circle,
          ),
        ));
  }
}
