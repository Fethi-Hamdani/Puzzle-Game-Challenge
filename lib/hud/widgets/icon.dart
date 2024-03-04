import 'package:flutter/material.dart';

class GameIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final double? size;
  const GameIcon({
    super.key,
    required this.icon,
    required this.iconColor,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: iconColor,
      size: size,
      shadows: [
        Shadow(
          color: iconColor.withOpacity(0.5),
          blurRadius: 0,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
}
