import 'package:local_auth/local_auth.dart';

class LocalAuthenticationService {
  static final LocalAuthenticationService _instance = LocalAuthenticationService._internal();
  late LocalAuthentication _localAuth;

  factory LocalAuthenticationService() {
    return _instance;
  }

  LocalAuthenticationService._internal() {
    _localAuth = LocalAuthentication();
  }

  Future<bool> authenticate(String message) async {
    return _localAuth.authenticate(
      localizedReason: message, // TODO use String Constants / Providers
      options: const AuthenticationOptions(
        stickyAuth: true,
        biometricOnly: false,
        sensitiveTransaction: true,
        useErrorDialogs: true,
      ),
    );
  }
}