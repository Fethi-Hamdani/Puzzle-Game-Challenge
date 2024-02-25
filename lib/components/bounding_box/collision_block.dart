import 'package:flame/components.dart';
import 'package:flutter_game_challenge/components/player.dart';
import 'package:flutter_game_challenge/game_data/controls/game_controls.dart';

class CollisionBlock extends PositionComponent {
  bool isPlatform;
  CollisionBlock({position, size, this.isPlatform = false}) : super(position: position, size: size) {
    debugMode = GameControls.debugMode;
  }

  bool checkCollision(Player player) {
    final block = this;
    final hitbox = player.hitbox;
    final playerX = player.position.x + hitbox.offsetX;
    final playerY = player.position.y + hitbox.offsetY;
    final playerWidth = hitbox.width;
    final playerHeight = hitbox.height;

    final blockX = block.x;
    final blockY = block.y;
    final blockWidth = block.width;
    final blockHeight = block.height;

    final fixedX = player.scale.x < 0 ? playerX - (hitbox.offsetX * 2) - playerWidth : playerX;
    final fixedY = block.isPlatform ? playerY + playerHeight : playerY;

    return (fixedY < blockY + blockHeight &&
        playerY + playerHeight > blockY &&
        fixedX < blockX + blockWidth &&
        fixedX + playerWidth > blockX);
  }
}
