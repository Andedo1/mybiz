import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:majisoft/controllers/order_controller.dart';
import 'package:majisoft/utils/dimensions.dart';

class PaymentOptionsBtn extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final int index;
  const PaymentOptionsBtn({Key? key,
    required this.title,
    required this.index,
    required this.icon,
    required this.subtitle
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController){
      bool _selected = orderController.paymentIndex==index;
      return InkWell(
        onTap: ()=>orderController.setPaymentIndex(index),
        child: Container(
            padding: EdgeInsets.only(bottom: Dimension.height10/2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimension.radius20/4),
                color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[200]!,
                    blurRadius: 5,
                    spreadRadius: 1,
                  )
                ]
            ),
            child: ListTile(
              leading: Icon(
                icon,
                color: _selected?Theme.of(context).primaryColor : Theme.of(context).disabledColor,
                size: 40,
              ),
              title: Text(
                title,
                style: TextStyle(
                  fontSize: Dimension.font20,
                ),
              ),
              subtitle: Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).disabledColor,
                  fontSize: Dimension.font16,
                ),
              ),
              trailing: _selected?Icon(
                Icons.check_circle,
                color: Theme.of(context).primaryColor,
              ):null
            )
        ),
      );
    });
  }
}
