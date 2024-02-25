// import 'dart:async';

// import 'package:flame/collisions.dart';
// import 'package:flame/components.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_game_challenge/eco_flyer/plane_game.dart';

// import '../data/constants/constants.dart';

// class Tree extends SpriteComponent with HasGameRef<PlaneGame>, CollisionCallbacks {
//   late final SpriteComponent tree;
//   final double speed = 150;

//   // late CollisionBlock collisionBlock = CollisionBlock(
//   //   position: position,
//   //   size: size,
//   // );
//   Paint cloudColor = Paint()..color = Colors.white;

//   Tree();

//   void collidedWithPlayer() async {
//     // player.collidedwithEnemy();
//   }

//   ShapeHitbox createhitBox(Vector2 thissize, Vector2 thisposition) {
//     return RectangleHitbox()
//       ..size = thissize
//       ..position = thisposition
//       ..paint = cloudColor
//       ..renderShape = true;
//   }

//   @override
//   Future<FutureOr<void>> onLoad() async {
//     super.onLoad();
//     // load image

//     sprite = await gameRef.loadSprite('Terrain/treeL.png');
//     size = Vector2(blockSize, blockSize * 2);
//     tree = SpriteComponent(size: size, sprite: sprite);

//     position = Vector2(gameWidth + blockSize * 0.5, minY + blockSize * 2);
//     // bloc = createhitBox(size, position);

//     add(tree);
//   }

//   @override
//   void update(double dt) {
//     x -= speed * dt;
//     if (x + width < 0) {
//       removeFromParent();
//       // x = gameWidth + width;
//     }
//     super.update(dt);
//   }
// }
