// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_game_challenge/eco_flyer/components/platform/platfrom.dart';
import 'package:flutter_game_challenge/eco_flyer/components/powerups/sheild.dart';
import 'package:flutter_game_challenge/hud/hud.dart';

import 'components/obstacles/obstacles_generator.dart';
import 'components/player/plane.dart';
import 'core/constants.dart';

class PlaneGame extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks, HasCollisionDetection, TapCallbacks {
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
  late ObstacleGenerator obstacleGenerator;
  late PaperPLane plane;
  late Shield shield;
  bool isGamePlaying = false;

  //
  double get height => size.y;
  double get width => size.x;

  void addShield() {
    world.add(shield);
    // Add your logic to remove the shield after a certain duration
    // Future.delayed(Duration(seconds: 5), () {
    //   removeShield();
    // });
  }

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
    final button_R = keysPressed.contains(LogicalKeyboardKey.keyR);
    final button_Space = keysPressed.contains(LogicalKeyboardKey.space);
    final button_M = keysPressed.contains(LogicalKeyboardKey.keyM);

    if (button_R) {
      if (!isGamePlaying) return KeyEventResult.ignored;
      if (plane.isRemoved) {
        plane = PaperPLane();
        shield = Shield(plane);
        world.add(plane);
      }

      return KeyEventResult.handled;
    }
    if (button_Space) {
      if (!isGamePlaying) return KeyEventResult.ignored;
      if (plane.isOnShield) {
        removeShield();
        plane.isOnShield = false;
      } else {
        addShield();
        plane.isOnShield = true;
      }

      return KeyEventResult.handled;
    }
    if (button_M) {
      if (overlays.isActive(GameOverlay.pause.name)) {
        resume();
      } else {
        pause();
      }
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  void pause() {
    isGamePlaying = false;
    overlays.add(GameOverlay.pause.name);
  }

  void resume() {
    isGamePlaying = true;
    overlays.remove(GameOverlay.pause.name);
  }

  @override
  FutureOr<void> onLoad() async {
    // debugMode = true;

    await images.loadAllImages();

    initDimensions();
    world = Platform();
    obstacleGenerator = ObstacleGenerator();
    plane = PaperPLane();
    //shield = Shield(plane);

    camera = CameraComponent.withFixedResolution(
      world: world,
      width: size.x,
      height: size.y,
    );
    camera.viewfinder.anchor = Anchor.topLeft;

    // await world.addAll([obstacleGenerator, plane, scoreText]);
    await world.addAll([plane, scoreText]);

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

  void removeShield() {
    shield.removeFromParent();
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
