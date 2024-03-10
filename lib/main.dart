import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_game_challenge/eco_flyer/plane_game.dart';
import 'package:flutter_game_challenge/hud/hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'hud/player_info/player_info_cubit.dart';
import 'hud/player_info/player_info_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await LocalStorage().init();
  sharedPreferences = await SharedPreferences.getInstance();

  playerInfo = await fetchLocalPlayerCurrency();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  // Modify this line

  runApp(BlocProvider(
    create: (context) => PlayerInfoCubit(),
    child: GameWidget(
      game: game,
      overlayBuilderMap: gameHud,
      initialActiveOverlays: [GameOverlay.mainMenu.name, GameOverlay.playerInfo.name],
    ),
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

late PlayerInfo playerInfo;

late SharedPreferences sharedPreferences;
/* 
class MainMenu extends StatefulWidget {
  PixelAdventure game;
  MainMenu({super.key, required this.game});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        color: Colors.green.withOpacity(0.8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
                onPressed: () {
                  widget.game.player.changeCharacter(GameCharacters.virtualGuy);
                },
                child: Text('Select Virtual Guy')),
            TextButton(
                onPressed: () {
                  widget.game.player.changeCharacter(GameCharacters.maskDude);
                },
                child: Text('Select Mask Dude')),
            TextButton(
                onPressed: () {
                  widget.game.player.changeCharacter(GameCharacters.pinkMan);
                },
                child: Text('Select Pink Man')),
            TextButton(
                onPressed: () {
                  widget.game.player.changeCharacter(GameCharacters.ninjaFrog);
                },
                child: Text('Select Ninja Frog')),
          ],
        ),
      ),
    );
  }
}
 */