//
// background

import 'package:flame/components.dart';

const double backgroundScrollingSpeed = 40;
const double backgroundTileSize = 64;

// Checkpoints

const double flagAssetSize = 64;

// Fruits

const double fruitAssetSize = 32;

late double blockSize;

// Enemy

// Chicken

final Vector2 chickenAssetSize = Vector2(32, 34);
late double gameHeight;

// Game dim
late double gameWidth;

// the ground Y wich the player will crash on hit
late double maxY;
// the highest point the player can reach wich will be the default Y
late double minY;

double obstaclesMaxSpeed = 500;
//
double obstaclesSpeed = 120;
