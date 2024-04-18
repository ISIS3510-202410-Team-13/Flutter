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

          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                AssetConstants.icHouse,
                width: StyleConstants.navbarIconSize,
                height: StyleConstants.navbarIconSize,
                color: ColorConstants.gullGrey,
            ),
            activeIcon: SvgPicture.asset(
                AssetConstants.icHouse,
                width: StyleConstants.navbarIconSize,
                height: StyleConstants.navbarIconSize,
                color: ColorConstants.limerick,
            ),
            label: StringConstants.home,
          ),

          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                AssetConstants.icCalendar,
                width: StyleConstants.navbarIconSize,
                height: StyleConstants.navbarIconSize,
                color: ColorConstants.gullGrey,
            ),
            activeIcon: SvgPicture.asset(
                AssetConstants.icCalendar,
                width: StyleConstants.navbarIconSize,
                height: StyleConstants.navbarIconSize,
                color: ColorConstants.limerick,
            ),
            label: StringConstants.calendar,
          ),

          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                AssetConstants.icAddressBook,
                width: StyleConstants.navbarIconSize,
                height: StyleConstants.navbarIconSize,
                color: ColorConstants.gullGrey,
            ),
            activeIcon: SvgPicture.asset(
                AssetConstants.icAddressBook,
                width: StyleConstants.navbarIconSize,
                height:StyleConstants.navbarIconSize,
                color: ColorConstants.limerick,
            ),
            label: StringConstants.friends,
          ),

          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                AssetConstants.icUserGroup,
                width: StyleConstants.navbarIconSize,
                height: StyleConstants.navbarIconSize,
                color: ColorConstants.gullGrey,
            ),
            activeIcon: SvgPicture.asset(
                AssetConstants.icUserGroup,
                width: StyleConstants.navbarIconSize,
                height: StyleConstants.navbarIconSize,
                color: ColorConstants.limerick,
            ),
            label: StringConstants.groups,
          ),
        ],
      );
  }

  void onTabTapped(int index) {
    setState(() => currentIndex = index);
    String newRoute = UniScheduleBottomNavBar.routes[index];
    context.go(newRoute);
  }
}