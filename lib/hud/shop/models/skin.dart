import 'package:equatable/equatable.dart';

class Skin extends Equatable {
  final String name;
  final String planeAsset;
  final int price;
  bool locked;

  Skin({required this.name, required this.planeAsset, required this.price, required this.locked});

  factory Skin.fromJson(Map<String, dynamic> json) {
    return Skin(
      name: json['name'],
      planeAsset: json['planeAsset'],
      price: json['price'],
      locked: json['locked'],
    );
  }

  @override
  List<Object?> get props => [name, planeAsset, price, locked];

  Skin copyWith({
    String? name,
    String? planeAsset,
    int? price,
    bool? locked,
  }) =>
      Skin(
        name: name ?? this.name,
        planeAsset: planeAsset ?? this.planeAsset,
        price: price ?? this.price,
        locked: locked ?? this.locked,
      );

  Map<String, dynamic> toJson() {
    return {'name': name, 'planeAsset': planeAsset, 'price': price, 'locked': locked};
  }
}
