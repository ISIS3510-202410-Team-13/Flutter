import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final connectivityStatusProvider = StateNotifierProvider<ConnectivityStatusNotifier, ConnectivityStatus>((ref) {
  return ConnectivityStatusNotifier();
},);

enum ConnectivityStatus { notDetermined, isConnected, isDisconnected }

class ConnectivityStatusNotifier extends StateNotifier<ConnectivityStatus> {
  ConnectivityStatusNotifier() : super(ConnectivityStatus.notDetermined) {
    checkConnectivity();
    Connectivity().onConnectivityChanged
        .asyncMap((results) => results.first)
        .listen((result) => _setConnectivityStatus(result));  }

  Future<void> checkConnectivity() async {
    print("wtf");
    var connectivityResult = await Connectivity().checkConnectivity();
    _setConnectivityStatus(connectivityResult.first);
  }

  void _setConnectivityStatus(ConnectivityResult results) {
    print(results); // Acceso al primer elemento (conectividad actual)
    switch (results) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        state = ConnectivityStatus.isConnected;
        break;
      case ConnectivityResult.none:
        state = ConnectivityStatus.isDisconnected;
        break;
      case ConnectivityResult.bluetooth:
        // TODO: Handle this case.
        break;
      case ConnectivityResult.ethernet:
        // TODO: Handle this case.
        break;
      case ConnectivityResult.vpn:
        // TODO: Handle this case.
        break;
      case ConnectivityResult.other:
        // TODO: Handle this case.
        break;
    }
  }
}
