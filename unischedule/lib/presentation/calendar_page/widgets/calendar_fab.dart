import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalendarFAB extends StatelessWidget {
  const CalendarFAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      bottom: 15 + MediaQuery.of(context).padding.bottom,
      child: InkWell(
        onTap: () {
          GoRouter.of(context).go('/create-class');
        },
        child: SvgPicture.asset(
          'assets/icons/square-plus.svg',
          width: 50,
          height: 56,
          color: Colors.white,
        ),
      ),
    );
  }
}
