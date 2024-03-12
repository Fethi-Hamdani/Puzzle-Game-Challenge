import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';
import '../shop/models/skin.dart';
import 'player_info_model.dart';

class PlayerInfoCubit extends Cubit<PlayerInfo> {
  PlayerInfoCubit() : super(playerInfo);

  void addDiamond(int amount) {
    print("Adding Diamond");
    print(state == state.copyWith(diamond: state.diamond + amount));

    playerInfo = state.copyWith(diamond: state.diamond + amount);
    emit(playerInfo);
    saveLocalPlayerInfo(playerInfo);
  }

  void addGold(int amount) {
    playerInfo = state.copyWith(gold: state.gold + amount);
    emit(playerInfo);
    saveLocalPlayerInfo(playerInfo);
  }

  void resetGoldAndDiamond() {
    emit(state.copyWith(gold: 0, diamond: 0));
    saveLocalPlayerInfo(playerInfo);
  }

  void selectPlane(String planeSkin) {
    print("selecting plane $planeSkin");
    game.plane.updateSkin(planeSkin);
    playerInfo = state.copyWith(planeSkin: planeSkin);
    emit(playerInfo);
    saveLocalPlayerInfo(playerInfo);
  }

  bool unlockPlane(Skin planeSkin) {
    if (planeSkin.price <= state.gold) {
      int index = state.skins.indexWhere((msg) => msg.planeAsset == planeSkin.planeAsset);
      // List<Skin> skins = state.skins.where((element) => element.planeAsset != planeSkin.planeAsset).toList();

      // planeSkin = planeSkin.copyWith(locked: false);
      // skins.add(planeSkin);

      state.skins[index].locked = false;
      // skins[index] = planeSkin.copyWith(locked: false);

      playerInfo = state.copyWith(gold: state.gold - planeSkin.price, planeSkin: planeSkin.planeAsset, skins: state.skins);
      emit(playerInfo);

      saveLocalPlayerInfo(playerInfo);
      return true;
    } else {
      return false;
    }
  }
}
