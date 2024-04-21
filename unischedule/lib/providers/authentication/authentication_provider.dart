import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unischedule/services/local_storage/hive_box_service.dart';

final authenticationStatusProvider = StateNotifierProvider<AuthenticationStatusNotifier, User?>((ref) {
    return AuthenticationStatusNotifier();
  },
);

enum SignUpStatus { notDetermined, success, weakPassword, emailAlreadyInUse, nameIsNotSet }
enum LogInStatus { notDetermined, success, userNotFound, wrongPassword }

class AuthenticationStatusNotifier extends StateNotifier<User?> {
  AuthenticationStatusNotifier() : super(null) {
    FirebaseAuth.instance.userChanges().listen((User? user) {
      _setAuthenticationStatus(user);
    });
  }

  void _setAuthenticationStatus(User? user) {
    // TODO add logic to update things based on user authentication, such as local storage
    state = user;

  }

  Future<SignUpStatus> signUp({
    required String name,
    required String emailAddress,
    required String password,
  }) async {
    try {
      if (name.isEmpty) {
        return SignUpStatus.nameIsNotSet;
      }
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      await credential.user!.updateDisplayName(name);
      return SignUpStatus.success;
    } on FirebaseAuthException catch (e) {
      // TODO add errors for missing @, no internet connection, etc.
      if (e.code == 'weak-password') {
        return SignUpStatus.weakPassword;
      } else if (e.code == 'email-already-in-use') {
        return SignUpStatus.emailAlreadyInUse;
      } else {
        print('Error ${e.code}: ${e.message}');
      }
    }
    return SignUpStatus.notDetermined;
  }

  Future<LogInStatus> logIn({
    required String emailAddress,
    required String password
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );
      return LogInStatus.success;
    } on FirebaseAuthException catch (e) {
      // TODO add more error types from Firebase to enhance UX
      if (e.code == 'user-not-found') {
        return LogInStatus.userNotFound;
      } else if (e.code == 'wrong-password') {
        return LogInStatus.wrongPassword;
      }
    }
    return LogInStatus.notDetermined;
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    await HiveBoxServiceFactory.resetHive();
    // TODO delete scheduled notifications?
  }
}