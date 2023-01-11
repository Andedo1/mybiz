import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';
import '../../utils/app_constants.dart';

class CartRepo{
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart=[];
  List<String> cartHistory=[];

  void addToCartList(List<CartModel> cartList){
    var time = DateTime.now().toString();
    cart = [];
    //Convert objects to String coz
    // shared preferences only accepts string
    for (var element in cartList) {
      element.time = time;
      cart.add(jsonEncode(element));
    }

    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    getCartList();
  }

  List<CartModel> getCartList(){
    List<String> carts = [];
    if(sharedPreferences.containsKey(AppConstants.CART_LIST)){
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
    }
    List<CartModel> cartList=[];
    for(var element in carts) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    }

    return cartList;
  }

  List<CartModel> getCartHistory(){
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY)){
      cartHistory=[];
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY)!;
    }
    List<CartModel> cartListHistory=[];
    for(var element in cartHistory){
      cartListHistory.add(CartModel.fromJson(jsonDecode(element)));
    }

    return cartListHistory;
  }

  void addToCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY)){
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY)!;
    }
    for(int i=0; i<cart.length; i++){
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(AppConstants.CART_HISTORY, cartHistory);
  }

  void removeCart(){
    sharedPreferences.remove(AppConstants.CART_LIST);
  }

  void clearCartHistory(){
    removeCart();
    cartHistory=[];
    sharedPreferences.remove(AppConstants.CART_HISTORY);
  }
}