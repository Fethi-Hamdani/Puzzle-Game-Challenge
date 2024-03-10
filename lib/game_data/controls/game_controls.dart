import 'package:flutter_game_challenge/game_data/enums/background_color.dart';
import 'package:flutter_game_challenge/game_data/enums/fruits.dart';

class GameControls {
  static bool playSound = false;
  static bool debugMode = false;
  static BackgroundColor defaultBackgroundColor = BackgroundColor.green;
  static Fruits defaultFruit = Fruits.apple;
  static int allowedLives = 3;
}
