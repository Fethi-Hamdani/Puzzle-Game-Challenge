import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game_challenge/hud/widgets/text.dart';

import '../../constants/colors.dart';

class ShopItemContainer extends StatelessWidget {
  final String title;

  const ShopItemContainer({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(24),
      color: Colors.lightBlue,
      child: Center(
        child: GameText(
          text: title,
          fontSize: 24,
          borderColor: greenBorderColor,
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
    final screenWidth = MediaQuery.sizeOf(context).width;
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
          title: items[itemIndex],
        ),
      ),
    );
  }
}
