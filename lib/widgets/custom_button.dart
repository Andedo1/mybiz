import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final double radius;
  final IconData? icon;
  const CustomButton({Key? key,
    this.onPressed,
    required this.buttonText,
    this.transparent = false,
    this.margin,
    this.height,
    this.fontSize,
    this.radius=5,
    this.icon,
    this.width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final flatButton = TextButton.styleFrom(
      backgroundColor: onPressed==null?Theme.of(context).disabledColor:
          transparent? Colors.transparent: Theme.of(context).primaryColor,
      minimumSize: Size(width==null?width!:Dimension.screenWidth, height==null?height!:Dimension.height10*5),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius)
      )
    );
    return Center(
      child: SizedBox(
        width: width ?? Dimension.screenWidth,
        height: height ?? 50,
        child: TextButton(
          onPressed: onPressed,
          style: flatButton,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon!=null?Padding(
                  padding: EdgeInsets.only(right: Dimension.width10/2),
                child: Icon(icon, color: transparent?Theme.of(context).primaryColor:
                  Theme.of(context).cardColor,),
              ):const SizedBox(),
              Text(buttonText, style: TextStyle(
                fontSize: fontSize ?? Dimension.font16,
                color: transparent?Theme.of(context).primaryColor:
                Theme.of(context).cardColor,
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
