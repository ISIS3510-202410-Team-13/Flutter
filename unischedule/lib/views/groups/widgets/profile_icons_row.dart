import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:unischedule/constants/constants.dart';

class ProfileIconsRow extends StatelessWidget {
  const ProfileIconsRow({
    super.key,
    required this.imagePaths,
    required this.memberCount,
  });

  final List<String> imagePaths;
  final int memberCount;

  @override
  Widget build(BuildContext context) {
    final remainingCountText = memberCount > 3 ? '+${memberCount - 3}' : '+0';
    print([memberCount, imagePaths]);
    return Container(
      width: 120,
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          for (int i = min(3,memberCount) - 1; i >= 0; i--)
            Positioned(
              left: i * 20.0,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: ColorConstants.limerick,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: ColorConstants.white,
                      width: 1,
                    ),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: imagePaths[i],
                    fadeInDuration: const Duration(milliseconds: 100),
                    fadeOutDuration: const Duration(milliseconds: 100),
                    filterQuality: FilterQuality.none,
                    maxHeightDiskCache: 100,
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      radius: 20,
                      backgroundImage: imageProvider,
                    ),
                    placeholder: (context, url) => const CircleAvatar(
                      radius: 20,
                      backgroundColor: ColorConstants.white,
                    ),
                    errorWidget: (context, url, error) => const CircleAvatar(
                      radius: 20,
                      backgroundColor: ColorConstants.white,
                      child: Icon(Icons.error, color: ColorConstants.red),
                    ),
                  )
                ),
              ),
            ),
          Container(
            padding: const EdgeInsets.fromLTRB(6, 8, 16, 15),
            alignment: Alignment.centerRight,
            child: Text(
              remainingCountText,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ],
      ),
    );
  }
}