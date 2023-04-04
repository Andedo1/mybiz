import 'package:flutter/material.dart';
import 'package:majisoft/utils/dimensions.dart';

class CustomLoadingScreen extends StatelessWidget {
  const CustomLoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Dimension.height20*5,
        width: Dimension.height20*5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimension.height20*5/2),
          color: Colors.green,
        ),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(color: Colors.white,),
      ),
    );
  }
}
