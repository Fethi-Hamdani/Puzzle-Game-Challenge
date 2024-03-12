import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../eco_flyer/core/assets.dart';
import '../../eco_flyer/core/local_storage.dart';
import '../shop/models/skin.dart';

PlayerInfo initialPlayerInfo = PlayerInfo(gold: 500, diamond: 0, skins: skins, planeSkin: GameAssets.planeWhite);
List<Skin> skins = [
  Skin(name: "1", planeAsset: GameAssets.planeWhite, price: 1500, locked: false),
  Skin(name: "2", planeAsset: GameAssets.planeGreen, price: 1500, locked: true),
  Skin(name: "3", planeAsset: GameAssets.planeRed, price: 2000, locked: true),
  Skin(name: "4", planeAsset: GameAssets.planeBlue, price: 2500, locked: true),
  Skin(name: "5", planeAsset: GameAssets.planeyellow, price: 3000, locked: true),
  Skin(name: "6", planeAsset: GameAssets.planeblack, price: 3500, locked: true),
];
fetchLocalPlayerCurrency() async {
  dynamic playerInfo = await LocalStorage().getData(key: "playerInfo");
  print(playerInfo);
  return playerInfo != null ? PlayerInfo.fromJson(jsonDecode(playerInfo)) : initialPlayerInfo;
}

saveLocalPlayerInfo(PlayerInfo playerInfo) {
  LocalStorage().saveData(key: "playerInfo", value: jsonEncode(playerInfo.toJson()));
}

class PlayerInfo extends Equatable {
  final int gold;
  final int diamond;
  final String planeSkin;
  final List<Skin> skins;

  const PlayerInfo({required this.gold, required this.planeSkin, required this.diamond, required this.skins});

  factory PlayerInfo.fromJson(Map<String, dynamic> json) {
    print(json['skins']);
    return PlayerInfo(
      gold: json['gold'],
      diamond: json['diamond'],
      skins: List.from(json['skins']).map((e) => Skin.fromJson(jsonDecode(e))).toList() as List<Skin>,
      planeSkin: json['planeSkin'],
    );
  }

  @override
  List<Object?> get props => [gold, diamond];

  PlayerInfo copyWith({
    int? gold,
    int? diamond,
    List<Skin>? skins,
    String? planeSkin,
  }) {
    return PlayerInfo(
      gold: gold ?? this.gold,
      diamond: diamond ?? this.diamond,
      skins: skins ?? this.skins,
      planeSkin: planeSkin ?? this.planeSkin,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gold'] = gold;
    data['diamond'] = diamond;
    data['skins'] = skins.map((e) => jsonEncode(e.toJson())).toList();
    print(data);
    data['planeSkin'] = planeSkin;
    return data;
  }
}
