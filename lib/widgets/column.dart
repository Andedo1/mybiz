import 'package:flutter/material.dart';
import 'package:majisoft/utils/dimensions.dart';
import 'package:majisoft/widgets/big_text.dart';
import 'package:majisoft/widgets/ico_and_text.dart';
import 'package:majisoft/widgets/small_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text, size: Dimension.font26,),
        SizedBox(height: Dimension.height10,),
        Row(
          children: [
            Wrap(
              children: List.generate(5, (index) => Icon(Icons.star, color: Colors.blue,)),
            ),
            SizedBox(width: 10,),
            SmallText(text: "5"),
            SizedBox(width: 10,),
            SmallText(text: "Comments"),
            SizedBox(width: 10,),
            SmallText(text: "100"),
          ],
        ),
        SizedBox(height: Dimension.height10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const<Widget>[
            IconAndText(icon: Icons.circle_sharp, text: "Normal", iconcolor: Colors.orange),
            IconAndText(icon: Icons.location_on, text: "20KM", iconcolor: Colors.green),
            IconAndText(icon: Icons.access_time_rounded, text: "25min", iconcolor: Colors.blue)
          ],
        ),
      ],
    );
  }
}
