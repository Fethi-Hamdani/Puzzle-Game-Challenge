import 'package:flame_audio/flame_audio.dart';
import 'package:flutter_game_challenge/game_data/constants/assets_paths.dart';
import 'package:flutter_game_challenge/game_data/controls/game_controls.dart';

class AudioControls {
  static const soundVolume = 1.0;
  //
  // Chicken
  static _play(String path) async {
    if (GameControls.playSound) {
      try {
        if (!FlameAudio.audioCache.loadedFiles.containsKey(path)) await FlameAudio.audioCache.load(path);
        FlameAudio.play(path, volume: soundVolume);
      } catch (e) {
        print("Error playing audio: $e");
      }
    }
  }

  static void chickenGotStumpedSound() {
    _play(chickenGotStumpedSoundPath);
  }

  static void fruitCollectedSound() {
    _play(fruitCollectedSoundPath);
  }
}
