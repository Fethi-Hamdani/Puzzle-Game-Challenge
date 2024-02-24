import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game_challenge/components/bounding_box/collision_block.dart';
import 'package:flutter_game_challenge/eco_flyer/plane_game.dart';

class Cloud extends RectangleComponent with HasGameRef<PlaneGame>, CollisionCallbacks {
  Cloud({
    super.position,
    super.size,
  });

  final double speed = 150;

  late CollisionBlock collisionBlock = CollisionBlock(
    position: position,
    size: size,
  );
  Paint cloudColor = Paint()..color = Colors.white;
  late ShapeHitbox bloc;

  @override
  FutureOr<void> onLoad() {
    bloc = createhitBox(size, position);

    add(bloc);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    x -= speed * dt;
    if (x + width < 0) {
      removeFromParent();
      // x = gameWidth + width;
    }
    super.update(dt);
  }

  void collidedWithPlayer() async {
    // player.collidedwithEnemy();
  }

  ShapeHitbox createhitBox(Vector2 thissize, Vector2 thisposition) {
    return RectangleHitbox()
      ..size = thissize
      ..position = thisposition
      ..paint = cloudColor
      ..renderShape = true;
  }
}
