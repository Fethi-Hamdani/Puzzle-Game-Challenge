import 'package:flutter/painting.dart';
import 'package:flutter_game_challenge/hud/constants/colors.dart';

enum ButtonColor {
  grey(greyLinearGradient, greyBorderColor),
  green(greenLinearGradient, greenBorderColor),
  yellow(yellowLinearGradient, yellowBorderColor),
  red(redLinearGradient, redBorderColor);

  final List<Color> gradientColors;
  final Color borderColor;

  const ButtonColor(this.gradientColors, this.borderColor);
}
