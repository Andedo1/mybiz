import 'package:flutter/material.dart';
import 'package:majisoft/utils/dimensions.dart';
import 'package:majisoft/widgets/app_icon.dart';
import 'package:majisoft/widgets/big_text.dart';
import 'package:majisoft/widgets/column.dart';
import 'package:majisoft/widgets/expandable_text.dart';


class ItemDetail extends StatelessWidget {
  const ItemDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  image: AssetImage(
                    "assets/image/some.png"
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
                AppIcon(icon: Icons.arrow_back_ios),
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
                    AppColumn(text: "Water Meter",),
                    SizedBox(height: Dimension.height20,),
                    BigText(text: "Introduce"),
                    SizedBox(height: Dimension.height20,),
                    const Expanded(
                      child: SingleChildScrollView(
                        child: ExpandableText(text: "Electromagnetic series ELMAG-600 Battery powered flow meter is"
                            "is ideal where power supply in not available on field, the battery power gives the flexibility to install a"
                            "a reliable flow meter virtually anywhere without distorting accuracy and performance."
                            "The battery on ELMAG has a lifespan of up to 10yrs. The meter is very easy to use and simple to install."
                            "The battery on ELMAG has a lifespan of up to 10yrs. The meter is very easy to use and simple to install."
                            "The battery on ELMAG has a lifespan of up to 10yrs. The meter is very easy to use and simple to install."
                            "The battery on ELMAG has a lifespan of up to 10yrs. The meter is very easy to use and simple to install."
                            "The battery on ELMAG has a lifespan of up to 10yrs. The meter is very easy to use and simple to install."
                            "The battery on ELMAG has a lifespan of up to 10yrs. The meter is very easy to use and simple to install.",),
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
              child: BigText(text: "Ksh100 | Add to cart", color: Colors.white,),
            )
          ],
        ),
      ),
    );
  }
}
