import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/providers/providers.dart';

class SignupDialog extends ConsumerWidget {
  const SignupDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Dialog(
      alignment: Alignment.center,
      backgroundColor: ColorConstants.white,
      insetPadding: const EdgeInsets.all(30.0),
      elevation: 5,
      surfaceTintColor: ColorConstants.cloudyGrey,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        color: ColorConstants.white,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              StringConstants.signupTitle,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25.0),
            TextField(
              controller: nameController,
              maxLength: 50,
              cursorColor: ColorConstants.blue,
              buildCounter: (BuildContext context, {required int currentLength, required int? maxLength, required bool isFocused}) => null,
              decoration: const InputDecoration(
                focusColor: ColorConstants.blue,
                suffixIconColor: ColorConstants.blue,
                suffixIcon: Icon(Icons.person, color: ColorConstants.blue),
                labelText: StringConstants.name,
                border: OutlineInputBorder(),
                floatingLabelStyle: TextStyle(
                  color: ColorConstants.blue,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorConstants.blue,
                    width: 2.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              maxLength: 50,
              cursorColor: ColorConstants.blue,
              buildCounter: (BuildContext context, {required int currentLength, required int? maxLength, required bool isFocused}) => null,
              decoration: const InputDecoration(
                focusColor: ColorConstants.blue,
                suffixIconColor: ColorConstants.blue,
                suffixIcon: Icon(Icons.email, color: ColorConstants.blue),
                labelText: StringConstants.email,
                border: OutlineInputBorder(),
                floatingLabelStyle: TextStyle(
                  color: ColorConstants.blue,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorConstants.blue,
                    width: 2.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              maxLength: 50,
              cursorColor: ColorConstants.blue,
              buildCounter: (BuildContext context, {required int currentLength, required int? maxLength, required bool isFocused}) => null,
              decoration: const InputDecoration(
                focusColor: ColorConstants.blue,
                suffixIconColor: ColorConstants.blue,
                suffixIcon: Icon(Icons.lock, color: ColorConstants.blue),
                labelText: StringConstants.password,
                border: OutlineInputBorder(),
                floatingLabelStyle: TextStyle(
                  color: ColorConstants.blue,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorConstants.blue,
                    width: 2.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.blue,
                foregroundColor: ColorConstants.white,
                fixedSize: const Size(200, double.infinity),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              onPressed: () {
                ref.read(authenticationStatusProvider.notifier).signUp(
                  name: nameController.text,
                  emailAddress: emailController.text,
                  password: passwordController.text,
                ).then((status) {
                  if (status == SignUpStatus.success) {
                    context.go(RouteConstants.home);
                  } else if (status == SignUpStatus.weakPassword) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(StringConstants.weakPassword),
                        backgroundColor: ColorConstants.red,
                      ),
                    );
                  } else if (status == SignUpStatus.emailAlreadyInUse) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(StringConstants.emailAlreadyInUse),
                        backgroundColor: ColorConstants.red,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(StringConstants.anErrorOccurred),
                        backgroundColor: ColorConstants.red,
                      ),
                    );
                  }
                });
              },
              child: const Text(StringConstants.signup),
            ),
          ],
        ),
      ),
    );
  }
}