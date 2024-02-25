import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game_challenge/eco_flyer/components/player/plane.dart';
import 'package:flutter_game_challenge/eco_flyer/core/constants.dart';

class Shield extends PositionComponent {
  late double SHIELD_RADIUS;
  final PaperPLane plane;

  Shield(this.plane) {
    SHIELD_RADIUS = blockSize * 0.8;
  }

  @override
  FutureOr<void> onLoad() {
    // TODO: implement onLoad

    size = Vector2(SHIELD_RADIUS, SHIELD_RADIUS);
    // position = Vector2(0, 0);
    super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    // Draw outline for shield
    canvas.drawCircle(
      Offset(plane.x, plane.y),
      SHIELD_RADIUS,
      Paint()
        ..color = Colors.blue
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0, // Adjust outline thickness as needed
    );
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    if (plane.x <= 0) {
      removeFromParent();
    }
  }
}
