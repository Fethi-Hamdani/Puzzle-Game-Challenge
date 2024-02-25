// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter_game_challenge/eco_flyer/components/obstacles/acid_cloud.dart';
import 'package:flutter_game_challenge/eco_flyer/plane_game.dart';

import '../../core/constants.dart';

class ObstacleGenerator extends Component with HasGameRef<PlaneGame> {
  final Random _random = Random();

  late SpriteAnimationComponent acidCloud;

  SpriteAnimationComponent _lastGeneratedCloud = AcidCloud();
  bool firstObject = true;
  final double _speedScalingFactor = 0.5;
  final double _minDistanceBetweenObstacles = blockSize * 2; // Adjust as needed

  void generateObstacles(double dt) {
    // print(game.width);

    // print(_lastGeneratedCloud);
    // print(_lastGeneratedCloud.x + blockSize + _minDistanceBetweenObstacles);
    // print(_lastGeneratedCloud.x + blockSize + _minDistanceBetweenObstacles < game.width);
    obstaclesSpeed = obstaclesSpeed >= 500 ? 500 : obstaclesSpeed + dt;

    if (_lastGeneratedCloud.x + blockSize + _minDistanceBetweenObstacles < game.width || firstObject) {
      //
      firstObject = false;

      acidCloud = AcidCloud();

      game.world.add(acidCloud);
      _lastGeneratedCloud = acidCloud;
    }
  }

  @override
  void update(double dt) {
    generateObstacles(dt);
    super.update(dt);
  }
}
