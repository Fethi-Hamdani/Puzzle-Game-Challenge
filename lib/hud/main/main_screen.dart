import 'package:flutter/material.dart';
import 'package:flutter_game_challenge/eco_flyer/plane_game.dart';
import 'package:flutter_game_challenge/hud/constants/button_colors.dart';
import 'package:flutter_game_challenge/hud/constants/colors.dart';
import 'package:flutter_game_challenge/hud/hud.dart';
import 'package:flutter_game_challenge/hud/widgets/button.dart';
import 'package:flutter_game_challenge/hud/widgets/icon.dart';
import 'package:flutter_game_challenge/hud/widgets/text.dart';

class MainScreen extends StatefulWidget {
  PlaneGame game;
  MainScreen({super.key, required this.game});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.5),
      padding: EdgeInsets.all(20),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              GameText(
                text: "Eco Fly",
                borderColor: ButtonColor.yellow.borderColor,
                borderWidth: 2,
                textColor: redBorderColor,
                fontSize: 60,
              ),
              SizedBox(height: 20),
              GameButton.text(
                color: ButtonColor.green,
                text: "PLAY",
                fontSize: 30,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                onPressed: () {
                  widget.game.resume();
                  widget.game.overlays.remove(GameOverlay.mainMenu.name);
                },
              ),
            ]),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  GameButton(
                    borderWidth: 3,
                    color: ButtonColor(yellowLinearGradient, redBorderColor),
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    onPressed: () {
                      //  widget.game.overlays.remove(GameOverlay.mainMenu.name);
                    },
                    child: GameIcon(
                      icon: Icons.volume_up_rounded,
                      size: 40,
                      iconColor: ButtonColor.red.borderColor,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GameButton(
                    borderWidth: 3,
                    color: ButtonColor(yellowLinearGradient, redBorderColor),
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    onPressed: () {
                      //  widget.game.overlays.remove(GameOverlay.mainMenu.name);
                    },
                    child: GameIcon(
                      icon: Icons.settings,
                      size: 40,
                      iconColor: ButtonColor.red.borderColor,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GameButton(
                    borderWidth: 3,
                    color: ButtonColor(yellowLinearGradient, redBorderColor),
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    onPressed: () {
                      //  widget.game.overlays.remove(GameOverlay.mainMenu.name);
                    },
                    child: GameIcon(
                      icon: Icons.music_note_outlined,
                      size: 40,
                      iconColor: ButtonColor.red.borderColor,
                    ),
                  ),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
