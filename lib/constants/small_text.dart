import 'package:flutter/material.dart';

class Small_Text extends StatelessWidget {
  Color color;
  final String text;
  double size;
  double height;
  Small_Text({
    super.key,
    this.color = Colors.black,
    required this.text,
    this.size = 12,
    this.height = 1.2,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w400,
        fontSize: size,
        height: height,
      ),
    );
  }
}
