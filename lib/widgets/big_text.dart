import 'package:flutter/material.dart';
import 'package:majisoft/utils/dimensions.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  BigText({Key? key, this.color, required this.text, this.size=0,
    this.overflow=TextOverflow.ellipsis}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        fontSize: size==0? Dimension.font20: size,
        color: color,
        fontWeight: FontWeight.w400
      ),
    );
  }
}
