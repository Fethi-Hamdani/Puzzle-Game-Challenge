import 'package:flutter/material.dart';
import 'package:flutter_game_challenge/eco_flyer/plane_game.dart';
import 'package:flutter_game_challenge/hud/constants/button_colors.dart';
import 'package:flutter_game_challenge/hud/constants/colors.dart';
import 'package:flutter_game_challenge/hud/hud.dart';
import 'package:flutter_game_challenge/hud/widgets/button.dart';
import 'package:flutter_game_challenge/hud/widgets/icon.dart';
import 'package:flutter_game_challenge/hud/widgets/text.dart';
import 'package:flutter_game_challenge/main.dart';

class MainScreen extends StatefulWidget {
  PlaneGame game;
  MainScreen({super.key, required this.game});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.grey[300],
      padding: const EdgeInsets.all(20),
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
              const SizedBox(height: 20),
              FadeTransition(
                opacity: _controller,
                child: GameButton.text(
                  color: ButtonColor.green,
                  text: "PLAY",
                  fontSize: 30,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  onPressed: () {
                    widget.game.overlays.remove(GameOverlay.mainMenu.name);
                    game.startGame();
                  },
                ),
              ),
              Row(
                children: [
                  GameButton(
                    onPressed: () {
                      widget.game.overlays.remove(GameOverlay.mainMenu.name);
                      widget.game.overlays.add(GameOverlay.settings.name);
                    },
                    color: ButtonColor.green,
                    child: const GameIcon(
                      icon: Icons.settings,
                      iconColor: Colors.redAccent,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  const GameButton(
                    color: ButtonColor.green,
                    child: GameIcon(
                      icon: Icons.shopping_cart,
                      iconColor: Colors.redAccent,
                    ),
                  ),
                ],
              ),
              // GameButton.text(
              //   color: ButtonColor.green,
              //   text: "Settings".toUpperCase(),
              //   fontSize: 30,
              //   padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              //   onPressed: () {
              //     // widget.game.overlays.remove(GameOverlay.mainMenu.name);
              //     // game.startGame();
              //   },
              // ),
            ]),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   mainAxisSize: MainAxisSize.max,
            //   children: [
            //     Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            //       GameButton(
            //         borderWidth: 3,
            //         color: ButtonColor(yellowLinearGradient, redBorderColor),
            //         padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            //         onPressed: () {
            //           //  widget.game.overlays.remove(GameOverlay.mainMenu.name);
            //         },
            //         child: GameIcon(
            //           icon: Icons.volume_up_rounded,
            //           size: 40,
            //           iconColor: ButtonColor.red.borderColor,
            //         ),
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       GameButton(
            //         borderWidth: 3,
            //         color: ButtonColor(yellowLinearGradient, redBorderColor),
            //         padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            //         onPressed: () {
            //           //  widget.game.overlays.remove(GameOverlay.mainMenu.name);
            //         },
            //         child: GameIcon(
            //           icon: Icons.settings,
            //           size: 40,
            //           iconColor: ButtonColor.red.borderColor,
            //         ),
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       GameButton(
            //         borderWidth: 3,
            //         color: ButtonColor(yellowLinearGradient, redBorderColor),
            //         padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            //         onPressed: () {
            //           //  widget.game.overlays.remove(GameOverlay.mainMenu.name);
            //         },
            //         child: GameIcon(
            //           icon: Icons.music_note_outlined,
            //           size: 40,
            //           iconColor: ButtonColor.red.borderColor,
            //         ),
            //       ),
            //     ]),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
  }
}
