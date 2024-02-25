import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter_game_challenge/game_data/constants/animations.dart';
import 'package:flutter_game_challenge/game_data/constants/constants.dart';
import 'package:flutter_game_challenge/game_data/controls/game_controls.dart';
import 'package:flutter_game_challenge/game_data/enums/background_color.dart';
import 'package:flutter_game_challenge/game_data/enums/view_priority.dart';

class BackgroundTile extends ParallaxComponent {
  final BackgroundColor? color;
  BackgroundTile({this.color}) : super(position: Vector2(0, 0));

  @override
  FutureOr<void> onLoad() async {
    debugMode = GameControls.debugMode;
    priority = ViewPriority.backgroundTile;
    size = Vector2.all(backgroundTileSize);
    parallax = await game.loadAnimatedBackground(color);
    return super.onLoad();
  }
}
