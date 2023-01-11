import 'dart:async';
import 'package:majisoft/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:majisoft/routes/routes_helper.dart';

import '../../controllers/popular_item_controller.dart';
import '../../controllers/recommended_item_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResources() async{
    await Get.find<PopularItemController>().getPopularItemList();
    await Get.find<RecommendedItemController>().getRecommendedItemList();
  }

  @override
  void initState(){
    super.initState();
    _loadResources();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    Timer(
      const Duration(seconds: 3),
          ()=>Get.offNamed(RoutesHelper.getInitial()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset("assets/images/logo.png", width: Dimension.splashImg,),
            ),
          )
        ],
      ),
    );
  }
}
