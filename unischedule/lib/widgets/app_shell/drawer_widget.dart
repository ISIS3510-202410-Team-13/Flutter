import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:unischedule/constants/analytics/analytics_constants.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/providers/authentication/authentication_provider.dart';
import 'package:unischedule/providers/feature_analytics/feature_analytics_provider.dart';

class UniScheduleDrawer extends ConsumerWidget {
  const UniScheduleDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authenticationStatusProvider);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Drawer(
        child: Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Container(
                  color: ColorConstants.gullGrey,
                ),
              ),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(top: Scaffold.of(context).appBarMaxHeight ?? 100),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 62,
                      backgroundColor: ColorConstants.white,
                      child: CachedNetworkImage(
                        imageUrl: user?.photoURL ?? 'assets/images/profile_pics/user_1.png',
                        fadeInDuration: const Duration(milliseconds: 100),
                        fadeOutDuration: const Duration(milliseconds: 100),
                        filterQuality: FilterQuality.none,
                        maxHeightDiskCache: 100,
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          radius: 60,
                          backgroundImage: imageProvider,
                        ),
                        placeholder: (context, url) => const CircleAvatar(
                          radius: 60,
                          backgroundColor: ColorConstants.gullGrey,
                        ),
                        errorWidget: (context, url, error) => const CircleAvatar(
                          radius: 60,
                          backgroundColor: ColorConstants.white,
                          child: Icon(Icons.person, color: ColorConstants.gullGrey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      user?.displayName ?? 'Unknown User',
                      style: const TextStyle( // TODO use text theme
                        fontFamily: 'Poppins',
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: ColorConstants.white,
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildDivider(),
                    const SizedBox(height: 30),
                    _buildMenuOption('user.svg', 'Profile'), // TODO replace with Asset Constant and String Constant
                    const SizedBox(height: 20),
                    _buildMenuOption('gear.svg', 'Settings'), // TODO replace with Asset Constant and String Constant
                    const SizedBox(height: 50),
                    _buildDivider(),
                    const SizedBox(height: 50),
                    _buildMenuOption('question.svg', 'Guide'), // TODO replace with Asset Constant and String Constant
                    const SizedBox(height: 20),
                    _buildMenuOption('handshake-angle.svg', 'Help'), // TODO replace with Asset Constant and String Constant
                    const SizedBox(height: 20),
                    _buildMenuOption('circle-info.svg', 'About'), // TODO replace with Asset Constant and String Constant
                    const SizedBox(height: 20),

                    InkWell(
                      onTap: () {
                        ref.read(registerButtonTapProvider(buttonName: AnalyticsConstants.SIGNOUT_BUTTON));
                        ref.read(authenticationStatusProvider.notifier).signOut();
                        context.go(RouteConstants.root);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 24, // TODO use style constant
                            height: 24, // TODO use style constant
                            child: SvgPicture.asset(
                                'assets/icons/arrow-right-from-bracket.svg', // TODO replace with Asset Constant
                                width: 24, // TODO use style constant
                                height: 24, // TODO use style constant
                                color: ColorConstants.white
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'Sign Out', // TODO replace with String Constant
                            style: const TextStyle( // TODO use text theme
                              fontFamily: 'Poppins',
                              fontSize: 24,
                              fontWeight: FontWeight.w300,
                              color: ColorConstants.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 50),
                    _buildDivider(),
                    const SizedBox(height: 30),
                    _buildVersionInfo(),
                    const SizedBox(height: 30),
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
          color: ColorConstants.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(0.5)
      ),
    );
  }

  Widget _buildMenuOption(String iconPath, String text) {
    return InkWell(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 24, // TODO use style constant
            height: 24, // TODO use style constant
            child: SvgPicture.asset(
                'assets/icons/$iconPath',  // TODO replace with Asset Constant
                width: 24,  // TODO use style constant
                height: 24, // TODO use style constant
                color: ColorConstants.white
            ),
          ),
          const SizedBox(width: 16),
          Text(
            text,
            style: const TextStyle( // TODO use text theme
              fontFamily: 'Poppins',
              fontSize: 24,
              fontWeight: FontWeight.w300,
              color: ColorConstants.white,
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
        SvgPicture.asset(
            'assets/icons/code-compare.svg', // TODO replace with Asset Constant
            width: 12, // TODO use style constant
            height: 12, // TODO use style constant
            color: ColorConstants.white
        ),
        const SizedBox(width: 8),
        const Text(
          'Version 0.41 build #101', // TODO replace with String Constant
          style: TextStyle( // TODO use text theme
            fontFamily: 'Poppins',
            fontSize: 11,
            fontWeight: FontWeight.w300,
            color: ColorConstants.white,
          ),
        ),
      ],
    );
  }
}