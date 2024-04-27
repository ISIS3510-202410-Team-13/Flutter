import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unischedule/constants/constants.dart';

class UniScheduleSearchBar extends StatelessWidget {
  const UniScheduleSearchBar({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: ColorConstants.lightGrey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: searchController,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          color: ColorConstants.cloudyGrey,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: StringConstants.search,
          hintStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: ColorConstants.cloudyGrey,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SvgPicture.asset(
              AssetConstants.icMagnifyingGlass,
              width: StyleConstants.iconWidth,
              height: StyleConstants.iconHeight,
              color: ColorConstants.cloudyGrey,
            ),
          ),
        ),
      ),
    );
  }
}