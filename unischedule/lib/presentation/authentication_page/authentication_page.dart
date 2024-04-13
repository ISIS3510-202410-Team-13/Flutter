import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unischedule/providers/groups_page/groups_provider.dart';
import '../../../providers/friends_page/friends_provider.dart'; 
import '../../../providers/friends_page/friends_state_notifier.dart'; 
import '../../../providers/groups_page/groups_state_notifier.dart'; 
import '../../../providers/events_page/events_provider.dart'; 


class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  late final LocalAuthentication auth;
  bool _supportState = false;
  bool _dataLoaded =
      false; // Variable para asegurar que la carga anticipada solo se realiza una vez

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
      body: Consumer(
        builder: (context, ref, child) {

          if (!_dataLoaded) {
            Future.delayed(Duration.zero, () async {
              final userId = "0MebgXs8fBYREjDKMlwq";  
              var friends = await ref.read(friendsProvider(userId).future);
              ref.read(friendsStateNotifierProvider.notifier).allFriends = friends;
              ref.read(friendsStateNotifierProvider.notifier).state = friends;

              var groups = await ref.read(groupsProvider(userId).future);
              ref.read(groupsStateNotifierProvider.notifier).allGroups = groups;
              ref.read(groupsStateNotifierProvider.notifier).state = groups;

              
              ref.read(eventsProvider(userId).future);

              _dataLoaded = true;  
            });
          }

          return Container(
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
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  ),
                ),
                SizedBox(height: 20.0),
                // Add space between 'Hi David!' and the button
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    'Welcome David!',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      // Asegúrate de que 'Poppins' esté agregada y configurada en tu pubspec.yaml
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      // Puedes ajustar esto según lo "negrita" que quieras que sea el texto
                      shadows: [
                        Shadow(
                          offset: const Offset(5, 4),
                          // Desplazamiento x=5, y=4 para la sombra
                          blurRadius: 4,
                          // Radio de desenfoque de la sombra
                          color: Colors.black.withOpacity(
                              0.5), // Color negro con 50% de opacidad
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 530.0),
                // Add space between 'Hi David!' and the button
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: ElevatedButton(
                    onPressed: _authenticate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors
                          .white, // Esto establecerá el color del texto a blanco
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                    child: const Text('Login with Fingerprint'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _authenticate() async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: "Is it you David?",
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      if (authenticated) {
        // Navegación al HomePage utilizando GoRouter
        context.go('/home');
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
