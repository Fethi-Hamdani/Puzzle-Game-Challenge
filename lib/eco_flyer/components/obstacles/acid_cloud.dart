import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../core/constants.dart';
import '../../plane_game.dart';

const darkCloudSpritesheet = "Acid/dark_cloud.png";

class AcidCloud extends SpriteAnimationComponent with HasGameRef<PlaneGame>, CollisionCallbacks {
  final int drops_space = 20;
  final Timer _timer = Timer(2, repeat: true);

  //
  late final SpriteAnimation _darkCloudAnimation;

  //
  late double cloudHeight;
  late double cloudWidth;

  final double widthFactor;
  final double heightFactor;
  final bool canSpawnDoubleDrips;

  AcidCloud()
      : heightFactor = 0.5,
        canSpawnDoubleDrips = false,
        widthFactor = 0.75 {
    _timer.onTick = _spawnDrips;
  }
  AcidCloud.large()
      : heightFactor = 0.5,
        canSpawnDoubleDrips = true,
        widthFactor = 1 {
    _timer.onTick = _spawnDrips;
  }

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    cloudWidth = blockSize * widthFactor;
    cloudHeight = cloudWidth * heightFactor;

    size = Vector2(cloudWidth, cloudHeight);
    position = Vector2(gameWidth + width, minY);

    priority = 1;
    add(RectangleHitbox());

    await _loadAnimations().then((_) => {animation = _darkCloudAnimation});
  }

  @override
  void onMount() {
    _timer.start();

    super.onMount();
  }

  @override
  void update(double dt) {
    _timer.update(dt);
    x -= obstaclesSpeed * dt;
    if (x + width < 0) {
      removeFromParent();
      // x = game.width;
    }
    super.update(dt);
  }

  Future<void> _loadAnimations() async {
    final dropSpriteSheet = SpriteSheet(
      image: await game.images.load(darkCloudSpritesheet),
      srcSize: Vector2(2505 * 4, 1680 * 4),
    );

    _darkCloudAnimation = dropSpriteSheet.createAnimation(
      row: 0,
      from: 0,
      to: 1,
      stepTime: 0.25,
    );
  }

  void _spawnDrips() {
    if (canSpawnDoubleDrips) {
      bool delay_first = Random(DateTime.now().millisecondsSinceEpoch).nextBool();
      AcidCloudDrip acidCloudDrip1 = AcidCloudDrip.slow()..position = Vector2(x, y);
      AcidCloudDrip acidCloudDrip2 = AcidCloudDrip.slow()..position = Vector2(x, y);

      if (delay_first) {
        double drop1X = x - drops_space + (width / 2) - (blockSize * 0.3 / 1.68) / 2;
        game.world.add(acidCloudDrip1..position = Vector2(drop1X, y));
        Future.delayed(
          const Duration(milliseconds: 200),
          () {
            double drop2X = x + drops_space + (width / 2) - (blockSize * 0.3 / 1.68) / 2;
            game.world.add(acidCloudDrip2..position = Vector2(drop2X, y));
          },
        );
      } else {
        double drop1X = x + drops_space + (width / 2) - (blockSize * 0.3 / 1.68) / 2;
        game.world.add(acidCloudDrip1..position = Vector2(drop1X, y));
        Future.delayed(
          const Duration(milliseconds: 200),
          () {
            double drop2X = x - drops_space + (width / 2) - (blockSize * 0.3 / 1.68) / 2;
            game.world.add(acidCloudDrip2..position = Vector2(drop2X, y));
          },
        );
      }
    } else {
      AcidCloudDrip acidCloudDrip = AcidCloudDrip()..position = Vector2(x, y);

      double dropX = x + (width / 2) - (blockSize * 0.3 / 1.68) / 2;
      game.world.add(acidCloudDrip..position = Vector2(dropX, y));
    }
  }
}

//
class AcidCloudDrip extends SpriteAnimationComponent with HasGameRef<PlaneGame>, CollisionCallbacks {
  late final SpriteAnimation _dropAnimation;
  late final SpriteAnimation _splashAnimation;

  // assets
  final dropSpritesheet = "Acid/drop.png";
  final splashSpritesheet = "Acid/splash.png";

  final double dripHeight = blockSize * 0.3;
  final double speed;
  final double horizantal_speed = 200;
  bool hitTheGround = false;
  bool positionUpdate = false;

  AcidCloudDrip() : speed = 300;
  AcidCloudDrip.slow() : speed = 200;

  @override
  FutureOr<void> onLoad() async {
    size = Vector2(dripHeight / 1.68, dripHeight);
    // position = Vector2(gameWidth + width, minY);
    // priority = 0;
    add(CircleHitbox());

    await _loadAnimations().then((_) => {animation = _dropAnimation});
    super.onLoad();
  }

  @override
  void update(double dt) {
    if (!hitTheGround) {
      y += speed * dt;
    }

    if (y + dripHeight >= maxY) {
      hitTheGround = true;
      animation = _splashAnimation;

      if (animationTicker!.isLastFrame) {
        Future.delayed(const Duration(milliseconds: 150)).then((value) => removeFromParent());
      }
      size = Vector2(dripHeight * 2, dripHeight);

      // anchor = Anchor(x, y);
      if (!positionUpdate) {
        positionUpdate = true;
        position = Vector2(x - dripHeight / 1.5, y);
      }
    }

    x -= horizantal_speed * dt;
    if (x + width < 0) {
      removeFromParent();
      // x = game.width;
    }

    super.update(dt);
  }

  Future<void> _loadAnimations() async {
    final dropSpriteSheet = SpriteSheet(
      image: await game.images.load(dropSpritesheet),
      srcSize: Vector2(144, 242),
    );

    final splashSpriteSheet = SpriteSheet(
      image: await game.images.load(splashSpritesheet),
      srcSize: Vector2(200, 81.42),
    );

    _dropAnimation = dropSpriteSheet.createAnimation(
      row: 0,
      from: 0,
      to: 1,
      stepTime: 0.25,
    );

    _splashAnimation = splashSpriteSheet.createAnimation(
      row: 0,
      from: 0,
      to: 4,
      stepTime: 0.05,
      loop: false,
    );
  }
}
