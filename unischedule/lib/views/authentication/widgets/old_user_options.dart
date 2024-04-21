import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/services/services.dart';

class OldUserOptions extends StatelessWidget {
  final String userName;
  const OldUserOptions({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: ElevatedButton(
        onPressed: () => {
          LocalAuthenticationService()
            .authenticate(StringConstants.localAuthMessage(userName))
            .then((value) => value ? context.go(RouteConstants.home) : null)
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstants.blue,
          foregroundColor: ColorConstants.white,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        ),
        child: const Text(StringConstants.loginWithFingerprint),
      ),
    );
  }
}