import 'package:flutter_game_challenge/game_data/utils/string_extension.dart';

enum EnemyState {
  idle,
  run,
  hit;

  String get path {
    return "Enemies/Chicken/${name.capitalize()} (32x34).png";
  }
}
