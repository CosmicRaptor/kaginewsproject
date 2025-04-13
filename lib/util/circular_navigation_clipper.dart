import 'dart:math';

import 'package:flutter/material.dart';

class CircularRevealClipper extends CustomClipper<Path> {
  final Offset center;
  final double fraction;

  CircularRevealClipper({required this.center, required this.fraction});

  @override
  Path getClip(Size size) {
    final finalRadius = sqrt(
      size.width * size.width + size.height * size.height,
    );
    final radius = finalRadius * fraction;

    return Path()..addOval(Rect.fromCircle(center: center, radius: radius));
  }

  @override
  bool shouldReclip(CircularRevealClipper oldClipper) =>
      oldClipper.fraction != fraction || oldClipper.center != center;
}
