import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game_challenge/game_data/constants/constants.dart';
import 'package:flutter_game_challenge/plane_game.dart';

class PlanePlayer extends RectangleComponent with HasGameRef<PlaneGame>, CollisionCallbacks {
  PlanePlayer({
    super.position,
    super.size,
  });

  //current speed along y-axis.
  double speedY = 0.0;
  final double jumpHeight = 150;

  static const double gravity = -250;

  @override
  FutureOr<void> onLoad() {
    Paint planeColor = Paint()..color = Colors.amber;

    ShapeHitbox planeHitbox = RectangleHitbox()
      ..size = size
      ..paint = planeColor
      ..renderShape = true;

    add(planeHitbox);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    // v = u + at 800 * 0.0165
    speedY += gravity * dt;

    // d = s0 + s * t
    double tempY = speedY * dt;
    // print(tempY);
    // print(maxY);
    // if (y + tempY >= minY && y + tempY + height <= maxY) {

    // }

    if (y + tempY + height >= maxY) {
      y = maxY - height;
    } else {
      y += tempY;
    }

    /// This code makes sure that dino never goes beyond [yMax].
    if (isOnGround) {
      y = minY;
      speedY = 0.0;
    }

    super.update(dt);
  }

  // Returns true if Plane is on top.
  bool get isOnGround => (y <= minY);

  // Makes the dino jump.
  void jump() {
    // Jump only if dino is on ground.

    speedY = jumpHeight;
  }
}
