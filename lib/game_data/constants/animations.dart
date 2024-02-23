import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_game_challenge/game_data/constants/assets_paths.dart';
import 'package:flutter_game_challenge/game_data/constants/constants.dart';
import 'package:flutter_game_challenge/game_data/controls/game_controls.dart';
import 'package:flutter_game_challenge/game_data/enums/background_color.dart';
import 'package:flutter_game_challenge/game_data/enums/enemy_state.dart';
import 'package:flutter_game_challenge/game_data/enums/fruits.dart';

extension AssetsHandler on FlameGame {
  //
  // Background
  Future<Parallax> loadAnimatedBackground(BackgroundColor? color) async {
    return await loadParallax(
      [ParallaxImageData(color?.path ?? GameControls.defaultBackgroundColor.path)],
      baseVelocity: Vector2(0, -backgroundScrollingSpeed),
      repeat: ImageRepeat.repeat,
      fill: LayerFill.none,
    );
  }

  //
  // CheckPoint

  SpriteAnimation checkPointNoFlagAnimation() {
    return SpriteAnimation.fromFrameData(
      images.fromCache(checkPointNoFlagAnimationPath),
      SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: 1,
        textureSize: Vector2.all(flagAssetSize),
      ),
    );
  }

  SpriteAnimation checkPointFlagOutAnimation() {
    return SpriteAnimation.fromFrameData(
      images.fromCache(checkPointFlagOutAnimationPath),
      SpriteAnimationData.sequenced(
        amount: 26,
        stepTime: 0.05,
        textureSize: Vector2.all(flagAssetSize),
        loop: false,
      ),
    );
  }

  SpriteAnimation checkPointFlagIdleAnimation() {
    return SpriteAnimation.fromFrameData(
      images.fromCache(checkPointFlagIdleAnimationPath),
      SpriteAnimationData.sequenced(
        amount: 10,
        stepTime: 0.05,
        textureSize: Vector2.all(flagAssetSize),
      ),
    );
  }

  //
  // Enemies

  SpriteAnimation chickenAnimations(EnemyState state, int amount) {
    return SpriteAnimation.fromFrameData(
      images.fromCache(state.path),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: 0.05,
        textureSize: chickenAssetSize,
      ),
    );
  }

  //
  // fruits

  SpriteAnimation fruitAnimation(Fruits fruit) {
    return SpriteAnimation.fromFrameData(
      images.fromCache(fruit.path),
      SpriteAnimationData.sequenced(
        amount: 17,
        stepTime: 0.05,
        textureSize: Vector2.all(fruitAssetSize),
      ),
    );
  }

  SpriteAnimation fruitCollectedAnimation() {
    return SpriteAnimation.fromFrameData(
      images.fromCache(fruitCollectedAnimationPath),
      SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: 0.05,
        textureSize: Vector2.all(fruitAssetSize),
        loop: false,
      ),
    );
  }
}
