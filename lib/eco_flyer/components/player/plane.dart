import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter_game_challenge/eco_flyer/components/consumbles/coin.dart';

import '../../core/constants.dart';
import '../../plane_game.dart';

const PLANE_CRASH_SPRITESHEET = "Plane/crash.png";

const PLANE_FLASH_SPRITESHEET = "Plane/plane_flash.png";
const PLANE_SHIELD_SPRITESHEET = "Plane/plane_glow.png";
const PLANE_SPRITESHEET = "Plane/Plane.png";
const PLANE_ACID_SPRITESHEET = "Plane/acid_sprite.png";
const PLANE_FIRE_SPRITESHEET = "Plane/fire_sprite.png";

class PaperPLane extends SpriteAnimationComponent with HasGameRef<PlaneGame>, CollisionCallbacks {
  static const double GRAVITY = 600.0;

  static const double MAX_SPEED = 800.0;
  //
  static const double ANGLE_UP = -0.5;
  static const double ANGLE_DOWN = 0.8;
  static const double ANIMATION_DURATION = 0.1;

  late double FLY_SPEED;
  //
  late double verticalSpeed;

  // animations
  late final SpriteAnimation _idleAnimation;
  late final SpriteAnimation _shieldAnimation;
  late final SpriteAnimation _crashAnimation;
  late final SpriteAnimation _flashAnimation;
  late final SpriteAnimation _fireAnimation;
  late final SpriteAnimation _acidAnimation;

  bool isFlyingUp = false;

  bool upEffect = false;
  bool downEffect = false;
  double targetAngle = 0.0;
  late double paperHeight;
  late double paperwidth;
  //
  bool isCrashed = false;
  bool isEntrance = true;
  bool isOnShield = false;
  bool canBeKilled = false;

  PaperPLane() {
    verticalSpeed = 0.0;
    FLY_SPEED = -200.0;
  }

  void activateShield() {
    print('Shield Activated');
    animation = _shieldAnimation;
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Coin && !isCrashed) {
      other.consumed();
      return;
    }
    if (!isEntrance && !isOnShield) {
      isCrashed = true;
      if (canBeKilled) {
        animation = _acidAnimation;
        game.reduceLife();
        canBeKilled = false;
      }
      if (game.lives > 0) {
        game.respawn();
      } else {
        game.terminateGame();
      }
    }
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    paperHeight = blockSize * 0.5;
    paperwidth = paperHeight * 2;
    size = Vector2(paperwidth, paperHeight);
    position = Vector2(-paperwidth, planeFixedY - paperHeight / 2);

