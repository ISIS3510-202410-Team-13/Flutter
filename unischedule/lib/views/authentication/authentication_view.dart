import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/services/services.dart';
import 'package:unischedule/widgets/background_image/background_image_widget.dart';

class AuthenticationView extends StatelessWidget {
  const AuthenticationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            const BackgroundImage(opacity: 1),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 80.0),
                      child: Text(
                        'UniSchedule', // TODO use String Constants
                        style: TextStyle( // TODO use TextTheme
                            fontSize: 24,
                            fontWeight: FontWeight.normal,
                            color: ColorConstants.white),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        'Welcome David!', // TODO use String Constants
                        style: TextStyle( // TODO use TextTheme
                          fontFamily: 'Poppins',
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.white,
                          shadows: [
                            Shadow(
                              offset: const Offset(5, 4),
                              blurRadius: 4,
                              color: ColorConstants.black.withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 530.0),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: ElevatedButton(
                        onPressed: () => {
                          LocalAuthenticationService()
                              .authenticate('Is it you David?') // TODO use String Constants
                              .then((value) => context.go(RouteConstants.home))
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,  // TODO use ColorConstants
                          foregroundColor: Colors.white, // TODO use ColorConstants
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        ),
                        child: const Text('Login with Fingerprint'), // TODO use String Constants
                      ),
                    ),
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}
