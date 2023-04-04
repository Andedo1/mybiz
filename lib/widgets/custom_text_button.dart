import 'package:flutter/material.dart';
import 'package:majisoft/utils/dimensions.dart';
import 'big_text.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  const CustomTextButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Dimension.height20, bottom: Dimension.height20, left: Dimension.width20, right: Dimension.width20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0,5),
            blurRadius: 10,
            color: Colors.green.withOpacity(0.3)
          )
        ],
        borderRadius: BorderRadius.circular(Dimension.radius20),
        color: Colors.green,
      ),
      child: Center(child: BigText(text: text, color: Colors.white,)),
    );
  }
}
