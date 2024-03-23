import 'package:flutter_riverpod/flutter_riverpod.dart';

final navigationBarControllerProvider = StateNotifierProvider<NavigationBarController, int>((ref) {
  return NavigationBarController(0);
});

class NavigationBarController extends StateNotifier<int> {
  NavigationBarController(super.state);

  void setIndex(int index) {
    state = index;
  }
}