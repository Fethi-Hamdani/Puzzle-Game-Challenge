import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game_challenge/eco_flyer/core/local_storage.dart';
import 'package:flutter_game_challenge/eco_flyer/plane_game.dart';
import 'package:flutter_game_challenge/hud/constants/button_colors.dart';
import 'package:flutter_game_challenge/hud/constants/colors.dart';
import 'package:flutter_game_challenge/hud/hud.dart';
import 'package:flutter_game_challenge/hud/widgets/card.dart';
import 'package:flutter_game_challenge/hud/widgets/icon.dart';
import 'package:flutter_game_challenge/hud/widgets/text.dart';

import '../constants/audio.dart';
import '../widgets/button.dart';

class SettingsScreen extends StatefulWidget {
  PlaneGame game;
  SettingsScreen({super.key, required this.game});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool sound = getSoundLocalSettings();
  bool music = getMusicLocalSettings();
  bool english = true;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Center(
      child: SizedBox(
        width: screenWidth / 2,
        height: screenHeight * 0.9,
        child: GameCard(
            gradientColors: yellowLinearGradient,
            borderColor: yellowBorderColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GameText(
                    text: "Settings".toUpperCase(),
                    fontSize: 24,
                    borderColor: greenBorderColor,
                  ),
                  //
                  GameButton(
                    color: ButtonColor.yellow,
                    onPressed: () => _soundButtonPressed(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GameText(
                          text: "Sound".toUpperCase(),
                          fontSize: 24,
                          borderColor: greenBorderColor,
                        ),
                        GameIcon(
                          icon: sound ? Icons.volume_up : Icons.volume_off,
                          iconColor: Colors.redAccent,
                        ),
                      ],
                    ),
                  ),

                  //
                  GameButton(
                    color: ButtonColor.yellow,
                    onPressed: () => _musicButtonPressed(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GameText(
                          text: "Music".toUpperCase(),
                          fontSize: 24,
                          borderColor: greenBorderColor,
                        ),
                        GameIcon(
                          icon: music ? Icons.music_note : Icons.music_off,
                          iconColor: Colors.redAccent,
                        ),
                      ],
                    ),
                  ),

                  GameButton(
                    color: ButtonColor.yellow,
                    onPressed: () => _languageButtonPressed(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GameText(
                          text: "Language".toUpperCase(),
                          fontSize: 24,
                          borderColor: greenBorderColor,
                        ),
                        GameText(
                          text: english ? "EN" : "JA",
                          fontSize: 24,
                          borderColor: Colors.redAccent,
                        ),
                      ],
                    ),
                  ),
                  GameButton.text(
                    color: ButtonColor.red,
                    text: "Close".toUpperCase(),
                    fontSize: 16,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    onPressed: () {
                      widget.game.overlays.remove(GameOverlay.settings.name);
                      widget.game.overlays.add(GameOverlay.mainMenu.name);
                      // game.startGame();
                    },
                  ),
                ],
              ),
            )),
      ),
    );
  }

  _languageButtonPressed() {
    setState(() {
      english = !english;
    });
  }

  _musicButtonPressed() {
    setState(() {
      music = !music;
      if (music && !FlameAudio.bgm.isPlaying) {
        FlameAudio.bgm.play(Audio.mainSong, volume: 1);
      } else {
        FlameAudio.bgm.pause();
      }
      LocalStorage().saveData(key: "music", value: music);
    });
  }

  _soundButtonPressed() {
    setState(() {
      sound = !sound;
      LocalStorage().saveData(key: "sound", value: music);
    });
  }
}
