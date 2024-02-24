// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game_challenge/components/bounding_box/collision_block.dart';
import 'package:flutter_game_challenge/eco_flyer/plane_game.dart';

import '../../../data/constants/constants.dart';

class ObstaclesBlock extends RectangleComponent with HasGameRef<PlaneGame>, CollisionCallbacks {
  int spaceIndex;
  final double speed = 150;

  late CollisionBlock collisionBlock = CollisionBlock(
    position: position,
    size: size,
  );

  Paint cloudColor = Paint()..color = Colors.white;
  late ShapeHitbox bloc;
  ShapeHitbox? bloc2;
  ObstaclesBlock({required this.spaceIndex, super.size, super.position});

  void collidedWithPlayer() async {
    // player.collidedwithEnemy();
  }

  ShapeHitbox createhitBox(Vector2 size, Vector2 position) {
    return RectangleHitbox()
      ..size = size
      ..position = position
      ..paint = cloudColor
      ..renderShape = true;
  }

  @override
  FutureOr<void> onLoad() {
    // add(collisionBlock);

    switch (spaceIndex) {
      case 0:
        bloc = createhitBox(Vector2(blockSize, blockSize * 3), Vector2(gameWidth + blockSize * 0.5, minY + blockSize));

      case 1:
        bloc = createhitBox(Vector2(blockSize, blockSize), Vector2(gameWidth + blockSize * 0.5, minY));
        bloc2 = createhitBox(Vector2(blockSize, blockSize * 2), Vector2(gameWidth + blockSize * 0.5, minY + blockSize * 2));

      case 2:
        bloc = createhitBox(Vector2(blockSize, blockSize * 2), Vector2(gameWidth + blockSize * 0.5, minY));
        bloc2 = createhitBox(Vector2(blockSize, blockSize), Vector2(gameWidth + blockSize * 0.5, minY + blockSize * 3));
      case 3:
        bloc = createhitBox(Vector2(blockSize, blockSize * 3), Vector2(gameWidth + blockSize * 0.5, minY));
    }

    bloc = RectangleHitbox()
      ..size = Vector2(blockSize, blockSize * 3)
      ..position = Vector2(gameWidth + blockSize * 0.5, minY)
      ..paint = cloudColor;

    add(bloc);
    // if (bloc2 != null) {
    //   add(bloc2!);
    // }
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
}
