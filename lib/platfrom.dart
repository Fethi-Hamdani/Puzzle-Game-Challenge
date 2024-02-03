import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game_challenge/components/obstacles/enemies/chicken.dart';
import 'package:flutter_game_challenge/data/enums/view_priority.dart';

import 'package:flutter_game_challenge/components/bounding_box/collision_block.dart';
import 'package:flutter_game_challenge/components/player.dart';
import 'package:flutter_game_challenge/data/controls/game_controls.dart';
import 'package:flutter_game_challenge/my_componants/cloud.dart';
import 'package:flutter_game_challenge/plane.dart';

// class PlayArea extends World with HasGameReference<PlaneGame>, HasCollisionDetection {
//   @override
//   FutureOr<void> onLoad() async {
//     debugMode = GameControls.debugMode;
//     priority = ViewPriority.level;
//     final platform = RectangleComponent(
//       paint: Paint()..color = const Color(0xfff2e8cf),
//       size: Vector2(game.width, game.height / 6),
//       position: Vector2(0, game.height - game.height / 6),
//     );

//     add(platform);
//     return super.onLoad();
//   }
// }

class PlayArea extends World with HasGameRef<PlaneGame> {
  final Player player;
  PlayArea({required this.player});
  late RectangleComponent bottomPlatform;
  late RectangleComponent topPlatform;
  List<CollisionBlock> collisionBlocks = [];
  late double blockSize;

  @override
  FutureOr<void> onLoad() async {
    debugMode = GameControls.debugMode;

    blockSize = (game.height / 6);

    _loadPlatform();
    _loadObstacles();

    return super.onLoad();
  }

  void _loadObstacles() {
    double cloudHeight = blockSize * 2;
    double cloudWidth = blockSize;
    double spaceBetweenClouds = blockSize * 1.5;

    double initX = 500;

    List<Chicken> clouds = [];

    for (var i = 0; i < 5; i++) {
      if (i % 2 == 1) {
        clouds.add(
            Chicken(size: Vector2(cloudWidth, blockSize * 3), position: Vector2(initX + 2 * spaceBetweenClouds * i, blockSize + game.height / 6)));
      } else {
        clouds.add(Chicken(size: Vector2(cloudWidth, blockSize * 3), position: Vector2(initX + 2 * spaceBetweenClouds * i, game.height / 6)));
      }
    }

    addAll(clouds);
  }

  _loadPlatform() {
    bottomPlatform = RectangleComponent(
      paint: Paint()..color = const Color.fromARGB(255, 86, 73, 41),
      size: Vector2(game.width, blockSize),
      position: Vector2(0, game.height - blockSize),
    );

    final bottomPlatformColissionBlock = CollisionBlock(
      size: Vector2(game.width, blockSize),
      position: Vector2(0, game.height - blockSize),
    );
    final topPlatformColissionBlock = CollisionBlock(
      size: Vector2(game.width, blockSize),
      position: Vector2(0, 0),
    );

    topPlatform = RectangleComponent(
      paint: Paint()..color = const Color(0xfff2e8cf),
      size: Vector2(game.width, blockSize),
      position: Vector2(0, 0),
    );

    player.collisionBlocks = [topPlatformColissionBlock, bottomPlatformColissionBlock];
    addAll([topPlatform, topPlatformColissionBlock, bottomPlatform, bottomPlatformColissionBlock]);
  }

  // void _scrollingBackground() {
  //   final backgroundLayer = level.tileMap.getLayer('Background');

  //   if (backgroundLayer != null) {
  //     final backgroundColor = BackgroundColor.fromString(backgroundLayer.properties.getValue('BackgroundColor'));
  //     final backgroundTile = BackgroundTile(color: backgroundColor);
  //     add(backgroundTile);
  //   }
  // }

  // void _spawningObjects() {
  //   final spawnPointsLayer = level.tileMap.getLayer<ObjectGroup>('Spawnpoints');

  //   if (spawnPointsLayer != null) {
  //     for (final spawnPoint in spawnPointsLayer.objects) {
  //       switch (spawnPoint.class_) {
  //         case 'Player':
  //           player.position = Vector2(spawnPoint.x, spawnPoint.y);
  //           player.scale.x = 1;
  //           add(player);
  //           break;
  //         case 'Fruit':
  //           final fruit = Fruit(
  //             fruit: Fruits.fromString(spawnPoint.name),
  //             position: Vector2(spawnPoint.x, spawnPoint.y),
  //             size: Vector2(spawnPoint.width, spawnPoint.height),
  //           );
  //           add(fruit);
  //           break;
  //         case 'Saw':
  //           final isVertical = spawnPoint.properties.getValue('isVertical');
  //           final offNeg = spawnPoint.properties.getValue('offNeg');
  //           final offPos = spawnPoint.properties.getValue('offPos');
  //           final saw = Saw(
  //             isVertical: isVertical,
  //             offNeg: offNeg,
  //             offPos: offPos,
  //             position: Vector2(spawnPoint.x, spawnPoint.y),
  //             size: Vector2(spawnPoint.width, spawnPoint.height),
  //           );
  //           add(saw);
  //           break;
  //         case 'Checkpoint':
  //           final checkpoint = Checkpoint(
  //             position: Vector2(spawnPoint.x, spawnPoint.y),
  //             size: Vector2(spawnPoint.width, spawnPoint.height),
  //           );
  //           add(checkpoint);
  //           break;
  //         case 'Chicken':
  //           final offNeg = spawnPoint.properties.getValue('offNeg');
  //           final offPos = spawnPoint.properties.getValue('offPos');
  //           final chicken = Chicken(
  //             position: Vector2(spawnPoint.x, spawnPoint.y),
  //             size: Vector2(spawnPoint.width, spawnPoint.height),
  //             offNeg: offNeg,
  //             offPos: offPos,
  //           );
  //           add(chicken);
  //           break;
  //         default:
  //       }
  //     }
  //   }
  // }

  // void _addCollisions() {
  //   final collisionsLayer = level.tileMap.getLayer<ObjectGroup>('Collisions');

  //   if (collisionsLayer != null) {
  //     for (final collision in collisionsLayer.objects) {
  //       switch (collision.class_) {
  //         case 'Platform':
  //           final platform = CollisionBlock(
  //             position: Vector2(collision.x, collision.y),
  //             size: Vector2(collision.width, collision.height),
  //             isPlatform: true,
  //           );
  //           collisionBlocks.add(platform);
  //           add(platform);
  //           break;
  //         default:
  //           final block = CollisionBlock(
  //             position: Vector2(collision.x, collision.y),
  //             size: Vector2(collision.width, collision.height),
  //           );
  //           collisionBlocks.add(block);
  //           add(block);
  //       }
  //     }
  //   }
  //   player.collisionBlocks = collisionBlocks;
  // }
}
