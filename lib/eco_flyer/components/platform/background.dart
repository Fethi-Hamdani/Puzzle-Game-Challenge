import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter_game_challenge/eco_flyer/plane_game.dart';

import '../../core/constants.dart';

class Background extends ParallaxComponent<PlaneGame> with HasGameRef<PlaneGame> {
  late RectangleComponent bottomPlatform;
  late RectangleComponent topPlatform;

  @override
  Future<void> onLoad() async {
    bottomPlatform = RectangleHitbox(
      size: Vector2(game.width, game.height - maxY),
      position: Vector2(0, maxY),
    );

    topPlatform = RectangleHitbox(
      size: Vector2(game.width, minY),
      position: Vector2(0, 0),
    );
    parallax = await gameRef.loadParallax(
      [
        // ParallaxImageData('Background/parallax/10.png'),
        // ParallaxImageData('Background/parallax/9.png'),
        // ParallaxImageData('Background/parallax/8.png'),
        // ParallaxImageData('Background/parallax/7.png'),
        // ParallaxImageData('Background/parallax/6.png'),
        ParallaxImageData('Background/p/6.png'),
        ParallaxImageData('Background/p/5.png'),
        ParallaxImageData('Background/p/4.png'),
        ParallaxImageData('Background/p/3.png'),
        ParallaxImageData('Background/p/2.png'),
        ParallaxImageData('Background/p/1.png'),
        ParallaxImageData('Background/p/0.png'),
      ],
      baseVelocity: Vector2(20, 0),
      velocityMultiplierDelta: Vector2(1.4, 1.0),
      filterQuality: FilterQuality.none,
      fill: LayerFill.width,
    );

    addAll([topPlatform, bottomPlatform]);
  }
}
