import 'package:flutter/material.dart';

class CalendarTimeLines extends StatelessWidget {
  const CalendarTimeLines({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
