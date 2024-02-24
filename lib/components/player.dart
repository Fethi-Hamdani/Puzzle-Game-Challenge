import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_game_challenge/components/bounding_box/collision_block.dart';
import 'package:flutter_game_challenge/components/bounding_box/custom_hitbox.dart';
import 'package:flutter_game_challenge/components/consumbles/fruit.dart';
import 'package:flutter_game_challenge/components/obstacles/enemies/chicken.dart';
import 'package:flutter_game_challenge/components/obstacles/hazards/saw.dart';
import 'package:flutter_game_challenge/components/portals/checkpoint.dart';
import 'package:flutter_game_challenge/data/controls/game_controls.dart';
import 'package:flutter_game_challenge/data/enums/game_characters.dart';
import 'package:flutter_game_challenge/eco_flyer/plane_game.dart';
import 'package:flutter_game_challenge/my_componants/cloud.dart';

class Player extends SpriteAnimationGroupComponent with HasGameRef<PlaneGame>, KeyboardHandler, CollisionCallbacks {
  GameCharacters character;
  final double stepTime = 0.05;

  late SpriteAnimation idleAnimation;
  late SpriteAnimation runningAnimation;
  late SpriteAnimation jumpingAnimation;
  late SpriteAnimation fallingAnimation;
  late SpriteAnimation hitAnimation;
  late SpriteAnimation appearingAnimation;
  late SpriteAnimation disappearingAnimation;
  final double _gravity = -9.8;

  final double _jumpForce = 260; //260
  final double _terminalVelocity = 300;
  double horizontalMovement = 0;
  double moveSpeed = 100;
  Vector2 startingPosition = Vector2.zero();
  Vector2 velocity = Vector2.zero();
  bool isOnGround = false;
  bool hasJumped = false;
  bool gotHit = false;
  bool hasSurfedDown = false;
  CollisionBlock? surfedBlock;
  bool reachedCheckpoint = false;
  List<CollisionBlock> collisionBlocks = [];
  CustomHitbox hitbox = CustomHitbox(
    offsetX: 0,
    offsetY: 0,
    width: 14,
    height: 28,
  );
  double fixedDeltaTime = 1 / 60;
  double accumulatedTime = 0;
  Player({
    position,
    required this.character,
  }) : super(position: position);

  void changeCharacter(GameCharacters newCharacter) {
    character = newCharacter;
    _loadAllAnimations();
  }

