import 'package:flutter_game_challenge/hud/shop/models/shop_item.dart';

class Skin extends ShopItem {
  Skin({
    required super.name,
    required super.quantity,
    required super.image,
    required super.locked,
    required super.priceEN,
    required super.priceJA,
  });
}
