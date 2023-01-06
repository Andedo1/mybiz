import 'package:get/get.dart';
import 'package:majisoft/controllers/popular_item_controller.dart';
import 'package:majisoft/data/api/aip_client.dart';
import 'package:majisoft/data/repository/cart_repo.dart';
import 'package:majisoft/data/repository/popular_item_repo.dart';
import 'package:majisoft/utils/app_constants.dart';

import '../controllers/cart_controller.dart';
import '../controllers/recommended_item_controller.dart';
import '../data/repository/recommended_item_repo.dart';

Future<void> init() async{
  //Load Api client
  Get.lazyPut(()=>ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //Load repos
  Get.lazyPut(() => PopularItemRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedItemRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo());

  //Load controllers
  Get.lazyPut(() => PopularItemController(popularItemRepo: Get.find()));
  Get.lazyPut(() => RecommendedItemController(recommendedItemRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}