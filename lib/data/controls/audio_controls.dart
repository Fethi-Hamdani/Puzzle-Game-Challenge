import 'package:flame_audio/flame_audio.dart';
import 'package:flutter_game_challenge/data/constants/assets_paths.dart';
import 'package:flutter_game_challenge/data/controls/game_controls.dart';

class AudioControls {
  static const soundVolume = 1.0;
  //
  // Chicken
  static _play(String path) {
    if (GameControls.playSound) {
      FlameAudio.play(path, volume: soundVolume);
    }
  }

  static void chickenGotStumpedSound() {
    _play(chickenGotStumpedSoundPath);
  }

  static void fruitCollectedSound() {
    _play(fruitCollectedSoundPath);
  }
}
