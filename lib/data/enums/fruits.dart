import 'package:flutter_game_challenge/data/controls/game_controls.dart';
import 'package:flutter_game_challenge/data/utils/string_extension.dart';

enum Fruits {
  apple,
  bananas,
  orange,
  kiwi,
  cherries;

  String get path {
    return 'Items/Fruits/${name.capitalize()}.png';
  }

  static Fruits fromString(String? name) {
    if (name == null) return GameControls.defaultFruit;
    switch (name.toLowerCase()) {
      case 'apple':
        return Fruits.apple;
      case 'bananas':
        return Fruits.bananas;
      case 'orange':
        return Fruits.orange;
      case 'kiwi':
        return Fruits.kiwi;
      case 'cherries':
        return Fruits.cherries;
      default:
        return GameControls.defaultFruit;
    }
  }
}
