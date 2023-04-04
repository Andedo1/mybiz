import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:majisoft/controllers/order_controller.dart';
import 'package:majisoft/utils/dimensions.dart';

class DeliveryOptions extends StatelessWidget {
  final String value;
  final String title;
  final double amount;
  final bool isFree;
  const DeliveryOptions({Key? key,
    required this.title,
    required this.amount,
    required this.value,
    required this.isFree,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController){
      return Row(
        children: [
          Radio(
            value: value,
            groupValue: orderController.orderType,
            onChanged: (String? value){
              //print(value.toString());
              orderController.setDeliveryType(value!);
            },
            activeColor: Theme.of(context).primaryColor,
          ),
          //SizedBox(width: Dimension.width10/2,),
          Text(
            title,
            style: TextStyle(
              fontSize: Dimension.font16,
            ),
          ),
          //SizedBox(width: Dimension.width10/2,),
          Text(
            '(${(value == 'take away' || isFree) ? 'free' : 'Ksh${amount / 10}'})',
            style: TextStyle(
                fontSize: Dimension.font16
            ),
          )
        ],
      );
    });
  }
}
