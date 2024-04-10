import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';
import '../../../providers/groups_page/groups_provider.dart'; // Asegúrate de que este sea el proveedor correcto
import '../../../models/groups_page/group_model.dart'; // Importa el modelo de grupo

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupsAsyncValue = ref.watch(groupsProvider('0MebgXs8fBYREjDKMlwq'));

    return Scaffold(
      body: Stack(
        children: <Widget>[
          const HomePageBackground(),
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
              padding: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                color: Color(0xFFF8F8F8),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(37)),
              ),
              height: 393, // Ajusta esta altura según sea necesario
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '   My Groups',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: groupsAsyncValue.when(
                      data: (groups) => ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: groups.length,
                        itemBuilder: (context, index) {
                          final Group group = groups[index];
                          return buildGroupCard(group, index); // Pasando ambos argumentos requeridos aquí
                        },
                      ),
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (error, stack) => Center(child: Text('Error: $error')),
                    ),

                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '   My Events',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Expanded(

                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          10, // Define la cantidad de eventos estáticos que quieres mostrar
                      itemBuilder: (context, index) {
                        return buildEventCard(
                            index); // Usa una función helper para construir las tarjetas de eventos
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
            child: Image.asset(
              "assets/images/sticker.png",
              height: 197,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGroupCard(Group group, int index) {
    String formattedName = group.name.length > 7 ? '${group.name.substring(0, 7)}...' : group.name;
    final bgColor = Color(int.parse(group.color.replaceAll('#', '0xff')));
    Color colorMasOscuro = bgColor
        .withRed(max(0, bgColor.red - 30))
        .withGreen(max(0, bgColor.green - 30))
        .withBlue(max(0, bgColor.blue - 30));

    return Container(
      width: 150,
      height: 112,
      margin: const EdgeInsets.only(left: 19, right: 19, bottom: 15),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 10),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                formattedName,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: CustomPaint(
              size: const Size(100, 100),
              painter: MyCustomPainter(colorMasOscuro),
            ),
          ),
          Positioned(
            right: 8,
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
            left: 14,
            top: 8,
            // Usa un widget Text para mostrar el icono
            child: Text(
              group.icon, // Usa directamente el atributo icon del objeto group
              style: TextStyle(
                fontSize: 20, // Puedes ajustar el tamaño según sea necesario
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget buildEventCard(int index) {
    return Container(
      width: 234,
      height: 112,
      // Añade un margen en la parte inferior además de los márgenes horizontales
      margin: const EdgeInsets.only(left: 19, right: 19, bottom: 20),
      decoration: BoxDecoration(
        color: index % 2 == 0 ? Color(0xFFFF7878) : Color(0xFF78BEFF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 10),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Event $index',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: CustomPaint(
              size: const Size(100, 100),
              painter: MyCustomPainter(index % 2 == 0 ? Color(0xFFFF4848) : Color(0XFF4870FF)),
            ),
          ),
          Positioned(
            right: 8,
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
            left: 12,
            top: 12,
            child: SvgPicture.asset(
              'assets/icons/fire.svg',
              width: 24,
              height: 24,
              color: Colors.white,
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
