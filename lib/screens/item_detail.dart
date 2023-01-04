import 'package:flutter/material.dart';
import 'package:majisoft/routes/routes_helper.dart';
import 'package:majisoft/utils/dimensions.dart';
import 'package:majisoft/widgets/app_icon.dart';
import 'package:majisoft/widgets/big_text.dart';
import 'package:majisoft/widgets/column.dart';
import 'package:majisoft/widgets/expandable_text.dart';
import 'package:get/get.dart';

import '../controllers/popular_item_controller.dart';
import '../utils/app_constants.dart';


class ItemDetail extends StatelessWidget {
  int pageId;
  ItemDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var item = Get.find<PopularItemController>().popularItemList[pageId];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimension.itemDetailImgSize,
              decoration: BoxDecoration(
                color: Colors.yellow,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    AppConstants.BASE_URL+"/uploads/"+item.img!
                  )
                )
              ),
            ),
          ),
          // Icon Widgets
          Positioned(
            top: Dimension.height45,
            left: Dimension.width20,
            right: Dimension.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.toNamed(RoutesHelper.getInitial());
                  },
                  child: AppIcon(icon: Icons.arrow_back_ios),
                ),
                AppIcon(icon: Icons.shopping_cart_checkout_outlined),
              ],
            ),
          ),
          // Introduction of Item
          Positioned(
            top: Dimension.itemDetailImgSize-20,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
                padding: EdgeInsets.only(left: Dimension.width20, right: Dimension.width20, top: Dimension.height20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimension.radius20),
                    topLeft: Radius.circular(Dimension.radius20),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: item.name!,),
                    SizedBox(height: Dimension.height20,),
                    BigText(text: "Introduce"),
                    SizedBox(height: Dimension.height20,),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ExpandableText(text: item.description!,),
                      ),
                    )
                  ],
                )
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: Dimension.bottomHeight,
        padding: EdgeInsets.only(top: Dimension.height30, bottom: Dimension.height30, left: Dimension.width20, right: Dimension.width20),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.4),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimension.radius20*2),
            topRight: Radius.circular(Dimension.radius20*2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(top: Dimension.height20, bottom: Dimension.height20, left: Dimension.width20, right: Dimension.width20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimension.radius20),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Icon(Icons.remove, color: Colors.black,),
                  SizedBox(width: Dimension.width10,),
                  BigText(text: " 0 ", size: Dimension.font26,),
                  SizedBox(width: Dimension.width10,),
                  Icon(Icons.add, color: Colors.black,)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: Dimension.height20, bottom: Dimension.height20, left: Dimension.width20, right: Dimension.width20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimension.radius20),
                color: Colors.green,
              ),
              child: BigText(text: "Ksh${item.price!} | Add to cart", color: Colors.white,),
            )
          ],
        ),
      ),
    );
  }
}
