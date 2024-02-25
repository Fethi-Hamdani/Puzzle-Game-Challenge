// import 'dart:async';

// import 'package:flame/collisions.dart';
// import 'package:flame/components.dart';
// import 'package:flame_svg/flame_svg.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_game_challenge/data/constants/constants.dart';
// import 'package:flutter_game_challenge/eco_flyer/plane_game.dart';

// enum PlaneAnimationStates {
//   idle,
//   up,
//   down,
// }

// class PlanePlayer extends SpriteAnimationGroupComponent<PlaneAnimationStates> with HasGameRef<PlaneGame>, CollisionCallbacks {
//   static final _animationMap = {
//     PlaneAnimationStates.idle: SpriteAnimationData.sequenced(
//       amount: 5,
//       stepTime: 0.1,
//       textureSize: Vector2.all(24),
//     ),
//     PlaneAnimationStates.up: SpriteAnimationData.sequenced(
//       amount: 5,
//       stepTime: 0.1,
//       textureSize: Vector2.all(24),
//       texturePosition: Vector2((4) * 24, 0),
//     ),
//     PlaneAnimationStates.down: SpriteAnimationData.sequenced(
//       amount: 5,
//       stepTime: 0.1,
//       textureSize: Vector2.all(24),
//       texturePosition: Vector2((4 + 6) * 24, 0),
//     ),
//   };

//   static const double gravity = -250;

//   static const double GRAVITY = 800.0;
//   static const double FLY_SPEED = -300.0;
//   static const double MAX_SPEED = 500.0;
//   //current speed along y-axis.
//   double speedY = 0.0;
//   double planeWidth = blockSize * 0.6;
//   final double jumpHeight = 150;

//   late Svg idleAsset;
//   late Svg downAsset;

//   late Svg upAsset;

//   late SvgComponent plane;
//   late SpriteAnimation planeAnimation;
//   PlanePlayer({
//     super.position,
//     super.size,
//   });

//   // Returns true if Plane is on top.
//   bool get isOnGround => (y <= minY);

//   // Makes the dino jump.
//   void jump() {
//     // Jump only if dino is on ground.

//     speedY = jumpHeight;
//   }

//   @override
//   Future<FutureOr<void>> onLoad() async {
//     Paint planeColor = Paint()..color = Colors.amber;
//     // debugMode = true;

//     // ShapeHitbox planeHitbox = RectangleHitbox()
//     //   ..size = size
//     //   ..paint = planeColor
//     //   ..renderShape = true;

//     idleAsset = await Svg.load('svg/Plane/paper_plane.svg'); //assets\images\Plane\paper_plane.svg
//     downAsset = await Svg.load('svg/Plane/paper_plane_Down.svg');
//     upAsset = await Svg.load('svg/Plane/paper_plane_Up.svg');

//     // planeAnimation =SpriteAnimation.fromFrameData(image, data)

//     plane = SvgComponent(
//       svg: idleAsset,
//       // position: Vector2(150, blockSize),
//       size: Vector2(planeWidth, planeWidth / 3),
//       anchor: Anchor.topLeft,
//       paint: planeColor,
//     );
//     print(game.height);
//     print(game.width);
//     add(plane);
//     // add(planeHitbox);

//     super.onLoad();
//   }

//   @override
//   void update(double dt) {
//     // v = u + at 800 * 0.0165
//     speedY += gravity * dt;

//     // d = s0 + s * t
//     double tempY = speedY * dt;
//     // print(tempY);
//     // print(maxY);
//     // if (y + tempY >= minY && y + tempY + height <= maxY) {

//     // }

//     if (y + tempY > y) {
//       plane.svg = downAsset;
//     } else {
//       plane.svg = upAsset;
//     }

//     if (y + tempY == y) {
//       plane.svg = idleAsset;
//     }
//     if (y + tempY + height >= maxY) {
//       y = maxY - height;
//     } else {
//       y += tempY;
//     }

//     /// This code makes sure that dino never goes beyond [yMax].
//     if (isOnGround) {
//       y = minY;
//       speedY = 0.0;
//     }

//     super.update(dt);
//   }
// }
