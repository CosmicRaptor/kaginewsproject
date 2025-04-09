import 'package:flutter/material.dart';

class BulletPoint extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final double bulletSize;
  final Color bulletColor;
  final double spacing;

  const BulletPoint({
    super.key,
    required this.text,
    this.style,
    this.bulletSize = 8,
    this.bulletColor = Colors.black,
    this.spacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bullet
        Container(
          margin: EdgeInsets.only(
            top: style?.fontSize != null ? style!.fontSize! / 2 : 8,
          ),
          width: bulletSize,
          height: bulletSize,
          decoration: BoxDecoration(color: bulletColor, shape: BoxShape.circle),
        ),
        SizedBox(width: spacing),
        Expanded(child: Text(text, style: style)),
      ],
    );
  }
}
