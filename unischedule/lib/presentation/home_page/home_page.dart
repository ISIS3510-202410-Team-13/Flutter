import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_auth/local_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          HomePageBackground(),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: SvgPicture.asset('assets/icons/bars.svg',
                    width: 21, height: 24, color: Colors.white),
                onPressed: () {},
              ),
              actions: <Widget>[
                IconButton(
                  icon: SvgPicture.asset('assets/icons/bell.svg',
                      width: 21, height: 24, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: Color(0xFFF8F8F8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(37),
                ),
              ),
              height: 393,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '   My Groups',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          fontWeight:
                          FontWeight.w600, // 600 corresponde a SemiBold
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Container(
                              width: 137,
                              height: 112,
                              margin: EdgeInsets.symmetric(horizontal: 19),
                              decoration: BoxDecoration(
                                color: index % 2 == 0
                                    ? Color(0XFFFF7648)
                                    : Color(0XFF8F98FF),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 20, bottom: 10),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    'Group $index',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight
                                          .w600, // Puedes ajustar esto según lo "negrita" que quieras que sea el texto. w600 es aproximadamente semibold
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 18.9,
                              top: 0,
                              child: CustomPaint(
                                size: Size(100, 100),
                                painter: MyCustomPainter(
                                  index % 2 == 0
                                      ? Color(0xFFFFC278)
                                      : Color(0xFF182A88),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 25,
                              top: 5,
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
                              left: 36,
                              top: 12,
                              child: SvgPicture.asset(
                                'assets/icons/face-angry.svg',
                                width: 24,
                                height: 24,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '   My events',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          fontWeight:
                          FontWeight.w600, // 600 corresponde a SemiBold
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Container(
                              width: 234,
                              height: 112,
                              margin: EdgeInsets.symmetric(horizontal: 19),
                              decoration: BoxDecoration(
                                color: index % 2 == 0
                                    ? Color(0xFFFF7878)
                                    : Color(0xFF78BEFF),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 20, bottom: 10),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    'Event $index', // $index será reemplazado por el valor actual de la variable index
                                    style: TextStyle(
                                      fontFamily:
                                      'Poppins', // Especifica la familia de fuentes
                                      fontSize:
                                      16, // Establece el tamaño de fuente a 16
                                      fontWeight: FontWeight
                                          .w600, // Puedes ajustar esto según lo "negrita" que quieras que sea el texto. w600 es aproximadamente semibold
                                      color: Colors
                                          .white, // 600 corresponde a SemiBold en muchas fuentes, incluida Poppins
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 18.9,
                              top: 0,
                              child: CustomPaint(
                                size: Size(100,
                                    100), // Tamaño del pintor personalizado
                                painter: MyCustomPainter(index % 2 == 0
                                    ? Color(0xFFFF4848)
                                    : Color(0XFF4870FF)),
                              ),
                            ),
                            Positioned(
                              right: 25,
                              top: 5,
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
                                left: 36,
                                top: 12,
                                child: SvgPicture.asset(
                                  'assets/icons/fire.svg',
                                  width: 24,
                                  height: 24,
                                  color: Colors
                                      .white, // Esto aplica el color blanco al icono
                                )),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 353,
            child: Container(
              child: Image.asset(
                "assets/images/sticker.png",
                height: 197,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class HomePageBackground extends StatelessWidget {
  const HomePageBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: 0.75,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: const Center(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 50.0, top: 120.0),
                child: Text(
                  'Hey, David!',
                  style: TextStyle(
                    fontFamily:
                    'Poppins', // Asegúrate de que 'Poppins' esté agregada y configurada en tu pubspec.yaml
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Colors
                        .white, // Puedes ajustar esto según lo "negrita" que quieras que sea el texto
                    shadows: [
                      Shadow(
                        offset: Offset(
                            5, 4), // Desplazamiento x=5, y=4 para la sombra
                        blurRadius: 4, // Radio de desenfoque de la sombra
                        color: Colors.black, // Color negro con 50% de opacidad
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

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