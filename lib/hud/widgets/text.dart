import 'package:flutter/widgets.dart';
import 'package:flutter_game_challenge/hud/constants/text_styles.dart';

class GameText extends StatelessWidget {
  final Color borderColor;
  final Color? textColor;
  final double? borderWidth;
  final String text;
  final double? fontSize;
  const GameText({
    super.key,
    required this.text,
    required this.borderColor,
    this.borderWidth,
    this.fontSize,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: buttonStyle.copyWith(
            fontSize: fontSize,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = borderWidth ?? 4
              ..color = borderColor,
          ),
        ),
        Text(
          text,
          style: buttonStyle.copyWith(fontSize: fontSize, color: textColor),
        ),
      ],
    );
  }
}
