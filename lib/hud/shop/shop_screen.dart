import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_game_challenge/eco_flyer/core/assets.dart';
import 'package:flutter_game_challenge/hud/player_info/player_info_cubit.dart';
import 'package:flutter_game_challenge/hud/shop/models/shop_item.dart';
import 'package:flutter_game_challenge/hud/shop/widgets/shop_items.dart';
import 'package:flutter_game_challenge/main.dart';

import '../../eco_flyer/plane_game.dart';
import '../constants/button_colors.dart';
import '../hud.dart';
import '../player_info/player_info_model.dart';
import '../widgets/button.dart';
import '../widgets/overlay_header.dart';
import 'models/coin.dart';
import 'models/diamond.dart';

class ShopScreen extends StatefulWidget {
  static List<ShopItem> diamonds = [
    Diamond(
        name: "Diamond pack 1",
        image: GameAssets.diamond1,
        priceEN: Price(amount: 1.00, currency: "\$"),
        priceJA: Price(amount: 150, currency: "¥"),
        locked: true,
        quantity: 100),
    Diamond(
        name: "Diamond pack 2",
        image: GameAssets.diamond1,
        priceEN: Price(amount: 1.5, currency: "\$"),
        priceJA: Price(amount: 223, currency: "¥"),
        locked: true,
        quantity: 250),
    Diamond(
        name: "Diamond pack 3",
        image: GameAssets.diamond1,
        priceEN: Price(amount: 2.5, currency: "\$"),
        priceJA: Price(amount: 373, currency: "¥"),
        locked: true,
        quantity: 500),
    Diamond(
        name: "Diamond pack 4",
        image: GameAssets.diamond2,
        priceEN: Price(amount: 5, currency: "\$"),
        priceJA: Price(amount: 746, currency: "¥"),
        locked: true,
        quantity: 1000),
    Diamond(
        name: "Diamond pack 5",
        image: GameAssets.diamond2,
        priceEN: Price(amount: 7.5, currency: "\$"),
        priceJA: Price(amount: 1119, currency: "¥"),
        locked: true,
        quantity: 1500),
  ];
  static List<ShopItem> coins = [
    Coin(
        name: "Diamond pack 1",
        image: GameAssets.diamond1,
        priceEN: Price(amount: 1.00, currency: "\$"),
        priceJA: Price(amount: 150, currency: "¥"),
        locked: true,
        quantity: 100),
    Coin(
        name: "Diamond pack 2",
        image: GameAssets.diamond1,
        priceEN: Price(amount: 1.5, currency: "\$"),
        priceJA: Price(amount: 223, currency: "¥"),
        locked: true,
        quantity: 250),
    Coin(
        name: "Diamond pack 3",
        image: GameAssets.diamond1,
        priceEN: Price(amount: 2.5, currency: "\$"),
        priceJA: Price(amount: 373, currency: "¥"),
        locked: true,
        quantity: 500),
    Coin(
        name: "Diamond pack 4",
        image: GameAssets.diamond2,
        priceEN: Price(amount: 5, currency: "\$"),
        priceJA: Price(amount: 746, currency: "¥"),
        locked: true,
        quantity: 1000),
    Coin(
        name: "Diamond pack 5",
        image: GameAssets.diamond2,
        priceEN: Price(amount: 7.5, currency: "\$"),
        priceJA: Price(amount: 1119, currency: "¥"),
        locked: true,
        quantity: 1500),
  ];

  final PlaneGame game;
  const ShopScreen({super.key, required this.game});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  List activeList = playerInfo.skins;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    return BlocBuilder<PlayerInfoCubit, PlayerInfo>(
        bloc: BlocProvider.of<PlayerInfoCubit>(context),
        builder: (context, state) {
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
                        color: ButtonColor.yellow,
                        text: "Skins".toUpperCase(),
                        fontSize: 16,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        onPressed: () {
                          _updateActiveList(state.skins);
                          // game.overlays.remove(GameOverlay.shop.name);
                          // game.overlays.add(GameOverlay.mainMenu.name);
                          // game.startGame();
                        },
                      ),
                      const SizedBox(width: 24.0),
                      GameButton.text(
                        color: ButtonColor.yellow,
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
                        color: ButtonColor.yellow,
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
        });
  }

  _updateActiveList(List list) {
    setState(() {
      activeList = list;
    });
  }
}
