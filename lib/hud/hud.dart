import 'package:flutter/material.dart';
import 'package:flutter_game_challenge/eco_flyer/plane_game.dart';
import 'package:flutter_game_challenge/hud/main/main_screen.dart';
import 'package:flutter_game_challenge/hud/pause/pause_screen.dart';
import 'package:flutter_game_challenge/hud/settings/settings_screen.dart';

Map<String, Widget Function(BuildContext, PlaneGame)> gameHud = {
  GameOverlay.pause.name: (context, game) => PauseScreen(game: game),
  GameOverlay.mainMenu.name: (context, game) => MainScreen(game: game),
  GameOverlay.settings.name: (context, game) => SettingsScreen(game: game)
};

enum GameOverlay {
  pause,
  mainMenu,
  settings,
  game,
  gameOver,
  shop,
}
