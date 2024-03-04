import 'package:flutter/material.dart';
import 'package:flutter_game_challenge/hud/constants/button_colors.dart';
import 'package:flutter_game_challenge/hud/constants/colors.dart';
import 'package:flutter_game_challenge/hud/widgets/button.dart';
import 'package:flutter_game_challenge/hud/widgets/text.dart';

import 'icon.dart';

class OverlayHeader extends StatelessWidget {
  final String title;

  final void Function() onPressed;
  const OverlayHeader({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GameText(
          text: "Shop".toUpperCase(),
          fontSize: 24,
          borderColor: greenBorderColor,
        ),
        GameButton(
          color: ButtonColor.red,
          padding: const EdgeInsets.all(8.0),
          onPressed: () => onPressed(),
          child: const GameIcon(icon: Icons.close, iconColor: Colors.white),
        ),
      ],
    );
  }
}
