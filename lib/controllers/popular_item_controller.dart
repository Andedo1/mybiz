import 'package:get/get.dart';
import 'package:majisoft/data/repository/popular_item_repo.dart';

import '../models/product_model.dart';


class PopularItemController extends GetxController{
  final PopularItemRepo popularItemRepo;

  PopularItemController({required this.popularItemRepo});
  List<dynamic> _popularItemList = [];
  List<dynamic> get popularItemList => _popularItemList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getPopularItemList() async{
    Response response = await popularItemRepo.getPopularItemList();
    if(response.statusCode==200){
      print("got data");
      _popularItemList = [];
      _popularItemList.addAll(Product.fromJson(response.body).products);
      print(_popularItemList);
      _isLoaded = true;
      update();
    }else{

    }
  }
}