import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter_game_challenge/game_data/constants/assets_paths.dart';
import 'package:flutter_game_challenge/game_data/controls/game_controls.dart';
import 'package:flutter_game_challenge/game_data/enums/view_priority.dart';
import 'package:flutter_game_challenge/pixel_adventure.dart';

class JumpButton extends SpriteComponent with HasGameRef<PixelAdventure>, TapCallbacks {
  JumpButton();

  final margin = 32;
  final buttonSize = 64;

  @override
  FutureOr<void> onLoad() {
    debugMode = GameControls.debugMode;
    sprite = Sprite(game.images.fromCache(jumpButtonAssetPath));
    position = Vector2(game.size.x - margin - buttonSize, game.size.y - margin - buttonSize);
    priority = ViewPriority.jumpButton;
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.player.hasJumped = true;
    super.onTapDown(event);
  }

  @override
  void onTapUp(TapUpEvent event) {
    game.player.hasJumped = false;
    super.onTapUp(event);
  }
}
