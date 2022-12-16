import 'package:flutter/material.dart';
import 'package:majisoft/utils/dimensions.dart';
import 'package:majisoft/widgets/app_icon.dart';
import 'package:majisoft/widgets/big_text.dart';
import 'package:majisoft/widgets/expandable_text.dart';

class RecommendedItemDetail extends StatelessWidget {
  const RecommendedItemDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 80,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(icon: Icons.clear,),
                AppIcon(icon: Icons.shopping_cart_outlined)
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimension.radius20),
                    topLeft: Radius.circular(Dimension.radius20),
                  ),
                  color: Colors.white,
                ),
                child: Center(
                  child: BigText(size: Dimension.font26, text: "Water Meter",),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: Colors.yellow,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/image/some.png",
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
                  child: const ExpandableText(text: "Electromagnetic series ELMAG-600 Battery powered flow meter is"
                      "is ideal where power supply in not available on field, the battery power gives the flexibility to install a"
                      "a reliable flow meter virtually anywhere without distorting accuracy and performance."
                      "The battery on ELMAG has a lifespan of up to 10yrs. The meter is very easy to use and simple to install."
                      "The battery on ELMAG has a lifespan of up to 10yrs. The meter is very easy to use and simple to install."
                      "The battery on ELMAG has a lifespan of up to 10yrs. The meter is very easy to use and simple to install."
                      "The battery on ELMAG has a lifespan of up to 10yrs. The meter is very easy to use and simple to install."
                      "The battery on ELMAG has a lifespan of up to 10yrs. The meter is very easy to use and simple to install."
                      "The battery on ELMAG has a lifespan of up to 10yrs. The meter is very easy to use and simple to install.",
                  ),
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
                    BigText(text: "Ksh 100 "+"X "+"0", color: Colors.black, size: Dimension.font26,),
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
