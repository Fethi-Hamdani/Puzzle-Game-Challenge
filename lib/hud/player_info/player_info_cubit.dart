import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';
import 'player_info_model.dart';

class PlayerInfoCubit extends Cubit<PlayerInfo> {
  PlayerInfoCubit() : super(playerInfo);

  void addDiamond(int amount) {
    print("Adding Diamond");
    print(state == state.copyWith(diamond: state.diamond + amount));
    emit(state.copyWith(diamond: state.diamond + amount));
    saveLocalPlayerCurrency(state);
  }

  void addGold(int amount) {
    emit(state.copyWith(gold: state.gold + amount));
    saveLocalPlayerCurrency(state);
  }
}
