import 'package:flutter/material.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/widgets/background_image/background_image_widget.dart';
import 'widgets/new_user_options.dart';
import 'widgets/old_user_options.dart';

class AuthenticationView extends StatelessWidget {
  const AuthenticationView({super.key});

  @override
  Widget build(BuildContext context) {

    final user = 'David'; // TODO use provider for user
    final isUserAuthenticated = false;

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(opacity: 1),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 80.0),
              child: Column(
                  children: [
                    Text(
                      StringConstants.appName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: ColorConstants.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      StringConstants.welcomeUser(user),
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: isUserAuthenticated
                          ? OldUserOptions(userName: user)
                          : const NewUserOptions(),
                      ),
                    ),
                  ],
                ),
            ),
          ),
        ],
      ),
    );
  }
}