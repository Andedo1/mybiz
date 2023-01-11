import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:majisoft/controllers/auth_controller.dart';
import 'package:majisoft/controllers/popular_item_controller.dart';
import 'package:majisoft/controllers/recommended_item_controller.dart';
import 'package:majisoft/root/no_data_page.dart';
import 'package:majisoft/routes/routes_helper.dart';
import 'package:majisoft/utils/app_constants.dart';
import 'package:majisoft/utils/dimensions.dart';
import 'package:majisoft/widgets/app_icon.dart';
import 'package:majisoft/widgets/big_text.dart';
import 'package:majisoft/widgets/small_text.dart';

import '../../controllers/cart_controller.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimension.height20*3,
            left: Dimension.width20,
            right: Dimension.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icon: Icons.arrow_back_ios,
                  iconColor: Colors.white,
                  iconSize: Dimension.iconSize24,
                  backgroundColor: Colors.green,
                ),
                SizedBox(width: Dimension.width20*5,),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(RoutesHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    iconSize: Dimension.iconSize24,
                    backgroundColor: Colors.green,
                  ),
                ),
                AppIcon(
                  icon: Icons.shopping_cart,
                  iconColor: Colors.white,
                  iconSize: Dimension.iconSize24,
                  backgroundColor: Colors.green,
                ),
            ],
          ),
          ),
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getItems.isNotEmpty?Positioned(
              top: Dimension.height20*5,
              left: Dimension.width20,
              right: Dimension.width20,
              bottom: 0,
              child: Container(
                margin: EdgeInsets.only(top: Dimension.height15),
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GetBuilder<CartController>(builder: (cartController){
                    var _cartList = cartController.getItems;
                    return ListView.builder(
                      itemCount: _cartList.length,
                      itemBuilder: (_, index){
                        return Container(
                          width: double.maxFinite,
                          height: 100,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  var popularIndex = Get.find<PopularItemController>()
                                      .popularItemList.indexOf(_cartList[index].product!);
                                  if(popularIndex>=1){
                                    Get.toNamed(RoutesHelper.getPopularItem(popularIndex, "cart"));
                                  }else{
                                    var recommendedIndex = Get.find<RecommendedItemController>()
                                        .recommendedItemList.indexOf(_cartList[index].product!);
                                    if(recommendedIndex<0){
                                      Get.snackbar("Product history", "Product review is not available for the product history",
                                          backgroundColor: Colors.blue,
                                          colorText: Colors.white);
                                    }else{
                                      Get.toNamed(RoutesHelper.getRecommendedItem(recommendedIndex, "cart"));
                                    }
                                  }
                                },
                                child: Container(
                                  width: Dimension.height20*5,
                                  height: Dimension.height20*5,
                                  margin: EdgeInsets.only(bottom: Dimension.height10),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          "${AppConstants.BASE_URL}/uploads/${cartController.getItems[index].img!}",
                                        )
                                    ),
                                    borderRadius: BorderRadius.circular(Dimension.radius20),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: Dimension.width10,),
                              Expanded(
                                child: Container(
                                  height: Dimension.height20*5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      BigText(text: cartController.getItems[index].name!, color: Colors.black,),
                                      SmallText(text: "clean water"),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigText(text: cartController.getItems[index].price.toString(), color: Colors.redAccent,),
                                          Container(
                                            padding: EdgeInsets.only(top: Dimension.height10, bottom: Dimension.height10, left: Dimension.width10, right: Dimension.width10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimension.radius20),
                                              color: Colors.white,
                                            ),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: (){
                                                    cartController.addItem(_cartList[index].product!, -100);
                                                  },
                                                  child: Icon(Icons.remove, color: Colors.black,),
                                                ),
                                                SizedBox(width: Dimension.width10,),
                                                BigText(text: _cartList[index].quantity.toString()),//popularItem.inCartItems.toString(), size: Dimension.font20,),
                                                SizedBox(width: Dimension.width10,),
                                                GestureDetector(
                                                  onTap: (){
                                                    cartController.addItem(_cartList[index].product!, 100);
                                                  },
                                                  child: Icon(Icons.add, color: Colors.black,),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },),
                ),
              ),
            ):
                const NoDataPage(text: "Your cart is empty!");
          })
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(
          builder: (cartController){
            return Container(
              height: Dimension.bottomHeight,
              padding: EdgeInsets.only(top: Dimension.height30, bottom: Dimension.height30, left: Dimension.width20, right: Dimension.width20),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.4),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimension.radius20*2),
                  topRight: Radius.circular(Dimension.radius20*2),
                ),
              ),
              child: cartController.getItems.isNotEmpty?Row(
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
                        SizedBox(width: Dimension.width10,),
                        BigText(text: "Ksh ${cartController.totalAmount.toString()}", size: Dimension.font20,),
                        SizedBox(width: Dimension.width10,),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      if(Get.find<AuthController>().userLoggedIn()){
                        cartController.addToHistory();
                      }else{
                        Get.toNamed(RoutesHelper.getSignInPage());
                      }

                    },
                    child: Container(
                      padding: EdgeInsets.only(top: Dimension.height20, bottom: Dimension.height20, left: Dimension.width20, right: Dimension.width20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimension.radius20),
                        color: Colors.green,
                      ),
                      child: BigText(text: "Checkout", color: Colors.white,),
                    ),
                  )
                ],
              ):
                  Container(),
            );
          },
        ),
    );
  }
}
