import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:majisoft/screens/Home/item_body.dart';
import 'package:majisoft/utils/dimensions.dart';
import 'package:majisoft/widgets/big_text.dart';
import 'package:majisoft/widgets/small_text.dart';

import '../../controllers/popular_item_controller.dart';
import '../../controllers/recommended_item_controller.dart';

class MainItem extends StatefulWidget {
  const MainItem({Key? key}) : super(key: key);

  @override
  State<MainItem> createState() => _MainItemState();
}

class _MainItemState extends State<MainItem> {
  Future<void> _loadResources() async{
    await Get.find<PopularItemController>().getPopularItemList();
    await Get.find<RecommendedItemController>().getRecommendedItemList();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _loadResources,
        child: Column(
          children: [
            Container(child: Container(
            margin: EdgeInsets.only(top: Dimension.height45, bottom: Dimension.height15),
            padding: EdgeInsets.only(left: Dimension.width20, right: Dimension.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    BigText(text: "Kenya",size: Dimension.font26,),
                    Row(
                      children: [
                        SmallText(text: "Nairobi", size: Dimension.font16,),
                        Icon(Icons.arrow_drop_down_rounded),
                      ],
                    ),
                  ],
                ),
                Container(
                  height: Dimension.height45,
                  width: Dimension.height45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimension.radius15),
                      color: Colors.green
                  ),
                  child: Icon(Icons.search, color: Colors.white, size: Dimension.iconSize24,),
                )
              ],
            ),
          ),
        ),
        const Expanded(
          child: SingleChildScrollView(
            child: ItemBody(),
          ),
        ),
      ],
    )
    );

  }
}
