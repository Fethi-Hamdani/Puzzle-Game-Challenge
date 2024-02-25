import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game_challenge/eco_flyer/plane_game.dart';
import 'package:flutter_game_challenge/hud/hud.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  final game = PlaneGame(); // Modify this line

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