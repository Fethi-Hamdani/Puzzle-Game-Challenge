import 'package:flutter/widgets.dart';
import 'package:flutter_game_challenge/game_data/controls/audio_controls.dart';
import 'package:flutter_game_challenge/hud/constants/button_colors.dart';
import 'package:flutter_game_challenge/hud/widgets/card.dart';
import 'package:flutter_game_challenge/hud/widgets/text.dart';

class GameButton extends StatefulWidget {
  final ButtonColor color;
  final Widget? child;
  final BoxShadow? shadow;
  final double? cornerRadius;
  final double? borderWidth;
  final EdgeInsets? padding;
  final String? text;
  final double? textBorderWidth;
  final double? fontSize;
  final bool outline;
  final VoidCallback? onPressed;
  final bool playSound;
  const GameButton({
    super.key,
    required this.color,
    required this.child,
    this.shadow,
    this.cornerRadius,
    this.padding,
    this.onPressed,
    this.playSound = true,
    this.borderWidth,
  })  : text = null,
        textBorderWidth = null,
        fontSize = null,
        outline = true;

  const GameButton.text({
    super.key,
    required this.text,
    required this.color,
    this.shadow,
    this.cornerRadius,
    this.padding,
    this.textBorderWidth,
    this.fontSize,
    this.outline = true,
    this.onPressed,
    this.playSound = true,
    this.borderWidth,
  }) : child = null;

  @override
  State<GameButton> createState() => _GameButtonState();
}

class _GameButtonState extends State<GameButton> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController _controller;
  final Duration duration = const Duration(milliseconds: 100);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.playSound) {
          AudioControls.fruitCollectedSound();
        }
        _controller.forward().then((value) => _controller.reverse());
        widget.onPressed?.call();
      },
      child: ScaleTransition(
        scale: animation,
        child: !widget.outline
            ? GameText(
                text: widget.text!,
                borderColor: widget.color.borderColor,
                borderWidth: widget.textBorderWidth,
                fontSize: widget.fontSize,
              )
            : GameCard(
                borderWidth: widget.borderWidth,
                cornerRadius: widget.cornerRadius,
                shadow: widget.shadow,
                borderColor: widget.color.borderColor,
                gradientColors: widget.color.gradientColors,
                padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
                child: widget.text != null
                    ? GameText(
                        text: widget.text!,
                        borderColor: widget.color.borderColor,
                        borderWidth: widget.textBorderWidth,
                        fontSize: widget.fontSize,
                      )
                    : widget.child!,
              ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.removeListener(() {
      setState(() {});
    });
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: duration,
      reverseDuration: duration,
    );
    animation = CurvedAnimation(parent: Tween<double>(begin: 1, end: widget.text != null ? 0.8 : 0.9).animate(_controller), curve: Curves.linear);
    _controller.addListener(() {
      setState(() {});
    });
  }
}
