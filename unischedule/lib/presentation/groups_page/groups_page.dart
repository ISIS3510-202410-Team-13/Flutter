import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';
import 'package:go_router/go_router.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  TextEditingController _searchController =
      TextEditingController(); // Add a TextEditingController for the search bar
  List<Color> colors_bg = [
    Color(0XFFFF7648), // Color for index 0
    Color(0XFF78BEFF), // Example color for index 4
    Color(0XFFFF8FB7), // Example color for index 2
    Color(0XFFFF7878), // Example color for index 3
    Color(0XFF8F98FF), // Color for index 1
  ];

  List<Color> colors_bubble = [
    Color(0xFFFFC278),
    Color(0xFF182A88),
    Color(0xFF881869),
    Color(0xFFFF4848),
    Color(0xFF182A88),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Groups',
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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              width: 350,
              decoration: BoxDecoration(
                color: Color(
                    0xFFD9D9D9), // Set the background color of the search bar
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color:
                        Color(0xFF686868), // Set the color of the search icon
                  ),
                  border:
                      InputBorder.none, // Remove the border of the search bar
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Número de grupos
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      width: 350,
                      height: 133,
                      margin: EdgeInsets.symmetric(horizontal: 19),
                      decoration: BoxDecoration(
                        color: colors_bg[index %
                            colors_bg.length], // Select color based on index
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20, bottom: 10),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'Group ${index+1}',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 32,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: CustomPaint(
                              size: Size(100, 100),
                              painter: MyCustomPainter(
                                  colors_bubble[index % colors_bubble.length]),
                            ),
                          ),
                          Positioned(
                            right: 10,
                            top: 10,
                            child: Column(
                              children: [
                                Container(
                                  width: 5,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Container(
                                  width: 5,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            left: 10,
                            top: 12,
                            child: ProfileIconsRow(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        height:
                            10), // Add a SizedBox to separate the elements vertically
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
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
    );
  }
}

// Rest of the code...
class MyCustomPainter extends CustomPainter {
  final Paint myPaint;

  MyCustomPainter(Color color) : myPaint = Paint()..color = color;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = myPaint.color;

    var path = Path();
    // Comienza en la esquina superior derecha
    path.moveTo(size.width * 0.25, 0);

    // Agrega puntos al Path que describan la forma de la mancha de manera irregular
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.25,
        size.width * 0.5, size.height * 0.3);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.35,
        size.width * 0.4, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.55, size.height * 0.8,
        size.width * 0.7, size.height * 0.9);
    path.quadraticBezierTo(
        size.width * 0.85, size.height, size.width, size.height * 0.75);

    // Regresa a la esquina superior derecha para cerrar el Path
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class ProfileIconsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120, // Hacer que el contenedor ocupe todo el ancho disponible
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.green,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                ),
              ),
              child: Image.asset(
                  'assets/images/profile_pics/user_${Random().nextInt(11) + 1}.png'),
            ),
          ),
          Positioned(
            left: 20,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.red,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
                child: Image.asset(
                    'assets/images/profile_pics/user_${Random().nextInt(11) + 1}.png'),
              ),
            ),
          ),
          Positioned(
            left: 0,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blue,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
                child: Image.asset(
                    'assets/images/profile_pics/user_${Random().nextInt(11) + 1}.png'),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(6, 8, 16, 8),
            alignment: Alignment.centerRight,
            child: Text(
              '+${Random().nextInt(5) + 1}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
