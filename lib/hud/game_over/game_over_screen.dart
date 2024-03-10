import 'package:flutter/material.dart';
import 'package:flutter_game_challenge/eco_flyer/plane_game.dart';
import 'package:flutter_game_challenge/hud/constants/button_colors.dart';
import 'package:flutter_game_challenge/hud/hud.dart';
import 'package:flutter_game_challenge/hud/widgets/button.dart';
import 'package:flutter_game_challenge/hud/widgets/card.dart';
import 'package:flutter_game_challenge/hud/widgets/text.dart';

class GameOverScreen extends StatelessWidget {
  PlaneGame game;
  GameOverScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.3),
      child: Center(
        child: GameCard(
          borderColor: ButtonColor.grey.borderColor,
          gradientColors: ButtonColor.grey.gradientColors,
          padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
          borderWidth: 5,
          cornerRadius: 15,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GameText(
                  text: 'Game Over',
                  borderColor: ButtonColor.yellow.borderColor,
                  textColor: Colors.amberAccent,
                  fontSize: 50),
              SizedBox(
                height: 5,
              ),
              GameText(
                  text: 'You failed to save the planet, Try again later',
                  borderColor: ButtonColor.grey.borderColor,
                  borderWidth: 0,
                  textColor: Colors.black45,
                  showShadow: false,
                  fontSize: 20),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GameButton.text(
                    color: ButtonColor.green,
                    text: "Play Again",
                    onPressed: () {
                      game.overlays.remove(GameOverlay.gameOver.name);
                      game.restartGame();
                    },
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  GameButton.text(
                    color: ButtonColor.red,
                    text: "Exit",
                    onPressed: () {
                      game.exitToMainScreen();
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
