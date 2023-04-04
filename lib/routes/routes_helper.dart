import 'package:get/get.dart';
import 'package:majisoft/models/order_model.dart';
import 'package:majisoft/screens/Home/home_page.dart';
import 'package:majisoft/screens/address/add_address.dart';
import 'package:majisoft/screens/address/pick_address_map.dart';
import 'package:majisoft/screens/cart/cart.dart';
import 'package:majisoft/screens/splash/splash_screen.dart';

import '../screens/auth/signin_page.dart';
import '../screens/item_detail.dart';
import '../screens/payment/order_success_page.dart';
import '../screens/payment/paypal_payment.dart';
import '../screens/recomended_item_detail.dart';

class RoutesHelper{
  static const String splashScreen="/splash-screen";
  static const String initial='/';
  static const String popularItem = "/popular-item";
  static const String recommendedItem = "/recommended-item";
  static const String cart = "/cart";
  static const String signInPage = "/sign-in";
  static const String addAddress = "/add-address";
  static const String pickAddressMap = "/pick-address";
  static const String payment = "/payment";
  static const String orderSuccessful = "/order-successful";

  static String getSplashScreen()=>splashScreen;
  static String getPopularItem(int pageId, String page)=>'$popularItem?pageId=$pageId&page=$page';
  static String getRecommendedItem(int pageId, String page)=>'$recommendedItem?pageId=$pageId&page=$page';
  static String getInitial()=>initial;
  static String getCart()=>cart;
  static String getSignInPage()=>signInPage;
  static String getAddressPage()=>addAddress;
  static String getPickAddressMapPage()=>pickAddressMap;
  static String getPaymentPage(String id, int userID)=>'$payment?id=$id&userID=$userID';
  static String getOrderSuccess(String orderID, String status)=>'$orderSuccessful?id=$orderID&status=$status';

  static List<GetPage> routes = [
    GetPage(name: initial, page: ()=>const HomePage(), transition: Transition.fade),
    GetPage(name: splashScreen, page: ()=>const SplashScreen()),
    GetPage(name: cart, page: () {
      return const CartPage();
    },
    transition: Transition.fadeIn),

    GetPage(name: addAddress, page: (){
      return const AddressPage();
    },
    transition: Transition.fade
    ),

    GetPage(name: pickAddressMap, page: (){
      PickAddressMap pickAddressMap = Get.arguments;
      return pickAddressMap;
    },
    transition: Transition.fade),

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
    transition: Transition.fadeIn ),

    GetPage(name: payment, page: ()=>PaymentPage(
      orderModel: OrderModel(
          id: int.parse(Get.parameters['id']!),
          userId: int.parse(Get.parameters['userID']!)
      )
    )),

    GetPage(name: orderSuccessful, page: ()=>OrderSuccessPage(
      orderID: Get.parameters['id']!,
      status: Get.parameters['status'].toString().contains("success")?1:0,
    ))
  ];
}