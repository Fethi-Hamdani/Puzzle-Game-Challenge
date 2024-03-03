// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter_game_challenge/eco_flyer/components/obstacles/acid_cloud.dart';
import 'package:flutter_game_challenge/eco_flyer/plane_game.dart';

import '../../core/constants.dart';

class ObstacleGenerator extends Component with HasGameRef<PlaneGame> {
  late SpriteAnimationComponent acidCloud;

  SpriteAnimationComponent _lastGeneratedCloud = AcidCloud();
  bool firstObject = true;
  final double _speedScalingFactor = 0.5;
  final double _minDistanceBetweenObstacles = blockSize * 2; // Adjust as needed

  void generateObstacles(double dt) {
    if (!game.isGamePlaying) return;

    obstaclesSpeed = obstaclesSpeed >= 500 ? 500 : obstaclesSpeed + dt;

    if (_lastGeneratedCloud.x + blockSize + _minDistanceBetweenObstacles < game.width || firstObject) {
      _controlObjectsBasedOnScore();
    }
  }

  @override
  void update(double dt) {
    generateObstacles(dt);
    super.update(dt);
  }

  void _controlObjectsBasedOnScore() {
    firstObject = false;

    if (game.score > 600) {
      acidCloud = AcidCloud.large();
    }
    if (game.score < 600) {
      bool large_Cloud = Random(DateTime.now().millisecondsSinceEpoch).nextInt(100) <= 70;
      acidCloud = large_Cloud ? AcidCloud.large() : AcidCloud();
    }
    if (game.score < 300) {
      bool large_Cloud = Random(DateTime.now().millisecondsSinceEpoch).nextInt(100) <= 10;
      acidCloud = large_Cloud ? AcidCloud.large() : AcidCloud();
    }
    if (game.score < 150) {
      acidCloud = AcidCloud();
    }

    game.world.add(acidCloud);
    _lastGeneratedCloud = acidCloud;
  }
}
