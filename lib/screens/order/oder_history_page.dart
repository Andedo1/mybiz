import 'package:flutter/material.dart';
import 'package:majisoft/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:majisoft/root/custom_appbar.dart';
import 'package:majisoft/screens/order/view_order.dart';
import 'package:majisoft/utils/dimensions.dart';

import '../../controllers/order_controller.dart';
import '../../routes/routes_helper.dart';
import '../../widgets/big_text.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin{
  late TabController _tabController;
  late bool _isLoggedIn;

  @override
  void initState(){
    super.initState();
    _isLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_isLoggedIn){
      _tabController = TabController(length: 2, vsync: this);
      // get order list
      Get.find<OrderController>().getOrderList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "My orders",
        backButtonExist: true,
      ),
      body: _isLoggedIn ? Column(
        children: [
          SizedBox(
            width: Dimension.screenWidth,
            child: TabBar(
              indicatorColor: Theme.of(context).primaryColor,
              indicatorWeight: 3,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Theme.of(context).disabledColor,
              controller: _tabController,
              tabs: const [
                Tab(text: "current",),
                Tab(text: "history",)
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                ViewOrderPage(isCurrent: true),
                ViewOrderPage(isCurrent: false)
              ],
            ),
          )
        ],
      ):
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: Dimension.width20*5,
              height: Dimension.height20*8,
              margin: EdgeInsets.only(left: Dimension.width20, right: Dimension.width20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimension.radius20),
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          "assets/images/padlock.png"
                      )
                  )
              ),
            ),
            SizedBox(height: Dimension.screenHeight*0.05,),
            GestureDetector(
              onTap: (){
                Get.toNamed(RoutesHelper.getSignInPage());
              },
              child: Container(
                width: double.maxFinite,
                height: Dimension.height20*3,
                margin: EdgeInsets.only(left: Dimension.width20, right: Dimension.width20),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(Dimension.radius20),
                ),
                child: Center(
                  child: BigText(
                    text: "Sign in",
                    color: Colors.white,
                    size: Dimension.font26,
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
