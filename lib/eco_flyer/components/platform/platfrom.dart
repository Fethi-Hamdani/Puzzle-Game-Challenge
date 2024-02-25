import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter_game_challenge/components/bounding_box/collision_block.dart';
import 'package:flutter_game_challenge/eco_flyer/components/platform/background.dart';
import 'package:flutter_game_challenge/eco_flyer/plane_game.dart';

class Platform extends World with HasGameRef<PlaneGame> {
  late ParallaxComponent background;

  List<CollisionBlock> collisionBlocks = [];

  @override
  FutureOr<void> onLoad() async {
    _loadPlatform();

    return super.onLoad();
  }

  _loadPlatform() {
    background = Background();
    add(background);
  }

  void stopBackground() {
    background.parallax?.baseVelocity = Vector2(0, 0);
  }

  void startBackground() {
    background.parallax?.baseVelocity = Vector2(20, 0);
  }
}
