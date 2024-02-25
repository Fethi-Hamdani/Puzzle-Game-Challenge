import 'package:flutter/material.dart';
import 'package:flutter_game_challenge/eco_flyer/plane_game.dart';
import 'package:flutter_game_challenge/hud/constants/button_colors.dart';
import 'package:flutter_game_challenge/hud/widgets/button.dart';

class PauseScreen extends StatelessWidget {
  PlaneGame game;
  PauseScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Pause Screen', style: TextStyle(fontSize: 48)),
            SizedBox(
              height: 10,
            ),
            GameButton.text(
              color: ButtonColor.red,
              text: "Red Button",
            ),
            SizedBox(
              height: 10,
            ),
            GameButton.text(
              color: ButtonColor.grey,
              text: "Grey Button",
            ),
            SizedBox(
              height: 10,
            ),
            GameButton.text(
              color: ButtonColor.yellow,
              text: "Yellow Button",
            ),
            SizedBox(
              height: 10,
            ),
            GameButton.text(
              color: ButtonColor.green,
              text: "Green Button",
            ),
            SizedBox(
              height: 10,
            ),
            GameButton.text(
              color: ButtonColor.red,
              text: "EXIT",
              outline: false,
            ),
          ],
        ),
      ),
    );
  }
}
