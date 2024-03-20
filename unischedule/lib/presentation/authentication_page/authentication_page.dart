import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {

  late final LocalAuthentication auth;
  bool _supportState = false;

  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then((isSupported) {
      setState(() {
        _supportState = isSupported;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
  body: Container(
    width: double.infinity,
    height: double.infinity,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/bg.jpg'),
        fit: BoxFit.cover,
      ),
    ),
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: Text(
            'UniSchedule',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal, color: Colors.white),
          ),
        ),
        SizedBox(height: 20.0), // Add space between 'Hi David!' and the button
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(
            'Welcome David!',
            style: TextStyle(
                    fontFamily:
                    'Poppins', // Asegúrate de que 'Poppins' esté agregada y configurada en tu pubspec.yaml
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors
                        .white, // Puedes ajustar esto según lo "negrita" que quieras que sea el texto
                    shadows: [
                      Shadow(
                        offset: const Offset(5, 4), // Desplazamiento x=5, y=4 para la sombra
                        blurRadius: 4, // Radio de desenfoque de la sombra
                        color: Colors.black.withOpacity(0.5), // Color negro con 50% de opacidad
                      ),
                    ],
                  ),
          ),
        ),
        SizedBox(height: 530.0), // Add space between 'Hi David!' and the button
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: ElevatedButton(
            onPressed: _authenticate,
            child: Text('Entrar con huella'),
            style: ElevatedButton.styleFrom(primary: Colors.blue, onPrimary: Colors.white, padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
          ),
        ),
      ],
    ),
  ),
);


  }
    Future<void> _authenticate() async{
      try{
        bool authenticated = await auth.authenticate(
          localizedReason: "Is it you David?",
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true
          )
        );

      print("Authenticated: $authenticated");
      } on PlatformException catch (e){
        print(e);
      }
    }


  }
