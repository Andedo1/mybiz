import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final String text;
  double size;
  double height;
  Color color;
  SmallText({Key? key, required this.text, this.size=12, this.height=1.2, this.color=Colors.black45}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        height: height,
        fontSize: size
      ),
    );
  }
}
