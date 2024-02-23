import 'package:flutter/material.dart';

class GameCard extends StatelessWidget {
  final List<Color> gradientColors;
  final Color borderColor;
  final double? cornerRadius;
  final double? borderWidth;
  final BoxShadow? shadow;
  final Widget child;
  final EdgeInsets? padding;
  const GameCard({
    super.key,
    required this.child,
    required this.gradientColors,
    required this.borderColor,
    this.cornerRadius,
    this.shadow,
    this.padding,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.25, 0.5, 0.75],
        ),
        borderRadius: BorderRadius.circular(cornerRadius ?? 10),
        border: Border.all(color: borderColor, width: borderWidth ?? 4),
        boxShadow: [
          shadow ??
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                spreadRadius: 0,
                blurRadius: 4,
                offset: Offset(0, 4), // changes position of shadow
              ),
        ],
      ),
      child: child,
    );
  }
}
