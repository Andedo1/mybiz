import 'package:flutter/material.dart';
import 'package:majisoft/controllers/recommended_item_controller.dart';
import 'package:majisoft/utils/dimensions.dart';
import 'package:majisoft/widgets/app_icon.dart';
import 'package:majisoft/widgets/big_text.dart';
import 'package:majisoft/widgets/expandable_text.dart';
import 'package:get/get.dart';

import '../routes/routes_helper.dart';
import '../utils/app_constants.dart';

class RecommendedItemDetail extends StatelessWidget {
  int pageId;
  RecommendedItemDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var item = Get.find<RecommendedItemController>().recommendedItemList[pageId];
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 70,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.toNamed(RoutesHelper.getInitial());
                  },
                  child: AppIcon(icon: Icons.clear,),
                ),
                AppIcon(icon: Icons.shopping_cart_outlined)
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimension.radius20),
                    topLeft: Radius.circular(Dimension.radius20),
                  ),
                  color: Colors.white,
                ),
                child: Center(
                  child: BigText(size: Dimension.font26, text: item.name!,),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: Colors.yellow,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL+"/uploads/"+item.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: Dimension.width20, right: Dimension.width20),
                  child: ExpandableText(text: item.description!,),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: Dimension.width20*2.5,
              right: Dimension.width20*2.5,
              top: Dimension.height10,
              bottom: Dimension.height10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppIcon(icon: Icons.remove, iconSize: Dimension.iconSize24, iconColor: Colors.white, backgroundColor: Colors.blue,),
                    SizedBox(width: Dimension.width10,),
                    BigText(text: "Ksh ${item.price!} X 0", color: Colors.black, size: Dimension.font26,),
                    SizedBox(width: Dimension.width10,),
                    AppIcon(icon: Icons.add, iconSize: Dimension.iconSize24, iconColor: Colors.white, backgroundColor: Colors.blue,),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: Dimension.height20, bottom: Dimension.height20, left: Dimension.width20, right: Dimension.width20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimension.radius20),
                        color: Colors.white,
                      ),
                      child: AppIcon(icon: Icons.favorite, iconColor: Colors.orange, iconSize: Dimension.iconSize24*1.5,),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: Dimension.height20, bottom: Dimension.height20, left: Dimension.width20, right: Dimension.width20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimension.radius20),
                        color: Colors.green,
                      ),
                      child: BigText(text: "Ksh100 | Add to cart", color: Colors.white,),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
