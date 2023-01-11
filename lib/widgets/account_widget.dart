import 'package:flutter/material.dart';
import 'package:majisoft/utils/dimensions.dart';
import 'package:majisoft/widgets/big_text.dart';

import 'app_icon.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
  AccountWidget({Key? key, required this.appIcon, required this.bigText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: const Offset(0,5),
            color: Colors.grey.withOpacity(0.2)
          )
        ]
      ),
      padding: EdgeInsets.only(
        left: Dimension.width20,
        top: Dimension.width10,
        bottom: Dimension.width10,
      ),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimension.width20,),
          bigText,
        ],
      ),
    );
  }
}