    anchor = Anchor.center;
    add(RectangleHitbox(
      position: Vector2(20, 5),
      size: Vector2(paperwidth - 20, paperHeight - 10),
    ));
    await _loadAnimations().then((_) => {animation = _flashAnimation});
    Future.delayed(const Duration(seconds: 1)).then((value) => {canBeKilled = true});
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (isEntrance) {
      if (!game.isGameStarted) return;
      _entranceFly(dt);
    } else if (isCrashed) {
      _crash(dt);
    } else {
      if (!game.isGamePlaying) return;
      _fly(dt);
    }
  }

  void _crash(double dt) {
    // Apply gravity
    verticalSpeed += GRAVITY * dt;

    // Limit the maximum vertical speed
    if (verticalSpeed > MAX_SPEED) {
      verticalSpeed = MAX_SPEED;
    }

    targetAngle = ANGLE_DOWN; // Rotate plane downwards when falling

    // Animate angle transition
    if (angle != targetAngle) {
      final angleDiff = targetAngle - angle;
      final angleStep = angleDiff.abs() * (1 / ANIMATION_DURATION) * dt;
      angle += angleDiff > 0 ? angleStep : -angleStep;

      // Ensure the angle does not overshoot the target
      if ((angleDiff > 0 && angle >= targetAngle) || (angleDiff < 0 && angle <= targetAngle)) {
        angle = targetAngle;
      }
    }

    // Update position
    double tempY = y + verticalSpeed * dt;

    // control max Y
    if (tempY + height / 2 < maxY) {
      y = tempY;
    }

    // this can be used to detect if the planes crashed into the platfrom
    //Max point the plane can reach
    if (tempY + height / 2 >= maxY) {
      x -= 120 * dt;
      y = maxY - height / 2;
      angle = 0;
      animation = _crashAnimation;
      if (animationTicker!.isLastFrame) {
        Future.delayed(const Duration(milliseconds: 150)).then((value) => removeFromParent());
      }
    }
  }

  void _entranceFly(double dt) {
    const velocity = 3;
    angle = 0;
    x += 120 * dt * velocity;
    if (x >= planeFixedX) {
      isEntrance = false;
      animation = _idleAnimation;
    }
  }

  void _fly(double dt) {
    // Apply gravity
    verticalSpeed += GRAVITY * dt;

    // Limit the maximum vertical speed
    if (verticalSpeed > MAX_SPEED) {
      verticalSpeed = MAX_SPEED;
    }

    // Adjust vertical position based on user input
    if (isFlyingUp) {
      verticalSpeed = FLY_SPEED * 1.5;
      targetAngle = ANGLE_UP; // Rotate plane upwards when flying up
    } else {
      targetAngle = ANGLE_DOWN; // Rotate plane downwards when falling
    }

    // Animate angle transition
    if (angle != targetAngle) {
      final angleDiff = targetAngle - angle;
      final angleStep = angleDiff.abs() * (1 / ANIMATION_DURATION) * dt;
      angle += angleDiff > 0 ? angleStep : -angleStep;

      // Ensure the angle does not overshoot the target
      if ((angleDiff > 0 && angle >= targetAngle) || (angleDiff < 0 && angle <= targetAngle)) {
        angle = targetAngle;
      }
    }

    // Update position
    double tempY = y + verticalSpeed * dt;

    // control max Y
    if (tempY + height / 2 < maxY) {
      y = tempY;
    }

    // this can be used to detect if the planes crashed into the platfrom
    //Max point the plane can reach
    if (tempY + height / 2 >= maxY) {
      y = maxY - height / 2;
    }
    //Min point the plane can reach
    if (tempY - height / 2 <= minY) {
      y = minY + height / 2;
    }
  }

  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: await game.images.load(PLANE_SPRITESHEET),
      srcSize: Vector2(1824, 912),
    );

    final spriteSheet_fire = SpriteSheet(
      image: await game.images.load(PLANE_FIRE_SPRITESHEET),
      srcSize: Vector2(1824, 912),
    );

    final shieldSpriteSheet = SpriteSheet(
      image: await game.images.load(PLANE_SHIELD_SPRITESHEET),
      srcSize: Vector2(1824, 912),
    );

    final crashspriteSheet = SpriteSheet(
      image: await game.images.load(PLANE_CRASH_SPRITESHEET),
      srcSize: Vector2(1609.55, 1597.87),
    );

    final flashspriteSheet = SpriteSheet(
      image: await game.images.load(PLANE_FLASH_SPRITESHEET),
      srcSize: Vector2(1824, 912),
    );

    _idleAnimation = spriteSheet.createAnimation(
      row: 0,
      from: 0,
      to: 1,
      stepTime: 0.25,
    );

    _fireAnimation = SpriteAnimation.fromFrameData(
        game.images.fromCache(PLANE_FIRE_SPRITESHEET),
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.05,
          textureSize: Vector2(1824, 912),
          loop: false,
        ));

    _acidAnimation = SpriteAnimation.fromFrameData(
        game.images.fromCache(PLANE_ACID_SPRITESHEET),
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.05,
          textureSize: Vector2(1824, 912),
          loop: false,
        ));

    _shieldAnimation = shieldSpriteSheet.createAnimation(
      row: 0,
      from: 0,
      to: 2,
      stepTime: 0.1,
    );

    _crashAnimation = crashspriteSheet.createAnimation(
      row: 0,
      from: 0,
      to: 7,
      stepTime: 0.1,
      loop: false,
    );
    _flashAnimation = flashspriteSheet.createAnimation(
      row: 0,
      from: 0,
      to: 2,
      stepTime: 0.1,
    );
  }
}
