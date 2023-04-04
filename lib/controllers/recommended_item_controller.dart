import 'package:get/get.dart';
import '../data/repository/recommended_item_repo.dart';
import '../models/product_model.dart';


class RecommendedItemController extends GetxController{
  final RecommendedItemRepo recommendedItemRepo;

  RecommendedItemController({required this.recommendedItemRepo});
  List<dynamic> _recommendedItemList = [];
  List<dynamic> get recommendedItemList => _recommendedItemList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedItemList() async{
    Response response = await recommendedItemRepo.getRecommendedItemList();
    if(response.statusCode==200){
      //print("got data");
      _recommendedItemList = [];
      _recommendedItemList.addAll(Product.fromJson(response.body).products.reversed);
      //print(_recommendedItemList);
      _isLoaded = true;
      update();
    }else{
      // TODO: print error message
    }
  }
}