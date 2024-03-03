import 'package:flutter/widgets.dart';
import 'package:flutter_game_challenge/hud/constants/text_styles.dart';

class GameText extends StatelessWidget {
  final Color borderColor;
  final Color? textColor;
  final double? borderWidth;
  final String text;
  final double? fontSize;
  final bool showShadow;
  const GameText({
    super.key,
    required this.text,
    required this.borderColor,
    this.borderWidth,
    this.fontSize,
    this.textColor,
    this.showShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (showShadow)
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
