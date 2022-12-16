import 'package:get/get.dart';
import 'package:majisoft/data/repository/popular_item_repo.dart';

import '../models/product_model.dart';

class PopularItemController extends GetxController{
  final PopularItemRepo popularItemRepo;

  PopularItemController({required this.popularItemRepo});
  List<dynamic> _popularItemList = [];
  List<dynamic> get popularItemList => _popularItemList;

  Future<void> getPopularItemList() async{
    Response response = await popularItemRepo.getPopularItemList();
    if(response.statusCode==200){
      print("got data");
      _popularItemList = [];
      _popularItemList.addAll(ProductModel.fromJson(response.body).items);
      //print(_popularItemList);
      update();
    }else{

    }
  }
}