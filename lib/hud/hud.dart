import 'package:flutter/material.dart';
import 'package:flutter_game_challenge/eco_flyer/plane_game.dart';
import 'package:flutter_game_challenge/hud/fortune_wheel/fortune_wheel_screen.dart';
import 'package:flutter_game_challenge/hud/main/main_screen.dart';
import 'package:flutter_game_challenge/hud/pause/pause_screen.dart';
import 'package:flutter_game_challenge/hud/settings/settings_screen.dart';
import 'package:flutter_game_challenge/hud/shop/shop_screen.dart';

Map<String, Widget Function(BuildContext, PlaneGame)> gameHud = {
  GameOverlay.pause.name: (context, game) => PauseScreen(game: game),
  GameOverlay.mainMenu.name: (context, game) => MainScreen(game: game),
  GameOverlay.settings.name: (context, game) => SettingsScreen(game: game),
  GameOverlay.shop.name: (context, game) => ShopScreen(game: game),
  GameOverlay.fortuneWheel.name: (context, game) => FortuneWheelScreen(game: game)
};

enum GameOverlay {
  pause,
  mainMenu,
  settings,
  game,
  gameOver,
  fortuneWheel,
  shop,
}
