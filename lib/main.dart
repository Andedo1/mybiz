import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:majisoft/controllers/cart_controller.dart';
import 'package:majisoft/routes/routes_helper.dart';
import 'package:majisoft/helpers/dependencies.dart' as dep;

import 'controllers/popular_item_controller.dart';
import 'controllers/recommended_item_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularItemController>(builder: (_){
      return GetBuilder<RecommendedItemController>(builder: (_){
        return GetMaterialApp(
          title: 'Majisoft App',
          debugShowCheckedModeBanner: false,
          initialRoute: RoutesHelper.getSplashScreen(),
          getPages: RoutesHelper.routes,
        );
      });
    },);
  }
}
