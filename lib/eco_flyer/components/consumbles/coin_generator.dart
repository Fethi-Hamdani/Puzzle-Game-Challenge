// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter_game_challenge/eco_flyer/components/consumbles/coin.dart';
import 'package:flutter_game_challenge/eco_flyer/plane_game.dart';

import '../../core/constants.dart';

class CoinGenerator extends Component with HasGameRef<PlaneGame> {
  late int row;
  late int column;
  final int coinSize = 45;
  final int coinTypes = 4;
  final double coinPadding = 1.2;
  SpriteAnimationComponent _lastGeneratedCoin = Coin(0, 0);
  bool firstObject = true;
  final double _minDistanceBetweenObstacles = blockSize * 2; // Adjust as needed

  void generateCoins(double dt) {
    if (!game.isGamePlaying) return;
    obstaclesSpeed = obstaclesSpeed >= 500 ? 500 : obstaclesSpeed + dt;

    if (_lastGeneratedCoin.x + blockSize + _minDistanceBetweenObstacles < game.width || firstObject) {
      column = Random(DateTime.now().millisecondsSinceEpoch).nextInt(3) + 4;
      row = Random(DateTime.now().millisecondsSinceEpoch).nextInt(3) + 1;
      int qarter = (gameHeight / 8).floor();
      double y_pos = qarter * (Random(DateTime.now().millisecondsSinceEpoch).nextInt(3) + 2);
      _spawnCoinsGrid(y_pos);
    }
  }

  int get maxCoins => row * column;

  @override
  void update(double dt) {
    generateCoins(dt);
    super.update(dt);
  }

  Future<void> _spawnCoinsGrid(double y_pos) async {
    if (firstObject) firstObject = false;

    for (int i = 0; i < row; i++) {
      for (int j = 0; j < column; j++) {
        final x = gameWidth + (j * coinSize * coinPadding);
        final y = y_pos + (i * coinSize * coinPadding);
        Coin coin = _spawnCoin(j, x, y);
        game.world.add(coin);
        _lastGeneratedCoin = coin;
        await Future.delayed(Duration(milliseconds: 10));
      }
    }
  }

  void removeCoin(Coin coin) {
    game.world.remove(coin);
  }

  Coin _spawnCoin(int index, double x, double y) {
    final value = column / coinTypes;
    if (index < value) {
      return Coin.v1(x, y);
    }
    if (index < value * 2) {
      return Coin.v5(x, y);
    }
    if (index < value * 3) {
      return Coin.v10(x, y);
    }
    return Coin.v20(x, y);
  }
}
