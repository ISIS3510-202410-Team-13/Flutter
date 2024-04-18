import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BackgroundImage extends ConsumerStatefulWidget {
  const BackgroundImage({
    super.key,
    this.opacity = 1,
  });

  final double opacity;

  @override
  ConsumerState<BackgroundImage> createState() => _BackgroundImage();
}

class _BackgroundImage extends ConsumerState<BackgroundImage> {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.opacity,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'), // TODO make this dynamic, create a provider
            fit: BoxFit.cover,
          ),
        ),
      )
    );
  }
}
