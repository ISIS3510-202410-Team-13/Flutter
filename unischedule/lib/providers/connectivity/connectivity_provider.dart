import 'package:connectivity/connectivity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final connectivityStatusProvider = StateNotifierProvider<ConnectivityStatusNotifier, ConnectivityStatus>((ref) {
    return ConnectivityStatusNotifier();
  },
);

enum ConnectivityStatus { notDetermined, isConnected, isDisconnected }

class ConnectivityStatusNotifier extends StateNotifier<ConnectivityStatus> {
  ConnectivityStatusNotifier() : super(ConnectivityStatus.notDetermined) {
    checkConnectivity();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _setConnectivityStatus(result);
    });
  }

  Future<void> checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    _setConnectivityStatus(connectivityResult);
  }

  void _setConnectivityStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        state = ConnectivityStatus.isConnected;
        break;
      case ConnectivityResult.none:
        state = ConnectivityStatus.isDisconnected;
        break;
    }
  }
}