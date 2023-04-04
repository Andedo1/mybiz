import 'package:flutter/material.dart';
import 'package:majisoft/controllers/popular_item_controller.dart';
import 'package:majisoft/controllers/recommended_item_controller.dart';
import 'package:majisoft/utils/dimensions.dart';
import 'package:majisoft/widgets/app_icon.dart';
import 'package:majisoft/widgets/big_text.dart';
import 'package:majisoft/widgets/expandable_text.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../routes/routes_helper.dart';
import '../utils/app_constants.dart';

class RecommendedItemDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendedItemDetail({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var item = Get.find<RecommendedItemController>().recommendedItemList[pageId];
    Get.find<PopularItemController>().initItem(item, Get.find<CartController>());
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
                    if(page=="cart"){
                      Get.toNamed(RoutesHelper.getCart());
                    }else{
                      Get.toNamed(RoutesHelper.getInitial());
                    }
                  },
                  child: const AppIcon(icon: Icons.clear,),
                ),
                GetBuilder<PopularItemController>(builder: (controller){
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(RoutesHelper.getCart());
                    },
                    child: Stack(
                      children: [
                        const AppIcon(icon: Icons.shopping_cart_outlined),
                        controller.totalItems>=1?
                        const Positioned(
                          top: 0,
                          right: 0,
                          child: AppIcon(
                            icon: Icons.circle,
                            size: 20,
                            iconColor: Colors.transparent,
                            backgroundColor: Colors.blue,
                          ),
                        ) :
                        Container(),
                        controller.totalItems>=1?
                        Positioned(
                          top: 3,
                          right: 3,
                          child: BigText(
                            text: Get.find<PopularItemController>().totalItems.toString(),
                            size: 8, color: Colors.white,
                          ),
                        ): Container(),
                      ],
                    ),
                  );
                })
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimension.width10, vertical: Dimension.height10/2),
                    child: BigText(size: Dimension.font26, text: item.name!,),
                  ),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: Colors.yellow,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                "${AppConstants.BASE_URL}/uploads/${item.img!}" ,
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
      bottomNavigationBar: GetBuilder<PopularItemController>(
        builder: (controller) {
          return Column(
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
                        GestureDetector(
                          onTap: (){
                            controller.setQuantity(false);
                          },
                          child: AppIcon(icon: Icons.remove, iconSize: Dimension.iconSize24, iconColor: Colors.white, backgroundColor: Colors.blue,),
                        ),
                        SizedBox(width: Dimension.width10,),
                        BigText(text: "Ksh ${item.price!} X ${controller.inCartItems}", color: Colors.black, size: Dimension.font26,),
                        SizedBox(width: Dimension.width10,),
                        GestureDetector(
                          onTap: (){
                            controller.setQuantity(true);
                          },
                          child: AppIcon(icon: Icons.add, iconSize: Dimension.iconSize24, iconColor: Colors.white, backgroundColor: Colors.blue,),
                        ),
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
                        GestureDetector(
                          onTap: (){
                            controller.addItem(item);
                            },
                          child: Container(
                            padding: EdgeInsets.only(top: Dimension.height20, bottom: Dimension.height20, left: Dimension.width20, right: Dimension.width20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimension.radius20),
                              color: Colors.green,
                            ),
                            child: BigText(text: "${item.price!} | Add to cart", color: Colors.white,),
                          ),
                        )

                      ],
                    ),
                  ],
                ),
              )
            ],
          );
        }
      ),
    );
  }
}
