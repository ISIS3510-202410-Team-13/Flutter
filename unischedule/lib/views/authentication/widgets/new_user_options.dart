import 'package:flutter/material.dart';
import 'package:unischedule/constants/constants.dart';
import 'login_dialog.dart';
import 'signup_dialog.dart';

class NewUserOptions extends StatelessWidget {
  const NewUserOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () => {
            showDialog(
              context: context,
              builder: (context) => const LoginDialog(),
            )
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorConstants.blue,
            foregroundColor: ColorConstants.white,
            fixedSize: const Size(250, double.infinity),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
          child: const Text(StringConstants.login),
        ),
        const SizedBox(height: 15.0),
        ElevatedButton(
          onPressed: () => {
            showDialog(
              context: context,
              builder: (context) => const SignupDialog(),
            )
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorConstants.white,
            foregroundColor: ColorConstants.blue,
            side: const BorderSide(color: ColorConstants.blue),
            fixedSize: const Size(250, double.infinity),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
          child: const Text(StringConstants.signup),
        ),
      ],
    );
  }
}