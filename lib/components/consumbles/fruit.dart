import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_game_challenge/game_data/constants/animations.dart';
import 'package:flutter_game_challenge/game_data/constants/hitboxes.dart';
import 'package:flutter_game_challenge/game_data/controls/audio_controls.dart';
import 'package:flutter_game_challenge/game_data/controls/game_controls.dart';
import 'package:flutter_game_challenge/game_data/enums/fruits.dart';
import 'package:flutter_game_challenge/game_data/enums/view_priority.dart';
import 'package:flutter_game_challenge/pixel_adventure.dart';

class Fruit extends SpriteAnimationComponent with HasGameRef<PixelAdventure>, CollisionCallbacks {
  final Fruits fruit;
  Fruit({required this.fruit, position, size}) : super(position: position, size: size);

  final double stepTime = 0.05;
  bool collected = false;

  @override
  FutureOr<void> onLoad() {
    debugMode = GameControls.debugMode;
    priority = ViewPriority.fruit;

    add(Hitboxes.fruitHitbox);
    animation = game.fruitAnimation(fruit);
    return super.onLoad();
  }

  void collidedWithPlayer() async {
    if (!collected) {
      collected = true;
      AudioControls.fruitCollectedSound();
      animation = game.fruitCollectedAnimation();
      await animationTicker?.completed;
      removeFromParent();
    }
  }
}
