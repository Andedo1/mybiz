import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:majisoft/controllers/auth_controller.dart';
import 'package:majisoft/controllers/location_controller.dart';
import 'package:majisoft/controllers/order_controller.dart';
import 'package:majisoft/controllers/popular_item_controller.dart';
import 'package:majisoft/controllers/recommended_item_controller.dart';
import 'package:majisoft/controllers/user_controller.dart';
import 'package:majisoft/models/place_order_model.dart';
import 'package:majisoft/root/no_data_page.dart';
import 'package:majisoft/root/show_snackback.dart';
import 'package:majisoft/routes/routes_helper.dart';
import 'package:majisoft/screens/order/delivery_options.dart';
import 'package:majisoft/utils/app_constants.dart';
import 'package:majisoft/utils/dimensions.dart';
import 'package:majisoft/widgets/app_icon.dart';
import 'package:majisoft/widgets/big_text.dart';
import 'package:majisoft/screens/order/payment_options_button.dart';
import 'package:majisoft/widgets/small_text.dart';
import 'package:majisoft/widgets/text_field.dart';

import '../../controllers/cart_controller.dart';
import '../../widgets/custom_text_button.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController notesController = TextEditingController();
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
                        return SizedBox(
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
                                child: SizedBox(
                                  height: Dimension.height20*5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      BigText(text: cartController.getItems[index].name!, color: Colors.black,),
                                      SmallText(text: "sample text goes here"),
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
                                                    cartController.addItem(_cartList[index].product!, -1);
                                                  },
                                                  child: const Icon(Icons.remove, color: Colors.black,),
                                                ),
                                                SizedBox(width: Dimension.width10,),
                                                BigText(text: _cartList[index].quantity.toString()),//popularItem.inCartItems.toString(), size: Dimension.font20,),
                                                SizedBox(width: Dimension.width10,),
                                                GestureDetector(
                                                  onTap: (){
                                                    cartController.addItem(_cartList[index].product!, 1);
                                                  },
                                                  child: const Icon(Icons.add, color: Colors.black,),
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
      bottomNavigationBar: GetBuilder<OrderController>(builder: (orderController){
        notesController.text = orderController.itemNote;
        return GetBuilder<CartController>(
          builder: (cartController){
            return Container(
              height: Dimension.bottomHeight+50,
              padding: EdgeInsets.only(
                top: Dimension.height10,
                bottom: Dimension.height10,
                left: Dimension.width20,
                right: Dimension.width20,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.4),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimension.radius20*2),
                  topRight: Radius.circular(Dimension.radius20*2),
                ),
              ),
              child: cartController.getItems.isNotEmpty?Column(
                children: [
                  // payment options
                  InkWell(
                    onTap: ()=>showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (_){
                        return Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Container(
                                  height: MediaQuery.of(context).size.height*0.9,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(Dimension.radius20),
                                      topRight: Radius.circular(Dimension.radius20),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                          left: Dimension.width20,
                                          right: Dimension.width20,
                                          top: Dimension.height20,
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const PaymentOptionsBtn(
                                              title: "Cash on delivery",
                                              index: 0,
                                              icon: Icons.money,
                                              subtitle: "pay cash after receiving items",
                                            ),
                                            SizedBox(height: Dimension.height10,),
                                            const PaymentOptionsBtn(
                                              title: "Digital payment",
                                              index: 1,
                                              icon: Icons.paypal,
                                              subtitle: "secure and faster method of payment",
                                            ),
                                            SizedBox(height: Dimension.height30,),
                                            Text(
                                              "Delivery options",
                                              style: TextStyle(
                                                  fontSize: Dimension.font16
                                              ),
                                            ),
                                            SizedBox(height: Dimension.height10/2,),
                                            DeliveryOptions(
                                              title: "Home delivery",
                                              amount: double.parse(Get.find<CartController>().totalAmount.toString()),
                                              value: "delivery",
                                              isFree: false,
                                            ),
                                            SizedBox(height: Dimension.height10/2,),
                                            const DeliveryOptions(
                                              title: "Take away",
                                              amount: 0.0,
                                              value: "take away",
                                              isFree: true,
                                            ),
                                            SizedBox(height: Dimension.height20/2,),
                                            Text(
                                              "Additional Info",
                                              style: TextStyle(
                                                  fontSize: Dimension.font16
                                              ),
                                            ),
                                            SizedBox(height: Dimension.height20,),
                                            AppTextField(
                                              textEditingController: notesController,
                                              icon: Icons.note,
                                              hintText: 'notes',
                                              maxLines: true,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ).whenComplete(() => orderController.setItemNote(notesController.text.trim())),
                    child: const SizedBox(
                      width: double.maxFinite,
                      child: CustomTextButton(text: "payment options",),
                    ),
                  ),
                  SizedBox(height: Dimension.height10,),
                  // checkout button
                  Row(
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
                            //cartController.addToHistory();
                            if(Get.find<LocationController>().addressList.isEmpty){
                              Get.toNamed(RoutesHelper.getAddressPage());
                            }else{
                              var location = Get.find<LocationController>().getUserAddress();
                              var cart = Get.find<CartController>().getItems;
                              var user = Get.find<UserController>().userModel;
                              PlaceOrderModel placeOrder = PlaceOrderModel(
                                cart: cart,
                                orderAmount: 100.0,
                                orderNote: orderController.itemNote,
                                address: location.address,
                                latitude: location.latitude,
                                longitude: location.longitude,
                                contactPerson: user.name,
                                contactPersonNumber: user.phone,
                                scheduleAte: '',
                                distance: 20.1,
                                paymentMethod: orderController.paymentIndex==0?'cash_on_delivery':'digital_payment',
                                orderType: orderController.orderType,
                              );
                              Get.find<OrderController>().placeOrder(
                                placeOrder,
                                _callBack,
                              );
                            }
                            cartController.addToHistory();
                          }else{
                            Get.toNamed(RoutesHelper.getSignInPage());
                          }
                        },
                        child: const CustomTextButton(
                          text: "Checkout",
                        ),
                      )
                    ],
                  ),
                ],
              ):
              Container(),
            );
          },
        );
      },),
    );
  }
  void _callBack(bool isSuccess, String message, String orderID){
    if(isSuccess){
      Get.find<CartController>().clear();
      Get.find<CartController>().removeCartSharedPreferences();
      Get.find<CartController>().addToHistory();
      if(Get.find<OrderController>().paymentIndex==0){
        Get.offNamed(RoutesHelper.getOrderSuccess(orderID, "success"));
      }else{
        Get.offNamed(RoutesHelper.getPaymentPage(orderID, Get.find<UserController>().userModel.id));
      }
    }else{
      showCustomSnackBack(message);
    }
  }
}
