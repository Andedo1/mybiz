import 'package:get/get.dart';
import 'package:majisoft/screens/Home/home_page.dart';
import 'package:majisoft/screens/cart/cart.dart';
import 'package:majisoft/screens/splash/splash_screen.dart';

import '../screens/auth/signin_page.dart';
import '../screens/item_detail.dart';
import '../screens/recomended_item_detail.dart';
class RoutesHelper{
  static const String splashScreen="/splash-screen";
  static const String initial='/';
  static const String popularItem = "/popular-item";
  static const String recommendedItem = "/recommended-item";
  static const String cart = "/cart";
  static const String signInPage = "/sign-in";

  static String getSplashScreen()=>splashScreen;
  static String getPopularItem(int pageId, String page)=>'$popularItem?pageId=$pageId&page=$page';
  static String getRecommendedItem(int pageId, String page)=>'$recommendedItem?pageId=$pageId&page=$page';
  static String getInitial()=>initial;
  static String getCart()=>cart;
  static String getSignInPage()=>signInPage;

  static List<GetPage> routes = [
    GetPage(name: initial, page: ()=>const HomePage()),
    GetPage(name: splashScreen, page: ()=>const SplashScreen()),
    GetPage(name: cart, page: () {
      return const CartPage();
    },
    transition: Transition.fadeIn),
    GetPage(name: signInPage, page: (){
      return const SignInPage();
    },
    transition: Transition.fade
    ),
    GetPage(name: recommendedItem, page: (){
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return RecommendedItemDetail(pageId:int.parse(pageId!), page:page!);
    },
    transition: Transition.fadeIn),
    GetPage(name: popularItem, page: () {
      var pageId=Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return ItemDetail(pageId:int.parse(pageId!), page:page!);
    },
    transition: Transition.fadeIn )
  ];
}