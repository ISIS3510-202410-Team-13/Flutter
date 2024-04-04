import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:unischedule/providers/navigation/navigation_bar_controller.dart';

class BottomNavigationWidget extends ConsumerStatefulWidget {
  const BottomNavigationWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends ConsumerState<BottomNavigationWidget> {
  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(navigationBarControllerProvider);
    return BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedItemColor: Color(0xFF9FA5C0),
        selectedItemColor: Color(0xFF9DCC18),
        selectedFontSize: 12, // Establece el tamaño de fuente seleccionado
        items: [
          BottomNavigationBarItem(
            // Usa SvgPicture.asset para cargar el SVG
            icon: SvgPicture.asset('assets/icons/house.svg',
                width: 27, height: 24, color: Color(0xFF9FA5C0)),
            activeIcon: SvgPicture.asset('assets/icons/house.svg',
                width: 27, height: 24, color: Color(0xFF9DCC18)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/calendar.svg',
                width: 21, height: 24, color: Color(0xFF9FA5C0)),
            activeIcon: SvgPicture.asset('assets/icons/calendar.svg',
                width: 21, height: 24, color: Color(0xFF9DCC18)),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/address-book.svg',
                width: 24, height: 24, color: Color(0xFF9FA5C0)),
            activeIcon: SvgPicture.asset('assets/icons/address-book.svg',
                width: 24, height: 24, color: Color(0xFF9DCC18)),
            label: 'Friends',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/user-group.svg',
                width: 30, height: 24, color: Color(0xFF9FA5C0)),
            activeIcon: SvgPicture.asset('assets/icons/user-group.svg',
                width: 30, height: 24, color: Color(0xFF9DCC18)),
            label: 'Groups',
          ),
        ],
      );
  }

  void onTabTapped(int index) {
    ref.read(navigationBarControllerProvider.notifier).setIndex(index);

    switch (index){
      case 0:
        // Navega a la página de inicio
        context.go('/home');
        break;
      case 1:
        // Navega a la página de calendario
        context.go('/calendar');
        break;
      case 2:
        // Navega a la página de amigos
        context.go('/friends');
        break;
      case 3:
        // Navega a la página de grupos
        context.go('/groups');
        break;
    }
  }
}