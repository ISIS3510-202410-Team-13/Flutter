import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalendarAppBar extends StatelessWidget {
  const CalendarAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset('assets/icons/bars.svg',
            width: 21, height: 24, color: Colors.white),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      title: Text(
        'February',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset('assets/icons/bell.svg',
              width: 21, height: 24, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }
}
