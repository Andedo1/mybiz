import 'package:flutter/material.dart';
import 'package:majisoft/utils/dimensions.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String img;
  const NoDataPage({Key? key, required this.text, this.img= "assets/images/empty_shopping_cart.jpg"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          img,
          height: MediaQuery.of(context).size.height*0.22,
          width: MediaQuery.of(context).size.width*0.22,
        ),
        SizedBox(height: Dimension.height10/2,),
        Text(
          text,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height*0.0175,
            color: Theme.of(context).disabledColor,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
