import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';

class UniScheduleDrawer extends StatelessWidget {
  const UniScheduleDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Drawer(
        child: Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Container(
                  color: Color(0xFF9FA5C0),
                ),
              ),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 115),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const CircleAvatar(
                      radius: 62,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('assets/images/profile_pics/user_1.png'),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "user0",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 30),
                    _buildDivider(),
                    SizedBox(height: 50),
                    _buildMenuOption('user.svg', 'Profile', context, '/home'),
                    SizedBox(height: 50),
                    _buildMenuOption('gear.svg', 'Settings', context, '/home'),
                    SizedBox(height: 50),
                    _buildDivider(),
                    SizedBox(height: 50),
                    _buildMenuOption('question.svg', 'Guide', context, '/home'),
                    SizedBox(height: 50),
                    _buildMenuOption('handshake-angle.svg', 'Help', context, '/home'),
                    SizedBox(height: 50),
                    _buildMenuOption('circle-info.svg', 'About', context, '/temp-cache'),
                    SizedBox(height: 50),
                    _buildDivider(),
                    SizedBox(height: 30),
                    _buildVersionInfo(),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 220,
      height: 1,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(0.5)
      ),
    );
  }

  Widget _buildMenuOption(String iconPath, String text, BuildContext context, String route) {
    return InkWell(
      onTap: () => context.go(route),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 24,
            height: 24,
            child: SvgPicture.asset('assets/icons/$iconPath', width: 24, height: 24, color: Colors.white),
          ),
          SizedBox(width: 16),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 24,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVersionInfo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/icons/code-compare.svg', width: 12, height: 12, color: Colors.white),
        SizedBox(width: 8),
        Text(
          "Version 0.41 build #101",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 11,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
