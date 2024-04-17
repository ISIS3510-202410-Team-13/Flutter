import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BackgroundImage extends ConsumerStatefulWidget {
  const BackgroundImage({super.key});

  @override
  ConsumerState<BackgroundImage> createState() => _BackgroundImage();
}

class _BackgroundImage extends ConsumerState<BackgroundImage> {
  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: 0.75,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.jpg'), // TODO make this dynamic
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
