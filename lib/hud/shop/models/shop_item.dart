// ignore_for_file: public_member_api_docs, sort_constructors_first
class Price {
  num amount;
  String currency;
  Price({
    required this.amount,
    required this.currency,
  });

  get priceText => "$amount $currency";
}

abstract class ShopItem {
  final String name;
  final String image;
  final Price priceEN;
  final Price priceJA;
  final int quantity;
  final bool locked;

  ShopItem({
    required this.name,
    required this.quantity,
    required this.image,
    required this.priceEN,
    required this.priceJA,
    required this.locked,
  });
}
