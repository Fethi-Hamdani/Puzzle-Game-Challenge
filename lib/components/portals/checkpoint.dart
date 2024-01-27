import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_game_challenge/components/player.dart';
import 'package:flutter_game_challenge/data/constants/animations.dart';
import 'package:flutter_game_challenge/data/constants/hitboxes.dart';
import 'package:flutter_game_challenge/data/controls/game_controls.dart';
import 'package:flutter_game_challenge/pixel_adventure.dart';

class Checkpoint extends SpriteAnimationComponent with HasGameRef<PixelAdventure>, CollisionCallbacks {
  Checkpoint({position, size}) : super(position: position, size: size);

  @override
  FutureOr<void> onLoad() {
    debugMode = GameControls.debugMode;
    add(Hitboxes.checkpointHitbox);
    animation = game.checkPointNoFlagAnimation();
    return super.onLoad();
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) _reachedCheckpoint();
    super.onCollisionStart(intersectionPoints, other);
  }

  void _reachedCheckpoint() async {
    animation = game.checkPointFlagOutAnimation();
    await animationTicker?.completed;
    animation = game.checkPointFlagIdleAnimation();
  }
}
