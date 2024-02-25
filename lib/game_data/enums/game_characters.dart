enum GameCharacters {
  maskDude,
  ninjaFrog,
  pinkMan,
  virtualGuy;

  String get nameAsset {
    switch (this) {
      case GameCharacters.maskDude:
        return "Mask Dude";
      case GameCharacters.ninjaFrog:
        return "Ninja Frog";
      case GameCharacters.pinkMan:
        return "Pink Man";
      case GameCharacters.virtualGuy:
        return "Virtual Guy";
    }
  }
}
