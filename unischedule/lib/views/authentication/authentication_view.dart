import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/providers/providers.dart';
import 'package:unischedule/widgets/widgets.dart';
import 'widgets/new_user_options.dart';
import 'widgets/old_user_options.dart';

class AuthenticationView extends ConsumerStatefulWidget {
  const AuthenticationView({super.key});

  @override
  ConsumerState<AuthenticationView> createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends ConsumerState<AuthenticationView> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authenticationStatusProvider);

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
                    StringConstants.welcomeUser(user?.displayName ?? ''),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: user != null
                        ? OldUserOptions(userName: user.displayName ?? '')
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