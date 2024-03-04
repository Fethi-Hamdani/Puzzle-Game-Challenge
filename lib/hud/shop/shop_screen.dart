import 'package:flutter/material.dart';
import 'package:flutter_game_challenge/hud/shop/widgets/shop_items.dart';

import '../../eco_flyer/plane_game.dart';
import '../constants/button_colors.dart';
import '../hud.dart';
import '../widgets/button.dart';
import '../widgets/overlay_header.dart';

class ShopScreen extends StatefulWidget {
  static const List skins = [
    "skin1",
    "skin2",
    "skin3",
    "skin4",
    "skin5",
  ];
  static const List coins = [
    "coin1",
    "coin2",
    "coin3",
    "coin4",
    "coin5",
  ];
  static const List diamonds = [
    "diamond1",
    "diamond2",
    "diamond3",
    "diamond4",
    "diamond5",
  ];
  final PlaneGame game;
  const ShopScreen({super.key, required this.game});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  List activeList = ShopScreen.skins;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Center(
      child: SizedBox(
        height: screenHeight * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            OverlayHeader(
              title: "Shop".toUpperCase(),
              onPressed: () {
                widget.game.overlays.remove(GameOverlay.shop.name);
                widget.game.overlays.add(GameOverlay.mainMenu.name);
                // game.startGame();
              },
            ),

            SizedBox(
              height: screenHeight * 0.6,
              child: ShopItems(items: activeList),
            ),
            //
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GameButton.text(
                  color: ButtonColor.green,
                  text: "Skins".toUpperCase(),
                  fontSize: 16,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  onPressed: () {
                    _updateActiveList(ShopScreen.skins);
                    // game.overlays.remove(GameOverlay.shop.name);
                    // game.overlays.add(GameOverlay.mainMenu.name);
                    // game.startGame();
                  },
                ),
                const SizedBox(width: 24.0),
                GameButton.text(
                  color: ButtonColor.green,
                  text: "Coins".toUpperCase(),
                  fontSize: 16,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  onPressed: () {
                    _updateActiveList(ShopScreen.coins);
                    // game.overlays.remove(GameOverlay.shop.name);
                    // game.overlays.add(GameOverlay.mainMenu.name);
                    // game.startGame();
                  },
                ),
                const SizedBox(width: 24.0),
                GameButton.text(
                  color: ButtonColor.green,
                  text: "Diamonds".toUpperCase(),
                  fontSize: 16,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  onPressed: () {
                    _updateActiveList(ShopScreen.diamonds);
                    // game.overlays.remove(GameOverlay.shop.name);
                    // game.overlays.add(GameOverlay.mainMenu.name);
                    // game.startGame();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _updateActiveList(List list) {
    setState(() {
      activeList = list;
    });
  }
}
