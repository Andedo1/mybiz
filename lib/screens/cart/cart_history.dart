import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:majisoft/controllers/cart_controller.dart';
import 'package:majisoft/root/no_data_page.dart';
import 'package:majisoft/routes/routes_helper.dart';
import 'package:majisoft/utils/app_constants.dart';
import 'package:majisoft/widgets/app_icon.dart';
import 'package:majisoft/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:majisoft/utils/dimensions.dart';

import '../../models/cart_model.dart';
import '../../widgets/small_text.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = {};
    for(int i=0; i<getCartHistoryList.length; i++){
      if(cartItemsPerOrder.containsKey(getCartHistoryList[i].time)){
        cartItemsPerOrder.update(getCartHistoryList[i].time.toString(), (value)=>++value);
      }else{
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time.toString(), ()=>1);
      }
    }

    List<int> cartItemsPerOrderToList(){
      return cartItemsPerOrder.entries.map((e){
        return e.value;
      }).toList();
    }

    List<String> cartOrderTimeToList(){
      return cartItemsPerOrder.entries.map((e){
        return e.key;
      }).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();
    var listCounter = 0;
    Widget timeWidget(int index){
      var outPutDate = DateTime.now().toString();
      if(index<getCartHistoryList.length){
        DateTime parseDate =  DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse((parseDate.toString()));
        var outPutFormat = DateFormat("MM/dd/yyyy hh:mm a");
        outPutDate = outPutFormat.format(inputDate);
      }
      return BigText(text: outPutDate);
    }

    return Scaffold(
      /*appBar: AppBar(
        actions: const [
          Icon(Icons.shopping_cart),
        ],
        title: BigText(text: "Cart History",),
      ),*/
      body: Column(
        children: [
          // Custom AppBar
          Container(
            height: Dimension.height10*10,
            color: Colors.green,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimension.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(text: "Cart History", color: Colors.white,),
                AppIcon(icon: Icons.shopping_cart_outlined, iconColor: Colors.green, backgroundColor: Colors.yellow,)
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (cartController){
            return cartController.getCartHistoryList().isNotEmpty?Expanded(child: Container(
                margin: EdgeInsets.only(
                  top: Dimension.height20,
                  left: Dimension.width20,
                  right: Dimension.width20,
                ),
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView(
                    children: [
                      for(int i=0; i<itemsPerOrder.length; i++)
                        Container(
                          height: Dimension.height30*4,
                          margin: EdgeInsets.only(bottom: Dimension.height20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              timeWidget(listCounter),
                              SizedBox(height: Dimension.height10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                    direction: Axis.horizontal,
                                    children: List.generate(itemsPerOrder[i], (index){
                                      if(listCounter<getCartHistoryList.length){
                                        listCounter++;
                                      }
                                      return index<=2?Container(
                                        height: Dimension.height20*4,
                                        width: Dimension.height20*4,
                                        margin: EdgeInsets.only(right: Dimension.width10/2),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimension.radius15/2),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    AppConstants.BASE_URL+"/uploads/"+getCartHistoryList[listCounter-1].img!
                                                )
                                            )
                                        ),
                                      ): Container();
                                    }),
                                  ),
                                  Container(
                                    height: Dimension.height20*4,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        SmallText(text: 'Total', color: Colors.black,),
                                        BigText(text: "${itemsPerOrder[i].toString()} items", color: Colors.black,),
                                        GestureDetector(
                                          onTap: (){
                                            var orderTime = cartOrderTimeToList();
                                            Map<int, CartModel> moreOrder = {};
                                            for(int j=0; j<getCartHistoryList.length; j++){
                                              if(getCartHistoryList[j].time == orderTime[i]){
                                                moreOrder.putIfAbsent(getCartHistoryList[j].id!, (){
                                                  return CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j])));
                                                });
                                              }
                                            }
                                            Get.find<CartController>().setItems = moreOrder;
                                            Get.find<CartController>().addToCartList();
                                            Get.toNamed(RoutesHelper.getCart());
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: Dimension.width10, vertical: Dimension.height10/2),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(Dimension.radius15/2),
                                                border: Border.all(width: 1, color: Colors.blue)
                                            ),
                                            child: SmallText(text: "one more", color: Colors.green,),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              ),):
                SizedBox(
                  height: MediaQuery.of(context).size.height/1.5,
                  child: const Center(
                    child: NoDataPage(
                      text: "You don't have any products in your cart history",
                      img: "assets/images/history.png",
                    ),
                  ),
                );
          })
        ],
      ),
    );
  }
}
