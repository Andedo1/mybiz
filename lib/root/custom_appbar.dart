import 'package:flutter/material.dart';
import 'package:majisoft/utils/dimensions.dart';
import 'package:majisoft/widgets/big_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final bool backButtonExist;
  final String title;
  final Function? onBackPressed;
  const CustomAppBar({Key? key,
    required this.title,
    this.backButtonExist = true,
    this.onBackPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: BigText(
        text: title,
        size: Dimension.font20,
        color: Colors.white,
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.green,
      leading: backButtonExist? IconButton(
        onPressed: ()=>onBackPressed!=null?onBackPressed!()
            : Navigator.pushReplacementNamed(context, "/initial"),
        icon: const Icon(Icons.arrow_back_ios),
      ): const SizedBox(),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(500, 53);
}
