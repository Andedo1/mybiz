import 'package:get/get.dart';
import 'package:majisoft/controllers/location_controller.dart';
import 'package:majisoft/controllers/order_controller.dart';
import 'package:majisoft/controllers/popular_item_controller.dart';
import 'package:majisoft/controllers/user_controller.dart';
import 'package:majisoft/data/api/aip_client.dart';
import 'package:majisoft/data/repository/auth_repo.dart';
import 'package:majisoft/data/repository/cart_repo.dart';
import 'package:majisoft/data/repository/order_repo.dart';
import 'package:majisoft/data/repository/popular_item_repo.dart';
import 'package:majisoft/data/repository/user_repo.dart';
import 'package:majisoft/utils/app_constants.dart';

import '../controllers/auth_controller.dart';
import '../controllers/cart_controller.dart';
import '../controllers/recommended_item_controller.dart';
import '../data/repository/location_repo.dart';
import '../data/repository/recommended_item_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async{
  final sharedPreferences = await SharedPreferences.getInstance();
  // dependency injection
  Get.lazyPut(() => sharedPreferences);
  //Load Api client
  Get.lazyPut(()=>ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));

  //Load repos
  Get.lazyPut(() => PopularItemRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedItemRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  Get.lazyPut(() => AuthRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => LocationRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => OrderRepo(apiClient: Get.find()));

  //Load controllers
  Get.lazyPut(() => PopularItemController(popularItemRepo: Get.find()));
  Get.lazyPut(() => RecommendedItemController(recommendedItemRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));
  Get.lazyPut(() => OrderController(orderRepo: Get.find()));

}