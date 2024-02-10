// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter_game_challenge/components/obstacles/hazards/block.dart';

import '../../data/constants/constants.dart';
import '../../my_componants/cloud.dart';
import '../../plane_game.dart';

class ObstaclesManager extends Component with HasGameRef<PlaneGame> {
  // Random generator required for randomly selecting enemy type.
  final Random _random = Random();

  // Timer to decide when to spawn next enemy.
  final Timer _timer = Timer(3, repeat: true);

  ObstaclesManager() {
    _timer.onTick = spawnObstacles;
  }

  void spawnObstacles() {
    int randomNumber = _random.nextInt(4);
    Cloud cloud = Cloud();
    Cloud? cloud2;

    switch (randomNumber) {
      case 0:
        cloud = Cloud(size: Vector2(blockSize, blockSize * 3), position: Vector2(gameWidth + blockSize * 0.5, minY + blockSize));

      case 1:
        cloud = Cloud(size: Vector2(blockSize, blockSize), position: Vector2(gameWidth + blockSize * 0.5, minY));
        cloud2 = Cloud(size: Vector2(blockSize, blockSize * 2), position: Vector2(gameWidth + blockSize * 0.5, minY + blockSize * 2));

      case 2:
        cloud = Cloud(size: Vector2(blockSize, blockSize * 2), position: Vector2(gameWidth + blockSize * 0.5, minY));
        cloud2 = Cloud(size: Vector2(blockSize, blockSize), position: Vector2(gameWidth + blockSize * 0.5, minY + blockSize * 3));
      case 3:
        cloud = Cloud(size: Vector2(blockSize, blockSize * 3), position: Vector2(gameWidth + blockSize * 0.5, minY));
    }

    game.world.add(cloud);

    if (cloud2 != null) {
      game.world.add(cloud2);
    }
  }

  @override
  void update(double dt) {
    _timer.update(dt);
    super.update(dt);
  }

  @override
  void onMount() {
    _timer.start();
    super.onMount();
  }
}
