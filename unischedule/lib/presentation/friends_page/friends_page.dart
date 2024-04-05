import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MaterialApp(
    home: const FriendsApp(),
  ));
}

class FriendsApp extends StatefulWidget {
  const FriendsApp({Key? key}) : super(key: key);

  @override
  _FriendsAppState createState() => _FriendsAppState();
}

class _FriendsAppState extends State<FriendsApp> {
  final TextEditingController _searchController = TextEditingController(); // Controlador para la barra de búsqueda

  @override
  Widget build(BuildContext context) {
    final double itemWidth = MediaQuery.of(context).size.width - 60; // Margen de 30px a cada lado

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/bars.svg',
            width: 21,
            height: 24,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        title: Text(
          'Friends',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/bell.svg',
              width: 21,
              height: 24,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: 15, // Incrementa el conteo en 1 para la barra de búsqueda
            itemBuilder: (context, index) {
              if (index == 0) { // Primera posición para la barra de búsqueda
                // Barra de búsqueda actualizada en el archivo 1
                return Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF686868),
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF686868),
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: SvgPicture.asset(
                            'assets/icons/magnifying-glass.svg',
                            width: 24,
                            height: 24,
                            color: Color(0xFF686868),
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                );

              } else {
                // Ajusta el índice para los elementos de la lista debido a la barra de búsqueda adicional
                int adjustedIndex = index - 1;
                return Container(
                  margin: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(30),
                      right: Radius.circular(16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Image.asset('assets/images/profile_pics/user_${adjustedIndex % 11 + 1}.png'),
                      ),
                      SizedBox(width: itemWidth * 0.03),
                      Text(
                        'Friend $adjustedIndex',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(
                          'assets/icons/comment.svg',
                          width: 24,
                          height: 24,
                          color: Color(0xFF9FA5C0),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          Positioned(
            right: 16, // Ajusta estos valores según tus necesidades
            bottom: 16,
            child: FloatingActionButton(
              onPressed: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF9DCC18), // Color de fondo verde
                  shape: BoxShape
                      .circle, // Forma circular para que coincida con el FAB
                ),
                padding: EdgeInsets.all(
                    0), // Espacio alrededor del icono para reducir el tamaño del fondo verde
                child: SvgPicture.asset(
                  'assets/icons/square-plus.svg',
                  width: 50, // Ancho del icono reducido
                  height: 56, // Altura del icono reducida
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Bordes redondeados
                side: BorderSide(
                  color: Color(0xFF9DCC18), // Color del borde
                  width: 3.8, // Ancho del borde
                ),
              ),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }
}
