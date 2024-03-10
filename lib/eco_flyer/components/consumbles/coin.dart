//
import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter_game_challenge/eco_flyer/core/constants.dart';
import 'package:flutter_game_challenge/eco_flyer/plane_game.dart';

class Coin extends SpriteAnimationComponent with HasGameRef<PlaneGame>, CollisionCallbacks {
  late final SpriteAnimation _collectedAnimation;
  late final SpriteAnimation _coinAnimation;
  final Timer _timer = Timer(2, repeat: true);

  // assets
  final String coinSpritesheet = "Coin/coin_";
  final String collectedSpriteSheet = "Coin/coin_collected.png";

  final double dripHeight = blockSize * 0.3;
  final int value;
  final double pos_x;
  final double pos_y;
  Coin(this.pos_x, this.pos_y) : value = 1;
  Coin.v1(this.pos_x, this.pos_y) : value = 1;
  Coin.v5(this.pos_x, this.pos_y) : value = 5;
  Coin.v10(this.pos_x, this.pos_y) : value = 10;
  Coin.v20(this.pos_x, this.pos_y) : value = 20;

  @override
  void onMount() {
    _timer.start();
    super.onMount();
  }

  @override
  FutureOr<void> onLoad() async {
    //  debugMode = true;
    size = Vector2(game.coinGenerator.coinSize.toDouble(), game.coinGenerator.coinSize.toDouble());
    position = Vector2(pos_x, pos_y);
    add(CircleHitbox());

    await _loadAnimations().then((_) => {animation = _coinAnimation});
    super.onLoad();
  }

  Future<void> _loadAnimations() async {
    final coinSheet = SpriteSheet(
      image: await game.images.load(coinSpritesheet + "$value.png"),
      srcSize: Vector2.all(128),
    );

    _coinAnimation = coinSheet.createAnimation(
      row: 0,
      stepTime: 0.25,
    );

    _collectedAnimation = SpriteAnimation.fromFrameData(
        game.images.fromCache(collectedSpriteSheet),
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.05,
          textureSize: Vector2(32, 32),
          loop: false,
        ));
  }

  @override
  void update(double dt) {
    _timer.update(dt);
    x -= obstaclesSpeed / 2 * dt;
    if (x + width < 0) {
      if (game.world.contains(this)) {
        game.coinGenerator.removeCoin(this);
      }
    }
    super.update(dt);
  }

  Future<void> consumed() async {
    animation = _collectedAnimation;
    game.collectCoin(this);
    _timer.stop();
    await animationTicker?.completed;
    game.coinGenerator.removeCoin(this);
  }
}