  void collidedwithEnemy() {
    _respawn();
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    print("Hit something");

    if (other is Fruit) other.collidedWithPlayer();
    if (other is Cloud) print("i hit a Cloud");
    if (other is Saw) _respawn();
    // if (other is Chicken) other.collidedWithPlayer();
    if (other is Checkpoint) _reachedCheckpoint();
    if (!reachedCheckpoint) {}
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horizontalMovement = 0;
    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyA) || keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isRightKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyD) || keysPressed.contains(LogicalKeyboardKey.arrowRight);

    horizontalMovement += isLeftKeyPressed ? -1 : 0;
    horizontalMovement += isRightKeyPressed ? 1 : 0;

    hasJumped = keysPressed.contains(LogicalKeyboardKey.space) || keysPressed.contains(LogicalKeyboardKey.arrowUp);
    hasSurfedDown = keysPressed.contains(LogicalKeyboardKey.arrowDown);
    return super.onKeyEvent(event, keysPressed);
  }

  @override
  FutureOr<void> onLoad() {
    debugMode = GameControls.debugMode;

    _loadAllAnimations();
    Paint paint = Paint()..color = Colors.green;

    startingPosition = Vector2(position.x, position.y);

    add(RectangleHitbox()
      ..paint = paint
      ..renderShape = true
      ..position = position
      ..size = size);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    accumulatedTime += dt;

    while (accumulatedTime >= fixedDeltaTime) {
      if (!gotHit && !reachedCheckpoint) {
        _updatePlayerState();
        _updatePlayerMovement(fixedDeltaTime);
        _checkHorizontalCollisions();
        _applyGravity(fixedDeltaTime);
        _checkVerticalCollisions();
      }

      accumulatedTime -= fixedDeltaTime;
    }

    super.update(dt);
  }

  void _applyGravity(double dt) {
    velocity.y += _gravity;
    velocity.y = velocity.y.clamp(-_jumpForce, _terminalVelocity);
    position.y += velocity.y * dt;
  }

  void _checkHorizontalCollisions() {
    for (final block in collisionBlocks) {
      if (!block.isPlatform) {
        if (block.checkCollision(this)) {
          if (velocity.x > 0) {
            velocity.x = 0;
            position.x = block.x - hitbox.offsetX - hitbox.width;
            break;
          }
          if (velocity.x < 0) {
            velocity.x = 0;
            position.x = block.x + block.width + hitbox.width + hitbox.offsetX;
            break;
          }
        }
      }
    }
  }

  void _checkVerticalCollisions() {
    for (final block in collisionBlocks) {
      if (block.isPlatform) {
        if (block.checkCollision(this)) {
          if (hasSurfedDown) {
            surfedBlock = block;
          }
          if (surfedBlock == null && velocity.y > 0) {
            velocity.y = 0;
            position.y = block.y - hitbox.height - hitbox.offsetY;
            isOnGround = true;
            break;
          }
        } else {
          if (block == surfedBlock) {
            surfedBlock = null;
            hasSurfedDown = false;
          }
        }
      } else {
        if (block.checkCollision(this)) {
          if (velocity.y > 0) {
            velocity.y = 0;
            position.y = block.y - hitbox.height - hitbox.offsetY;
            isOnGround = true;
            break;
          }
          if (velocity.y < 0) {
            velocity.y = 0;
            position.y = block.y + block.height - hitbox.offsetY;

            isOnGround = true;
          }
        }
      }
    }
  }

  void _loadAllAnimations() {
    idleAnimation = _spriteAnimation('Idle', 11);
    runningAnimation = _spriteAnimation('Run', 12);
    jumpingAnimation = _spriteAnimation('Jump', 1);
    fallingAnimation = _spriteAnimation('Fall', 1);
    hitAnimation = _spriteAnimation('Hit', 7)..loop = false;
    appearingAnimation = _specialSpriteAnimation('Appearing', 7);
    disappearingAnimation = _specialSpriteAnimation('Desappearing', 7);

    // List of all animations
    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running: runningAnimation,
      PlayerState.jumping: jumpingAnimation,
      PlayerState.falling: fallingAnimation,
      PlayerState.hit: hitAnimation,
      PlayerState.appearing: appearingAnimation,
      PlayerState.disappearing: disappearingAnimation,
    };

    // Set current animation
    current = PlayerState.idle;
  }

  void _playerJump(double dt) {
    // if (game.playSounds) FlameAudio.play('jump.wav', volume: game.soundVolume);

    velocity.y = -_jumpForce;

    position.y += velocity.y * dt;
    isOnGround = false;
    hasJumped = false;
  }

  void _reachedCheckpoint() async {
    reachedCheckpoint = true;
    // if (game.playSounds) {
    //   FlameAudio.play('disappear.wav', volume: game.soundVolume);
    // }
    if (scale.x > 0) {
      position = position - Vector2.all(32);
    } else if (scale.x < 0) {
      position = position + Vector2(32, -32);
    }

    current = PlayerState.disappearing;

    await animationTicker?.completed;
    animationTicker?.reset();

    reachedCheckpoint = false;
    position = Vector2.all(-640);

    const waitToChangeDuration = Duration(seconds: 3);
    // Future.delayed(waitToChangeDuration, () => game.loadNextLevel());
  }

  void _respawn() async {
    // if (game.playSounds) FlameAudio.play('hit.wav', volume: game.soundVolume);
    const canMoveDuration = Duration(milliseconds: 400);
    gotHit = true;
    current = PlayerState.hit;

    await animationTicker?.completed;
    animationTicker?.reset();

    scale.x = 1;
    position = startingPosition - Vector2.all(32);
    current = PlayerState.appearing;

    await animationTicker?.completed;
    animationTicker?.reset();

    velocity = Vector2.zero();
    position = startingPosition;
    _updatePlayerState();
    Future.delayed(canMoveDuration, () => gotHit = false);
  }

  SpriteAnimation _specialSpriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('Main Characters/$state (96x96).png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: stepTime,
        textureSize: Vector2.all(96),
        loop: false,
      ),
    );
  }

  SpriteAnimation _spriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('Main Characters/${character.nameAsset}/$state (32x32).png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: stepTime,
        textureSize: Vector2.all(32),
      ),
    );
  }

  void _updatePlayerMovement(double dt) {
    // if (hasJumped && isOnGround) _playerJump(dt);

    if (hasJumped) {
      velocity.y = _jumpForce;

      position.y += velocity.y * dt;
    }

    // if (velocity.y > _gravity) isOnGround = false; // optional

    velocity.x = horizontalMovement * moveSpeed;
    position.x += velocity.x * dt;
  }

  void _updatePlayerState() {
    PlayerState playerState = PlayerState.idle;

    if (velocity.x < 0 && scale.x > 0) {
      flipHorizontallyAroundCenter();
    } else if (velocity.x > 0 && scale.x < 0) {
      flipHorizontallyAroundCenter();
    }

    // Check if moving, set running
    if (velocity.x > 0 || velocity.x < 0) playerState = PlayerState.running;

    // check if Falling set to falling
    if (velocity.y > 0) playerState = PlayerState.falling;

    // Checks if jumping, set to jumping
    if (velocity.y < 0) playerState = PlayerState.jumping;

    current = playerState;
  }
}

enum PlayerState { idle, running, jumping, falling, hit, appearing, disappearing }
