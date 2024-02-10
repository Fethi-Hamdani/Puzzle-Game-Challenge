//
// background

import 'package:flame/components.dart';

const double backgroundScrollingSpeed = 40;
const double backgroundTileSize = 64;

// Checkpoints

const double flagAssetSize = 64;

// Enemy

// Chicken

final Vector2 chickenAssetSize = Vector2(32, 34);

// Fruits

const double fruitAssetSize = 32;

// the ground Y wich the player will crash on hit
late double maxY;
// the highest point the player can reach wich will be the default Y
late double minY;

late double blockSize;

// Game dim
late double gameWidth;
late double gameHeight;
