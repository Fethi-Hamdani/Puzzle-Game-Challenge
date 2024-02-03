import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game_challenge/components/player.dart';
import 'package:flutter_game_challenge/data/enums/game_characters.dart';
import 'package:flutter_game_challenge/platfrom.dart';

class PlaneGame extends FlameGame with HasKeyboardHandlerComponents, DragCallbacks, HasCollisionDetection, TapCallbacks {
  // PlaneGame()
  //     : super(
  //         camera: CameraComponent.withFixedResolution(
  //           width: 640,
  //           height: 360,
  //         ),
  //       );

  double get width => size.x;
  double get height => size.y;
  late Player player;

  @override
  Color backgroundColor() {
    // TODO: implement backgroundColor
    return Colors.blueAccent;
  }

  @override
  FutureOr<void> onLoad() async {
    Future.delayed(const Duration(seconds: 1), () async {
      await images.loadAllImages();

      player = Player(character: GameCharacters.maskDude);
      //
      player.position = Vector2(150, height / 2);
      player.size = Vector2.all(height / 6 * 0.8);

      PlayArea playArea = PlayArea(player: player);
      world = playArea;

      camera = CameraComponent.withFixedResolution(
        world: world,
        width: size.x,
        height: size.y,
      );
      camera.viewfinder.anchor = const Anchor(0.05, 0);

      // await world.add(camera);
      await world.add(player);

      camera.follow(
        player,
        horizontalOnly: true,
      );
    });

    super.onLoad();
  }
}
