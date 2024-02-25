import 'package:flutter/painting.dart';
import 'package:flutter_game_challenge/hud/constants/colors.dart';

class ButtonColor {
  final List<Color> gradientColors;
  final Color borderColor;
  const ButtonColor(this.gradientColors, this.borderColor);

  static const grey = ButtonColor(greyLinearGradient, greyBorderColor);
  static const green = ButtonColor(greenLinearGradient, greenBorderColor);
  static const yellow = ButtonColor(yellowLinearGradient, yellowBorderColor);
  static const red = ButtonColor(redLinearGradient, redBorderColor);
}
