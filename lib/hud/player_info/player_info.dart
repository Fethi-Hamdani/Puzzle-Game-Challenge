import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_game_challenge/eco_flyer/plane_game.dart';
import 'package:flutter_game_challenge/hud/constants/button_colors.dart';
import 'package:flutter_game_challenge/hud/constants/colors.dart';
import 'package:flutter_game_challenge/hud/player_info/player_info_cubit.dart';
import 'package:flutter_game_challenge/hud/player_info/player_info_model.dart';
import 'package:flutter_game_challenge/hud/widgets/text.dart';

class PlayerInfoScreen extends StatelessWidget {
  final PlaneGame game;
  const PlayerInfoScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerInfoCubit, PlayerInfo>(
        bloc: BlocProvider.of<PlayerInfoCubit>(context),
        builder: (context, state) {
          return Container(
            // color: Colors.grey[300],
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GameText(
                  text: state.gold.toString(),
                  borderColor: ButtonColor.yellow.borderColor,
                  borderWidth: 2,
                  textColor: redBorderColor,
                  fontSize: 24,
                ),
                GameText(
                  text: state.diamond.toString(),
                  borderColor: ButtonColor.yellow.borderColor,
                  borderWidth: 2,
                  textColor: redBorderColor,
                  fontSize: 24,
                ),
              ],
            ),
          );
        });
  }
}
