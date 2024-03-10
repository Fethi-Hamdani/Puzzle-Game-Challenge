import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game_challenge/eco_flyer/plane_game.dart';
import 'package:flutter_game_challenge/hud/hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await LocalStorage().init();
  sharedPreferences = await SharedPreferences.getInstance();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  // Modify this line

  runApp(GameWidget(
    game: game,
    overlayBuilderMap: gameHud,
    initialActiveOverlays: [GameOverlay.mainMenu.name],
  ));

  // PixelAdventure game = PixelAdventure();
  // runApp(
  //   GameWidget(
  //     game: kDebugMode ? PixelAdventure() : game,
  //     overlayBuilderMap: {
  //       "menu": (BuildContext context, PixelAdventure gameRef) => MainMenu(game: gameRef),
  //     },
  //   ),
  // );
}

final game = PlaneGame();

late SharedPreferences sharedPreferences;
