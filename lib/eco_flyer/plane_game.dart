// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_game_challenge/eco_flyer/components/consumbles/coin.dart';
import 'package:flutter_game_challenge/eco_flyer/components/consumbles/coin_generator.dart';
import 'package:flutter_game_challenge/eco_flyer/components/platform/platfrom.dart';
import 'package:flutter_game_challenge/eco_flyer/components/powerups/sheild.dart';
import 'package:flutter_game_challenge/game_data/controls/game_controls.dart';
import 'package:flutter_game_challenge/hud/hud.dart';

import 'components/obstacles/obstacles_generator.dart';
import 'components/player/plane.dart';
import 'core/constants.dart';

class PlaneGame extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks, HasCollisionDetection, TapCallbacks {
  bool tappedDown = false;
  bool incrementScore = true;
  //Score
  int score = 0;
  final style = TextStyle(color: BasicPalette.black.color);

  late final regular = TextPaint(style: style);
  late TextComponent scoreText = TextComponent(text: 'Score: $score', textRenderer: regular)
    ..anchor = Anchor.centerLeft
    ..x = width * 0.05 // size is a property from game
    ..y = height * 0.06;

  late TextComponent livesText = TextComponent(text: 'Life: $lives', textRenderer: regular)
    ..anchor = Anchor.centerLeft
    ..x = width * 0.05 // size is a property from game
    ..y = height * 0.04;
  late TextComponent coinsText = TextComponent(text: 'Coins: $coinsCollected', textRenderer: regular)
    ..anchor = Anchor.centerLeft
    ..x = width * 0.05 // size is a property from game
    ..y = height * 0.02;
  // objects
  late ObstacleGenerator obstacleGenerator;
  late CoinGenerator coinGenerator;
  late PaperPLane plane;
  late Shield shield;
  late Coin coin;
  bool isGamePlaying = false;
  bool isGameStarted = false;
  bool canFlyDown = true;
  //
  double get height => size.y;
  double get width => size.x;

  int lives = GameControls.allowedLives;
  int coinsCollected = 0;

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
    maxY = size.y - blockSize * 0.5;
    minY = blockSize / 6;
    gameHeight = size.y;
    gameWidth = size.x;
    planeFixedX = gameWidth * 0.15;
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
      respawn();
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

  void start() {
    isGamePlaying = true;
    overlays.remove(GameOverlay.mainMenu.name);
    resume(easyResume: false);
    respawn(delay: false);
    reset();
  }

  void stopGame() {
    isGamePlaying = false;
    (world as Platform).stopBackground();
  }

  void pause() {
    stopGame();
    overlays.add(GameOverlay.pause.name);
  }

  Future<void> resume({bool easyResume = true}) async {
    overlays.remove(GameOverlay.pause.name);
    if (easyResume) {
      await Future.delayed(const Duration(milliseconds: 500));
    }
    if (!isGameStarted) {
      isGameStarted = true;
    }
    (world as Platform).startBackground();
  }

  @override
  FutureOr<void> onLoad() async {
    // debugMode = true;

    await images.loadAllImages();

    initDimensions();
    world = Platform();
    obstacleGenerator = ObstacleGenerator();
    plane = PaperPLane();
    coinGenerator = CoinGenerator();

    camera = CameraComponent.withFixedResolution(
      world: world,
      width: size.x,
      height: size.y,
    );
    camera.viewfinder.anchor = Anchor.topLeft;

    await world.addAll([
      plane,
      obstacleGenerator,
      coinGenerator,
      scoreText,
      livesText,
      coinsText,
    ]);

    super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    tappedDown = true;
    super.onTapDown(event);
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    tappedDown = false;
    super.onTapCancel(event);
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
    if (tappedDown && canFlyDown) {
      canFlyDown = false;
      plane.isFlyingUp = true;
      Future.delayed(const Duration(milliseconds: 150), () {
        canFlyDown = true;
        plane.isFlyingUp = false;
      });
    }
    if (isGamePlaying && incrementScore) {
      incrementScore = false;
      score += 1;
      scoreText.text = 'Score: $score';
      Future.delayed(const Duration(milliseconds: 100), () {
        incrementScore = true;
      });
    }
    livesText.text = 'Life: $lives';
    coinsText.text = 'Coins: $coinsCollected';
    super.update(dt);
  }

  void reduceLife() {
    if (lives > 0) {
      lives--;
    }
  }

  void collectCoin(Coin coin) {
    coinsCollected += coin.value;
  }

  void reset() {
    lives = GameControls.allowedLives;
    score = 0;
    coinsCollected = 0;
  }

  void restartGame() {
    reset();
    respawn(delay: false);
    start();
  }

  Future<void> respawn({bool delay = true}) async {
    if (delay) await Future.delayed(const Duration(seconds: 2));
    if (plane.isRemoved) {
      plane = PaperPLane();
      world.add(plane);
    }
  }

  void terminateGame() {
    isGamePlaying = false;
    Future.delayed(const Duration(seconds: 1), () {
      overlays.add(GameOverlay.gameOver.name);
    });
  }

  void exitToMainScreen() {
    overlays.removeAll(GameOverlay.values.map((e) => e.name).toList());
    overlays.add(GameOverlay.mainMenu.name);
  }
}
