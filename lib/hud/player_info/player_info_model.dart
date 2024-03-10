import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../eco_flyer/core/local_storage.dart';

fetchLocalPlayerCurrency() async {
  dynamic playerInfo = await LocalStorage().getData(key: "playerInfo");
  print(playerInfo);
  return playerInfo != null ? PlayerInfo.fromJson(jsonDecode(playerInfo)) : const PlayerInfo(gold: 500, diamond: 0);
}

saveLocalPlayerCurrency(PlayerInfo playerInfo) {
  LocalStorage().saveData(key: "playerInfo", value: jsonEncode(playerInfo.toJson()));
}

class PlayerInfo extends Equatable {
  final int gold;
  final int diamond;

  const PlayerInfo({required this.gold, required this.diamond});

  factory PlayerInfo.fromJson(Map<String, dynamic> json) {
    return PlayerInfo(
      gold: json['gold'],
      diamond: json['diamond'],
    );
  }

  @override
  List<Object?> get props => [gold, diamond];

  PlayerInfo copyWith({
    int? gold,
    int? diamond,
  }) {
    return PlayerInfo(
      gold: gold ?? this.gold,
      diamond: diamond ?? this.diamond,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gold'] = gold;
    data['diamond'] = diamond;
    return data;
  }
}
