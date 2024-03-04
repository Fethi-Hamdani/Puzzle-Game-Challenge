import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_game_challenge/eco_flyer/plane_game.dart';
import 'package:flutter_game_challenge/hud/constants/button_colors.dart';
import 'package:flutter_game_challenge/hud/hud.dart';
import 'package:flutter_game_challenge/hud/widgets/overlay_header.dart';

import '../widgets/button.dart';

// costs 5 diamonds per spin
class FortuneWheelScreen extends StatefulWidget {
  final PlaneGame game;
  const FortuneWheelScreen({super.key, required this.game});

  @override
  State<FortuneWheelScreen> createState() => _FortuneWheelScreenState();
}

class _FortuneWheelScreenState extends State<FortuneWheelScreen> {
  StreamController<int> selected = StreamController<int>.broadcast();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final items = <String>[
      'Grogu',
      'Mace Windu',
      'Obi-Wan Kenobi',
      'Han Solo',
      'Luke Skywalker',
      'Darth Vader',
      'Yoda',
      'Ahsoka Tano',
    ];
    return SizedBox(
      height: screenHeight * 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          OverlayHeader(
            title: "Fortune Wheel".toUpperCase(),
            onPressed: () {
              widget.game.overlays.remove(GameOverlay.fortuneWheel.name);
              widget.game.overlays.add(GameOverlay.mainMenu.name);
              // game.startGame();
            },
          ),
          SizedBox(
            height: screenHeight * 0.6,
            child: FortuneWheel(
              selected: selected.stream,
              items: [
                for (var it in items) FortuneItem(child: Text(it)),
              ],
              rotationCount: items.length * 3,
              animateFirst: false,
            ),
          ),
          GameButton.text(
            color: ButtonColor.green,
            text: "Spin".toUpperCase(),
            fontSize: 16,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            onPressed: () {
              selected.add(
                Fortune.randomInt(0, items.length),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }
}
