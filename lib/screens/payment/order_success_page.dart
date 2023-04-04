import 'package:flutter/material.dart';
import 'package:majisoft/routes/routes_helper.dart';
import 'package:majisoft/utils/dimensions.dart';

import '../../widgets/custom_button.dart';
import 'package:get/get.dart';

class OrderSuccessPage extends StatelessWidget {
  final String orderID;
  final int status;
  const OrderSuccessPage({Key? key, required this.status, required this.orderID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(status == 0){
      Future.delayed(Duration(seconds: 1), () {
        //Get.dialog(PaymentFaileddialog(orderID: orderID), barrierDismissible: false);
      });
    }
    return Scaffold(
      body: Center(child: SizedBox(
        width: Dimension.screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(status == 1 ? Icons.check_circle_outline : Icons.warning_amber_outlined,
            size: 100, color: Colors.green,),
            SizedBox(height: Dimension.height45,),
            Text(
              status == 1? 'You placed the order successfully' : 'Your order failed',
              style: TextStyle(fontSize: Dimension.font20),
            ),
            SizedBox(height: Dimension.height20,),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimension.height20,
                vertical: Dimension.height20,
              ),
              child: Text(
                status == 1? 'Successful order': 'Order failed',
                style: TextStyle(
                  fontSize: Dimension.font20,
                  color: Theme.of(context).disabledColor
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: Dimension.height10,),

            Padding(
              padding: EdgeInsets.all(Dimension.height10),
              child: CustomButton(
                buttonText: 'Back to Home',
                onPressed: () => Get.offAllNamed(RoutesHelper.getInitial()),
              ),
            )
          ],
        ),
      ),),
    );
  }
}
