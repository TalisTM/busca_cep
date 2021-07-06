import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {

  static final Color primary = Color(0xFFF9AA33);
  static final Color secundary = Color(0xFFF00000);
  static final Color darkGrey = Color(0xFF344955);
  static final Color lightGrey = Color(0xFFA9A9A9);
  static final Color lightYellow = Color(0xFFFFD700);
  static final Color white = Color(0xFFFFFFFF);
  static final Color red = Color(0xFFF00000);
  static final Color lightRed = Color(0xFFFF7F7F);
  static final Color darkRed = Color(0xFFFF4C4C);
  

  static final gradient = LinearGradient(
    colors: [
      primary,
      Color.fromRGBO(255, 180, 0, 0.795),
    ],
    stops: [
      0.0,
      0.644
    ],
    transform: GradientRotation(2.13959913 * pi),
  );

  static final gradientButton = LinearGradient(
    colors: [
      primary,
      Color.fromRGBO(255, 200, 0, 0.795),
    ],
    stops: [
      0.0,
      0.644
    ],
    transform: GradientRotation(2.13959913 * pi),
  );
}