import 'dart:ui';

import 'package:flutter/cupertino.dart';

class DarkThemeColors {
  const DarkThemeColors();

  static const Color mainColor = const Color(0xFFFFFFFF);
  static const Color background = const Color(0xFF191720);
  static const Color loginGradientStart = const Color(0xFF191720);
  static const Color loginGradientEnd = const Color(0xFFFFFFFF);
  static const Color successGreen = const Color(0xFF32CD32);
  static const Color secondaryColor = const Color(0xFF3b3a41);
  static const Color thirdColor = const Color(0xFFFFD684);
  static const Color fourthColor = const Color(0xFF8FDCFF);
  static const Color elementBack = const Color(0xfff1efef);
  static const Color titleColor = const Color(0xFF061857);
  static const Color subTitle = const Color(0xFFa4adbe);
  static const Color textMain = const Color(0xFF848484);
  static const Color greyBack = const Color(0xFFced4db);
  static const Color grey = const Color(0xFF8d8f9a);
  static const Color greyForm = const Color(0xFFcaced4);
  static const Color red = const Color(0xFFE74C3C);
  static const Color orange = const Color(0xFFff6348);
  static const Color strongGrey = const Color(0xFFced4db);
  static const Color secondBlack = const Color(0xFF515C6F);
  static const Color facebookBlue = const Color(0xFF1877f2);
  static const Color inputBorder = const Color(0xFF383740);

  static const primaryGradient = const RadialGradient(
      colors: const [loginGradientStart, loginGradientEnd],
      center: Alignment.topLeft,
      radius: 30,
      tileMode: TileMode.clamp);

  static const cardGradient = const LinearGradient(
    colors: const [Color(0xFF1e3c72), Color(0xFF2a5298)],
    stops: const [0.0, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
