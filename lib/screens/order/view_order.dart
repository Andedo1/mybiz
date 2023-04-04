import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:majisoft/controllers/order_controller.dart';
import 'package:majisoft/models/order_model.dart';
import 'package:majisoft/root/custom_loading_screen.dart';
import 'package:majisoft/utils/dimensions.dart';

class ViewOrderPage extends StatelessWidget {
  final bool isCurrent;
  const ViewOrderPage({Key? key, required this.isCurrent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OrderController>(builder: (orderController){
        if(orderController.isLoading==false){
          late List<OrderModel> orderList;
          if(orderController.currentOrderList.isNotEmpty){
            orderList = isCurrent? orderController.currentOrderList.reversed.toList():
            orderController.historyOrderList.reversed.toList();
          }
          return SizedBox(
            width: Dimension.screenWidth,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimension.height10/2, vertical: Dimension.height10/2),
              child: ListView.builder(
                itemCount: orderList.length,
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: (){

                    },
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Order ID",
                                  style: TextStyle(
                                    fontSize: Dimension.font26/2
                                  ),
                                ),
                                SizedBox(width: Dimension.width10,),
                                Text('#${orderList[index].id.toString()}'),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(Dimension.radius15/2)
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: Dimension.width10, vertical: Dimension.width10/2),
                                  child: Text(
                                    "${orderList[index].orderStatus}",
                                    style: TextStyle(
                                      color: Theme.of(context).cardColor,
                                      fontSize: Dimension.font26/2,
                                    ),
                                  ),
                                ),
                                SizedBox(height: Dimension.height10/2,),
                                InkWell(
                                  onTap: (){

                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(Dimension.radius15/2),
                                      border: Border.all(width: 1, color: Theme.of(context).primaryColor)
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.track_changes_rounded,
                                          color: Colors.green,
                                          size: Dimension.iconSize16,
                                        ),
                                        Text(
                                          "Track order",
                                          style: TextStyle(
                                            fontSize: Dimension.font26/2,
                                            color: Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: Dimension.height10,)
                      ],
                    ),
                  );
                },),
            ),
          );
        }else{
          return const CustomLoadingScreen();
        }
      },),
    );
  }
}
