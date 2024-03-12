import 'package:flutter_game_challenge/hud/shop/models/shop_item.dart';

class Coin extends ShopItem {
  Coin({
    required super.name,
    required super.quantity,
    required super.image,
    required super.priceEN,
    required super.priceJA,
    required super.locked,
  });
}
