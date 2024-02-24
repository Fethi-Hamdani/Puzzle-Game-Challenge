// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_game_challenge/eco_flyer/components/platform/platfrom.dart';

import 'components/obstacles/obstacles_generator.dart';
import 'components/player/plane.dart';
import 'core/constants.dart';

class PlaneGame extends FlameGame with HasKeyboardHandlerComponents, DragCallbacks, HasCollisionDetection, TapCallbacks {
  bool tappedDown = false;

  //Score
  int score = 0;
  final style = TextStyle(color: BasicPalette.black.color);

  late final regular = TextPaint(style: style);
  late TextComponent scoreText = TextComponent(text: 'Hello, Flame', textRenderer: regular)
    ..anchor = Anchor.topCenter
    ..x = width / 2 // size is a property from game
    ..y = 32.0;
  // objects
  late World myworld;
  late ObstacleGenerator obstacleGenerator;
  late PaperPLane plane;

  //
  double get height => size.y;
  double get width => size.x;

  @override
  Color backgroundColor() {
    // TODO: implement backgroundColor
    return const Color(0xFF53B4DA);
  }

  void initDimensions() {
    // init variables
    blockSize = size.y / 6;
    maxY = size.y - blockSize * 0.8;
    minY = blockSize / 2;
    gameHeight = size.y;
    gameWidth = size.x;
    planeFixedX = gameWidth * 0.25;
    planeFixedY = gameHeight * 0.5;
  }

  @override
  KeyEventResult onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    super.onKeyEvent(event, keysPressed);
    final isR = keysPressed.contains(LogicalKeyboardKey.keyR);

    if (isR) {
      if (plane.isRemoved) {
        plane = PaperPLane();
        world.add(plane);
      }

      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  FutureOr<void> onLoad() async {
    // debugMode = true;

    await images.loadAllImages();

    initDimensions();
    myworld = Platform();
    world = myworld;
    obstacleGenerator = ObstacleGenerator();
    plane = PaperPLane();

    camera = CameraComponent.withFixedResolution(
      world: world,
      width: size.x,
      height: size.y,
    );
    camera.viewfinder.anchor = Anchor.topLeft;

    await world.addAll([obstacleGenerator, plane, scoreText]);

    super.onLoad();
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
  void update(double dt) {
    if (tappedDown) {
      plane.isFlyingUp = true;
    }
    score += (60 * dt).toInt();
    scoreText.text = score.toString();
    super.update(dt);
  }
}
