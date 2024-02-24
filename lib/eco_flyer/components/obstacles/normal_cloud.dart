import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../core/constants.dart';
import '../../plane_game.dart';

class NormalCloud extends SpriteAnimationComponent with HasGameRef<PlaneGame>, CollisionCallbacks {
  //
  late final SpriteAnimation _normalCloudAnimation;
  final normalCloudSpritesheet = "Acid/normal_cloud.png";

  //
  late double cloudHeight;
  late double cloudwidth;

  @override
  Future<FutureOr<void>> onLoad() async {
    super.onLoad();
    cloudwidth = blockSize * 1.5;
    cloudHeight = cloudwidth * 0.68;

    size = Vector2(cloudwidth, cloudHeight);
    position = Vector2(gameWidth + width, minY + blockSize);

    await _loadAnimations().then((_) => {animation = _normalCloudAnimation});
  }

  @override
  void update(double dt) {
    x -= obstaclesSpeed * dt;
    if (x + width < 0) {
      removeFromParent();
      // x = game.width;
    }
    super.update(dt);
  }

  _loadAnimations() async {
    final dropSpriteSheet = SpriteSheet(
      image: await game.images.load(normalCloudSpritesheet),
      srcSize: Vector2(2505 * 4, 1680 * 4),
    );

    _normalCloudAnimation = dropSpriteSheet.createAnimation(
      row: 0,
      from: 0,
      to: 1,
      stepTime: 0.25,
    );
  }
}
