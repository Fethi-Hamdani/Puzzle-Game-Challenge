import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../core/constants.dart';
import '../../plane_game.dart';

class Tree extends SpriteAnimationComponent with HasGameRef<PlaneGame>, CollisionCallbacks {
  //
  late final SpriteAnimation _treeAnimation;
  final treeSpritesheet = "Acid/tree.png";

  //
  late double treeHeight;
  late double treewidth;

  @override
  Future<FutureOr<void>> onLoad() async {
    super.onLoad();

    treewidth = blockSize * 2;
    treeHeight = treewidth * 0.97;

    size = Vector2(treewidth, treeHeight);
    position = Vector2(gameWidth + width, maxY - height + 2);

    await _loadAnimations().then((_) => {animation = _treeAnimation});
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
      image: await game.images.load(treeSpritesheet),
      srcSize: Vector2(1224 * 2, 1156 * 2),
    );

    _treeAnimation = dropSpriteSheet.createAnimation(
      row: 0,
      from: 0,
      to: 1,
      stepTime: 0.25,
    );
  }
}
