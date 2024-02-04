// import 'dart:async';
// import 'dart:ui';

// import 'package:flame/collisions.dart';
// import 'package:flame/components.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_game_challenge/components/player.dart';
// import 'package:flutter_game_challenge/plane.dart';

// class Chicken extends RectangleComponent with HasGameRef<PlaneGame>, CollisionCallbacks {
//   final double offNeg;
//   final double offPos;
//   Chicken({
//     super.position,
//     super.size,
//     this.offNeg = 0,
//     this.offPos = 0,
//   });

//   static const tileSize = 16;
//   static const runSpeed = 80;
//   static const _bounceHeight = 260.0;

//   Vector2 velocity = Vector2.zero();
//   double rangeNeg = 0;
//   double rangePos = 0;
//   double moveDirection = 1;
//   double targetDirection = -1;
//   bool gotStomped = false;

//   late final Player player;

//   @override
//   FutureOr<void> onLoad() {
//     player = game.player;
//     Paint paint = Paint()..color = Colors.white;

//     ShapeHitbox hitbox = RectangleHitbox()
//       ..paint = paint
//       ..renderShape = true;

//     add(hitbox);

//     // game.world.add(RectangleComponent(
//     //   size: size,
//     //   position: position,
//     //   paint: Paint()..color = Colors.white,
//     // ));

//     // _loadAllAnimations();
//     // _calculateRange();
//     return super.onLoad();
//   }

//   @override
//   void update(double dt) {
//     if (!gotStomped) {
//       // _updateEnemyState();
//       // _movement(dt);
//     }

//     super.update(dt);
//   }

//   void _loadAllAnimations() {
//     // animations = {
//     //   EnemyState.idle: game.chickenAnimations(EnemyState.idle, 13),
//     //   EnemyState.run: game.chickenAnimations(EnemyState.run, 14),
//     //   EnemyState.hit: game.chickenAnimations(EnemyState.hit, 15)..loop = false,
//     // };

//     // current = EnemyState.idle;
//   }

//   void _calculateRange() {
//     rangeNeg = position.x - offNeg * tileSize;
//     rangePos = position.x + offPos * tileSize;
//   }

//   void _movement(dt) {
//     // set velocity to 0
//     velocity.x = 0;

//     double playerOffset = (player.scale.x > 0) ? 0 : -player.width;
//     double chickenOffset = (scale.x > 0) ? 0 : -width;

//     if (playerInRange()) {
//       targetDirection = (player.x + playerOffset < position.x + chickenOffset) ? -1 : 1;
//       velocity.x = targetDirection * runSpeed;
//     }

//     moveDirection = lerpDouble(moveDirection, targetDirection, 0.1) ?? 1;

//     position.x += velocity.x * dt;
//   }

//   bool playerInRange() {
//     double playerOffset = (player.scale.x > 0) ? 0 : -player.width;

//     return player.x + playerOffset >= rangeNeg &&
//         player.x + playerOffset <= rangePos &&
//         player.y + player.height > position.y &&
//         player.y < position.y + height;
//   }

//   // void _updateEnemyState() {
//   //   current = (velocity.x != 0) ? EnemyState.run : EnemyState.idle;

//   //   if ((moveDirection > 0 && scale.x > 0) || (moveDirection < 0 && scale.x < 0)) {
//   //     flipHorizontallyAroundCenter();
//   //   }
//   // }

//   void collidedWithPlayer() async {
//     // if (player.velocity.y > 0 && player.y + player.height > position.y) {
//     //   AudioControls.chickenGotStumpedSound();
//     //   gotStomped = true;
//     //   current = EnemyState.hit;
//     //   player.velocity.y = -_bounceHeight;
//     //   await animationTicker?.completed;
//     //   removeFromParent();
//     // } else {
//     player.collidedwithEnemy();
//     // }
//   }
// }
