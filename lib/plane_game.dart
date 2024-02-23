import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/services/keyboard_key.g.dart';
import 'package:flutter_game_challenge/components/obstacles/obstacles_manager.dart';
import 'package:flutter_game_challenge/hud/hud.dart';
import 'package:flutter_game_challenge/my_componants/plane.dart';
import 'package:flutter_game_challenge/platfrom.dart';

import 'game_data/constants/constants.dart';

class PlaneGame extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks, HasCollisionDetection, TapCallbacks {
  // PlaneGame()
  //     : super(
  //         camera: CameraComponent.withFixedResolution(
  //           width: 640,
  //           height: 360,
  //         ),
  //       );

  double get width => size.x;
  double get height => size.y;
  late PlanePlayer plane = PlanePlayer();
  late World myworld = PlayArea();
  late ObstaclesManager obstaclesManager;

  bool tappedDown = false;

  //Score
  int score = 0;
  final style = TextStyle(color: BasicPalette.black.color);
  late final regular = TextPaint(style: style);
  late TextComponent scoreText = TextComponent(text: 'Hello, Flame', textRenderer: regular)
    ..anchor = Anchor.topCenter
    ..x = width / 2 // size is a property from game
    ..y = 32.0;

  @override
  Color backgroundColor() {
    // TODO: implement backgroundColor
    return Colors.blueAccent;
  }

  @override
  FutureOr<void> onLoad() async {
    Future.delayed(
      const Duration(seconds: 1),
      () async {
        await images.loadAllImages();

        // init variables
        blockSize = size.y / 6;
        maxY = size.y - blockSize;
        minY = blockSize;
        gameHeight = size.y;
        gameWidth = size.x;

        // //
        plane.position = Vector2(150, blockSize);
        plane.size = Vector2.all(blockSize * 0.8);

        world = myworld;

        camera = CameraComponent.withFixedResolution(
          world: world,
          width: size.x,
          height: size.y,
        );
        // camera.viewfinder.anchor = const Anchor(0.05, 0);
        camera.viewfinder.anchor = Anchor.topLeft;

        // await world.add(camera);
        await world.add(plane);

        // camera.follow(
        //   plane,
        //   horizontalOnly: true,
        // );

        //
        obstaclesManager = ObstaclesManager();
        await world.add(obstaclesManager);

        await world.add(scoreText);
      },
    );

    super.onLoad();
  }

  @override
  void update(double dt) {
    if (tappedDown) {
      plane.jump();
    }
    score += (60 * dt).toInt();
    // print(score);
    scoreText.text = score.toString();
    super.update(dt);
  }

  @override
  void onTapDown(TapDownEvent event) {
    tappedDown = true;
    super.onTapDown(event);
  }

  @override
  void onTapUp(TapUpEvent event) {
    tappedDown = false;
    super.onTapUp(event);
  }

  @override
  KeyEventResult onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    bool showMenu = keysPressed.contains(LogicalKeyboardKey.keyM);
    if (showMenu) {
      if (overlays.isActive(GameOverlay.pause.name)) {
        overlays.remove(GameOverlay.pause.name);
      } else {
        overlays.add(GameOverlay.pause.name);
      }
    }

    return super.onKeyEvent(event, keysPressed);
  }
}
