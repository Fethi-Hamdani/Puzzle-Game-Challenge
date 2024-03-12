// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_game_challenge/eco_flyer/plane_game.dart';
import 'package:flutter_game_challenge/hud/constants/button_colors.dart';
import 'package:flutter_game_challenge/hud/widgets/button.dart';

import '../hud.dart';

class GameDialog extends StatelessWidget {
  PlaneGame game;
  String? notice;
  GameDialog({
    Key? key,
    required this.game,
    this.notice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.withOpacity(0.5),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Pause Screen', style: TextStyle(fontSize: 48)),
            const SizedBox(
              height: 10,
            ),
            GameButton.text(
              color: ButtonColor.green,
              text: "Exit",
              onPressed: () {
                game.overlays.remove(GameOverlay.dialog.name);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const GameButton.text(
              color: ButtonColor.red,
              text: "Exit",
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
