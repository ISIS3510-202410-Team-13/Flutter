import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:unischedule/constants/constants.dart';

class UniScheduleBottomNavBar extends StatefulWidget {
  const UniScheduleBottomNavBar({Key? key}) : super(key: key);

  static const List<String> routes = [
    RouteConstants.home,
    RouteConstants.calendar,
    RouteConstants.friends,
    RouteConstants.groups,
  ];

  @override
  State<UniScheduleBottomNavBar> createState() => _UniScheduleBottomNavBarState();
}

class _UniScheduleBottomNavBarState extends State<UniScheduleBottomNavBar> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedItemColor: ColorConstants.gullGrey,
        selectedItemColor: ColorConstants.limerick,
        selectedFontSize: 12,
        items: [
          _buildNavBarItem(AssetConstants.icHouse, StringConstants.home),
          _buildNavBarItem(AssetConstants.icCalendar, StringConstants.calendar),
          _buildNavBarItem(AssetConstants.icAddressBook, StringConstants.friends),
          _buildNavBarItem(AssetConstants.icUserGroup, StringConstants.groups),
        ],
      );
  }

  BottomNavigationBarItem _buildNavBarItem(String iconPath, String label) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        iconPath,
        width: StyleConstants.navbarIconSize,
        height: StyleConstants.navbarIconSize,
        color: ColorConstants.gullGrey,
      ),
      activeIcon: SvgPicture.asset(
        iconPath,
        width: StyleConstants.navbarIconSize,
        height: StyleConstants.navbarIconSize,
        color: ColorConstants.limerick,
      ),
      label: label,
    );
  }

  void onTabTapped(int index) {
    setState(() => currentIndex = index);
    String newRoute = UniScheduleBottomNavBar.routes[index];
    context.go(newRoute);
  }
}