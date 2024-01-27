import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_game_challenge/components/bounding_box/custom_hitbox.dart';

class Hitboxes {
  //
  // Checkpoints
  static RectangleHitbox checkpointHitbox = RectangleHitbox(
    position: Vector2(18, 56),
    size: Vector2(12, 8),
    collisionType: CollisionType.passive,
  );

  // Enemies
  static RectangleHitbox chickenHitbox = RectangleHitbox(
    position: Vector2(4, 6),
    size: Vector2(24, 26),
  );

  // fruits
  static CustomHitbox fruitCollectionHitbox = CustomHitbox(
    offsetX: 10,
    offsetY: 10,
    width: 12,
    height: 12,
  );

  static RectangleHitbox get fruitHitbox {
    // returns a new hitbox with the same values for every fruit
    return RectangleHitbox(
      position: Vector2(fruitCollectionHitbox.offsetX, fruitCollectionHitbox.offsetY),
      size: Vector2(fruitCollectionHitbox.width, fruitCollectionHitbox.height),
      collisionType: CollisionType.passive,
    );
  }
}
