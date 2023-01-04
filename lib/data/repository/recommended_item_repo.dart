import 'package:get/get.dart';
import 'package:majisoft/data/api/aip_client.dart';
import 'package:majisoft/utils/app_constants.dart';

class RecommendedItemRepo extends GetxService{
  final ApiClient apiClient;
  RecommendedItemRepo({required this.apiClient});

  Future<Response> getRecommendedItemList() async{
    return await apiClient.getData(AppConstants.RECOMMENDED_ITEM_URI);
  }
}