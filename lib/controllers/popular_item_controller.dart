import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:majisoft/controllers/cart_controller.dart';
import 'package:majisoft/data/repository/popular_item_repo.dart';

import '../models/cart_model.dart';
import '../models/product_model.dart';


class PopularItemController extends GetxController{
  final PopularItemRepo popularItemRepo;

  PopularItemController({required this.popularItemRepo});
  List<dynamic> _popularItemList = [];
  List<dynamic> get popularItemList => _popularItemList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;


  Future<void> getPopularItemList() async{
    Response response = await popularItemRepo.getPopularItemList();
    if(response.statusCode==200){
      _popularItemList = [];
      _popularItemList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    }else{

    }
  }

  //Item quantity
  int _quantity = 0;
  int get quantity=>_quantity;
  int _inCartItems = 0;
  int get inCartItems=>_inCartItems+_quantity;

  void setQuantity(bool isIncrement){
    if(isIncrement){
      _quantity = checkQuantity(_quantity+100);
    }else{
      _quantity = checkQuantity(_quantity-100);
    }
    update();
  }

  int checkQuantity(int quantity){
    if((_inCartItems+quantity)<0){
      Get.snackbar('Item count', "You can't reduce more!",
          backgroundColor: Colors.blue,
          colorText: Colors.white
      );
      if(_inCartItems>0){
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    }else if((_inCartItems+quantity)>4000){
      Get.snackbar('Item count', "You can't increase more!",
          backgroundColor: Colors.blue,
          colorText: Colors.white
      );
      return 4000;
    }else{
      return quantity;
    }
  }

  void initItem(ProductModel product, CartController cart){
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);
    //if exists
    //get from storage _inCartItems
    print("exist or not ${exist.toString()}");
    if(exist){
      _inCartItems = _cart.getQuantity(product);
    }
    print("the quantity in cart is${_inCartItems.toString()}");
  }

  void addItem(ProductModel product){
      _cart.addItem(product, _quantity);
      _quantity = 0;
      _inCartItems = _cart.getQuantity(product);

      //debug method
      _cart.items.forEach((key, value) { 
        print("the id is ${value.id} quantity is ${value.quantity}");
      });
      update();
  }

  int get totalItems{
    return _cart.totalItems;
  }

  List<CartModel> get getItems{
    return _cart.getItems;
  }
}