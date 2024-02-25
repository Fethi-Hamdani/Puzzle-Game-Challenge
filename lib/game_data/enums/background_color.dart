import 'package:flutter_game_challenge/game_data/utils/string_extension.dart';

enum BackgroundColor {
  gray,
  blue,
  green,
  purple,
  yellow;

  String get path {
    return "Background/${name.capitalize()}.png";
  }

  static BackgroundColor? fromString(String? colorName) {
    if (colorName == null) return null;
    switch (colorName) {
      case 'Gray':
        return BackgroundColor.gray;
      case 'Blue':
        return BackgroundColor.blue;
      case 'Green':
        return BackgroundColor.green;
      case 'Purple':
        return BackgroundColor.purple;
      case 'Yellow':
        return BackgroundColor.yellow;
      default:
        return null;
    }
  }
}
