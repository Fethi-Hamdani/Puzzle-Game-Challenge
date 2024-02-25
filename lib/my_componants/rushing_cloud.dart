// import 'dart:async';

// import 'package:flame/collisions.dart';
// import 'package:flame/components.dart';
// import 'package:flutter_game_challenge/eco_flyer/plane_game.dart';

// import '../data/constants/constants.dart';

// class RushingCloud extends SpriteComponent with HasGameRef<PlaneGame>, CollisionCallbacks {
//   late final SpriteComponent rushingCloud;
//   final double speed = 200; //150

//   RushingCloud();

//   ShapeHitbox createhitBox(Vector2 thissize, Vector2 thisposition) {
//     return RectangleHitbox()
//       ..size = thissize
//       ..position = thisposition
//       ..renderShape = true;
//   }

//   @override
//   Future<FutureOr<void>> onLoad() async {
//     super.onLoad();

//     sprite = await gameRef.loadSprite('Enemies/RushingCloud/rushingcloud4x.png'); //assets\images\Enemies\RushingCloud\rushingcloud1x.png

//     size = Vector2(blockSize * 2, blockSize);
//     rushingCloud = SpriteComponent(size: size, sprite: sprite);
//     position = Vector2(gameWidth + blockSize * 0.5, minY);

//     add(rushingCloud);
//   }

//   @override
//   void update(double dt) {
//     x -= speed * dt;
//     if (x + width < 0) {
//       removeFromParent();
//       // x = game.width;
//     }
//     super.update(dt);
//   }

//   _loadAsset() {}
// }
