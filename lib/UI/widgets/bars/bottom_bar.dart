import 'package:flutter/material.dart';

class BarraNavegacion extends StatefulWidget {
  final Function(int index) onItemTapped;
  const BarraNavegacion({super.key, required this.onItemTapped});

  @override
  BarraNavegacionState createState() => BarraNavegacionState();
}

class BarraNavegacionState extends State<BarraNavegacion> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: true,
      showUnselectedLabels: false,
      elevation: 0,
      backgroundColor:
          Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      unselectedItemColor:
          Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
      selectedItemColor:
          Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
        widget.onItemTapped(index);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.house),
          label: 'Home',
          backgroundColor: Colors.black87,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Agenda',
          backgroundColor: Colors.black87,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notifications',
          backgroundColor: Colors.black87,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Alumnos',
          backgroundColor: Colors.black87,
        ),
      ],
    );
  }
}
