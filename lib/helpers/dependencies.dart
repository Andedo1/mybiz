import 'package:get/get.dart';
import 'package:majisoft/controllers/popular_item_controller.dart';
import 'package:majisoft/data/api/aip_client.dart';
import 'package:majisoft/data/repository/popular_item_repo.dart';
import 'package:majisoft/utils/app_constants.dart';

Future<void> init() async{
  //Load Api client
  Get.lazyPut(()=>ApiClient(appBaseUrl: AppConstants.BASE_URL));
  //Load repos
  Get.lazyPut(() => PopularItemRepo(apiClient: Get.find()));
  //Load controllers
  Get.lazyPut(() => PopularItemController(popularItemRepo: Get.find()));
}