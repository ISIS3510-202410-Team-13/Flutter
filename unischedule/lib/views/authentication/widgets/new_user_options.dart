import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/providers/providers.dart';
import 'login_dialog.dart';
import 'signup_dialog.dart';

class NewUserOptions extends ConsumerWidget {
  const NewUserOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () {
            ref.read(registerButtonTapProvider(buttonName: AnalyticsConstants.LOGIN_BUTTON));
            showDialog(
              context: context,
              builder: (context) => ScaffoldMessenger(
                child: Scaffold(
                  backgroundColor: ColorConstants.transparent,
                  body: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: GestureDetector(
                      child: const LoginDialog(),
                    )
                  ),
                ),
              ),
            );
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
          onPressed: () {
            ref.read(registerButtonTapProvider(buttonName: AnalyticsConstants.SIGN_UP_BUTTON));
            showDialog(
              context: context,
              builder: (context) => ScaffoldMessenger(
                child: Scaffold(
                  backgroundColor: ColorConstants.transparent,
                  body: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => Navigator.of(context).pop(),
                    child: GestureDetector(
                      child: const SignupDialog(),
                    )
                  ),
                ),
              ),
            );
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