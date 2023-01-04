import 'package:get/get.dart';
import 'package:majisoft/screens/Home/mainItem.dart';

import '../screens/item_detail.dart';
import '../screens/recomended_item_detail.dart';
class RoutesHelper{
  static const String initial='/';
  static const String popularItem = "/popular-item";
  static const String recommendedItem = "/recommended-item";

  static String getPopularItem(int pageId)=>'$popularItem?pageId=$pageId';
  static String getRecommendedItem()=>recommendedItem;
  static String getInitial()=>initial;

  static List<GetPage> routes = [
    GetPage(name: initial, page: ()=>const MainItem()),
    GetPage(name: recommendedItem, page: ()=>const RecommendedItemDetail()),
    GetPage(name: popularItem, page: () {
      var pageId=Get.parameters['pageId'];
      return ItemDetail(pageId:int.parse(pageId!));
    },
    transition: Transition.fadeIn )
  ];
}