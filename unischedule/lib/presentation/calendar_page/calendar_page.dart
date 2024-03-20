import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalendarApp extends StatefulWidget {
  const CalendarApp({Key? key}) : super(key: key);

  @override
  _CalendarAppState createState() => _CalendarAppState();
}

class _CalendarAppState extends State<CalendarApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          const CalendarAppBackground(),
          ..._buildSquarePlusIcon(context),
          Column(
            children: [
              _buildAppBar(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      25, 0, 40, 0), // Margen aplicado solo a los lados
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment
                        .start, // Alinea el contenido al inicio de la columna
                    children: [
                      _buildWeekDays(),
                      Expanded(
                        child: _buildTimeLines(context),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset('assets/icons/bars.svg',
            width: 21, height: 24, color: Colors.white),
        onPressed: () {},
      ),
      title: Text(
        'February',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset('assets/icons/bell.svg',
              width: 21, height: 24, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  List<Widget> _buildSquarePlusIcon(BuildContext context) {
    return [
      Positioned(
        right: 11,
        bottom: 11 + MediaQuery.of(context).padding.bottom,
        child: SvgPicture.asset(
          'assets/icons/square-plus.svg',
          width: 50,
          height: 56,
          color: Colors.white,
        ),
      ),
    ];
  }

  Widget _buildWeekDays() {
    List<String> days = ['M 26', 'T 27', 'W 28', 'T 29', 'F 01'];
    return Padding(
      padding: const EdgeInsets.only(
          top: 8.0,
          bottom: 8.0,
          left: 20), // Espacio arriba y abajo para el padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: days
            .map((day) => Text(
                  day,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: day == 'W 28' ? 18 : 16,
                    fontWeight:
                        day == 'W 28' ? FontWeight.bold : FontWeight.normal,
                    color: Colors.white,
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildTimeLines(BuildContext context) {
    // Dimensiones para las cajas de eventos
    final double boxHeight = 50; // Altura de dos horas (31px por hora)
    final double boxWidth = MediaQuery.of(context).size.width -
        80; // Ancho disponible menos el margen y la hora

    return Stack(
      children: [
        // Lineas de tiempo estaticas
        Column(
          children: List.generate(10, (index) {
            final time = 8 + index; // Horario inicial a las 8:00
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Row(
                children: [
                  SizedBox(
                    child: Text(
                      '$time:00',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 8,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Divider(color: Colors.white, thickness: 0.6),
                  ),
                ],
              ),
            );
          }),
        ),
        // Caja de evento
        Positioned(
          top: 34, // La altura de una hora desde las 8:00 (empieza en 8:00)
          left: (boxWidth / 5) * 0 + 25, // Posición para el miércoles
          child: Stack(
            children: [
              Container(
                width: boxWidth / 5 - 10, // Ancho para el evento
                height: boxHeight * 2, // Altura de dos horas
                decoration: BoxDecoration(
                  color: Color(0xFF8F98FF).withOpacity(0.7),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    'MOS',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
              Positioned(
                top: 5,
                left: 5,
                child: Text(
                  '8:00',
                  style: TextStyle(color: Colors.white, fontSize: 6),
                ),
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: Text(
                  '9:30',
                  style: TextStyle(color: Colors.white, fontSize: 6),
                ),
              ),
            ],
          ),
        ),

        Positioned(
          top: 34, // La altura de una hora desde las 8:00 (empieza en 8:00)
          left: (boxWidth / 5) * 2 + 25, // Posición para el miércoles
          child: Stack(
            children: [
              Container(
                width: boxWidth / 5 - 10, // Ancho para el evento
                height: boxHeight * 2, // Altura de dos horas
                decoration: BoxDecoration(
                  color: Color(0xFF8F98FF).withOpacity(0.7),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    'MOS',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
              Positioned(
                top: 5,
                left: 5,
                child: Text(
                  '8:00',
                  style: TextStyle(color: Colors.white, fontSize: 6),
                ),
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: Text(
                  '9:30',
                  style: TextStyle(color: Colors.white, fontSize: 6),
                ),
              ),
            ],
          ),
        ),

        Positioned(
          top: 34, // La altura de una hora desde las 8:00 (empieza en 8:00)
          left: (boxWidth / 5) * 4 + 25, // Posición para el miércoles
          child: Stack(
            children: [
              Container(
                width: boxWidth / 5 - 10, // Ancho para el evento
                height: boxHeight * 2, // Altura de dos horas
                decoration: BoxDecoration(
                  color: Color(0xFF8F98FF).withOpacity(0.7),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    'MOS',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
              Positioned(
                top: 5,
                left: 5,
                child: Text(
                  '8:00',
                  style: TextStyle(color: Colors.white, fontSize: 6),
                ),
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: Text(
                  '9:30',
                  style: TextStyle(color: Colors.white, fontSize: 6),
                ),
              ),
            ],
          ),
        ),

        Positioned(
          top: 231, // La altura de una hora desde las 8:00 (empieza en 8:00)
          left: (boxWidth / 5) * 1 + 25, // Posición para el miércoles
          child: Stack(
            children: [
              Container(
                width: boxWidth / 5 - 10, // Ancho para el evento
                height: boxHeight * 2, // Altura de dos horas
                decoration: BoxDecoration(
                  color: Color(0xFFFF7648).withOpacity(0.7),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    'LyM',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
              Positioned(
                top: 5,
                left: 5,
                child: Text(
                  '11:00',
                  style: TextStyle(color: Colors.white, fontSize: 6),
                ),
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: Text(
                  '12:30',
                  style: TextStyle(color: Colors.white, fontSize: 6),
                ),
              ),
            ],
          ),
        ),

        Positioned(
          top: 231, // La altura de una hora desde las 8:00 (empieza en 8:00)
          left: (boxWidth / 5) * 3 + 25, // Posición para el miércoles
          child: Stack(
            children: [
              Container(
                width: boxWidth / 5 - 10, // Ancho para el evento
                height: boxHeight * 2, // Altura de dos horas
                decoration: BoxDecoration(
                  color: Color(0xFFFF7648).withOpacity(0.7),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    'LyM',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
              Positioned(
                top: 5,
                left: 5,
                child: Text(
                  '11:00',
                  style: TextStyle(color: Colors.white, fontSize: 6),
                ),
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: Text(
                  '12:30',
                  style: TextStyle(color: Colors.white, fontSize: 6),
                ),
              ),
            ],
          ),
        ),

        Positioned(
          top: 429, // La altura de una hora desde las 8:00 (empieza en 8:00)
          left: (boxWidth / 5) * 1 + 25, // Posición para el miércoles
          child: Stack(
            children: [
              Container(
                width: boxWidth / 5 - 10, // Ancho para el evento
                height: boxHeight * 2, // Altura de dos horas
                decoration: BoxDecoration(
                  color: Color(0xFFFF7878).withOpacity(0.7),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    'DSW',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
              Positioned(
                top: 5,
                left: 5,
                child: Text(
                  '14:00',
                  style: TextStyle(color: Colors.white, fontSize: 6),
                ),
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: Text(
                  '15:30',
                  style: TextStyle(color: Colors.white, fontSize: 6),
                ),
              ),
            ],
          ),
        ),

        Positioned(
          top: 429, // La altura de una hora desde las 8:00 (empieza en 8:00)
          left: (boxWidth / 5) * 4 + 25, // Posición para el miércoles
          child: Stack(
            children: [
              Container(
                width: boxWidth / 5 - 10, // Ancho para el evento
                height: boxHeight * 2, // Altura de dos horas
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    'Soccer',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
              Positioned(
                top: 5,
                left: 5,
                child: Text(
                  '14:00',
                  style: TextStyle(color: Colors.white, fontSize: 6),
                ),
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: Text(
                  '15:30',
                  style: TextStyle(color: Colors.white, fontSize: 6),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CalendarAppBackground extends StatelessWidget {
  const CalendarAppBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.7,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CalendarApp(),
  ));
}