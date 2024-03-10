import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_game_challenge/hud/constants/colors.dart';
import 'package:flutter_game_challenge/hud/player_info/player_info_cubit.dart';
import 'package:flutter_game_challenge/hud/shop/models/diamond.dart';
import 'package:flutter_game_challenge/hud/shop/models/shop_item.dart';
import 'package:flutter_game_challenge/hud/widgets/card.dart';
import 'package:flutter_game_challenge/hud/widgets/text.dart';

class LockedLayer extends StatelessWidget {
  final ShopItem shopItem;

  const LockedLayer({
    super.key,
    required this.shopItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.black26,
      child: GameText(
        text: shopItem.priceEN.priceText,
        fontSize: 24,
        borderColor: greenBorderColor,
      ),
    );
  }
}

class ShopItemContainer extends StatelessWidget {
  final ShopItem shopItem;

  const ShopItemContainer({
    super.key,
    required this.shopItem,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<PlayerInfoCubit>(context).addDiamond(shopItem.quantity);
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        width: double.maxFinite,
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: GameCard(
                    gradientColors: yellowLinearGradient,
                    borderColor: Colors.orange,
                    child: Image.asset(shopItem.image),
                  ),
                ),
              ],
            ),

            if (shopItem is Diamond)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: GameText(
                    text: shopItem.quantity.toString(),
                    fontSize: 24,
                    borderColor: Colors.blueAccent,
                  ),
                ),
              ),

            if (shopItem is Diamond)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: GameText(
                    text: shopItem.priceEN.priceText,
                    fontSize: 24,
                    borderColor: yellowBorderColor,
                  ),
                ),
              ),
            // LockedLayer(shopItem: shopItem)
          ],
        ),
      ),
    );
  }
}

class ShopItems extends StatelessWidget {
  final PageController controller = PageController(viewportFraction: 0.8, keepPage: true);

  final List items;
  ShopItems({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    return PageStorage(
      bucket: PageStorageBucket(),
      child: CarouselSlider.builder(
        options: CarouselOptions(
          height: screenHeight * 0.6,
          enableInfiniteScroll: false,
          aspectRatio: 16 / 9,
          viewportFraction: 0.5,
          enlargeCenterPage: true,
        ),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) => ShopItemContainer(
          shopItem: items[itemIndex],
        ),
      ),
    );
  }
}
