import 'package:flutter/material.dart';
import 'package:flutter_game_challenge/hud/main/main_screen.dart';
import 'package:flutter_game_challenge/hud/pause/pause_screen.dart';
import 'package:flutter_game_challenge/plane_game.dart';

enum GameOverlay {
  pause,
  mainMenu,
  settings,
  game,
  gameOver,
}

Map<String, Widget Function(BuildContext, PlaneGame)> gameHud = {
  GameOverlay.pause.name: (context, game) => PauseScreen(game: game),
  GameOverlay.mainMenu.name: (context, game) => MainScreen(game: game),
};
