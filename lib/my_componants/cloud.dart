import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_game_challenge/components/bounding_box/collision_block.dart';
import 'package:flutter_game_challenge/components/player.dart';
import 'package:flutter_game_challenge/plane.dart';

class Cloud extends RectangleComponent with HasGameRef<PlaneGame>, CollisionCallbacks {
  Cloud({
    super.position,
    super.size,
  });

  late CollisionBlock collisionBlock = CollisionBlock(
    position: position,
    size: size,
  );
  late final Player player;

  @override
  FutureOr<void> onLoad() {
    // add(collisionBlock);
    player = game.player;

    add(RectangleHitbox(position: position, size: size));
    return super.onLoad();
  }

  void collidedWithPlayer() async {
    print("Colided With Obstacle");
    player.collidedwithEnemy();
  }
}
