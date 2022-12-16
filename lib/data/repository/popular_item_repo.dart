import 'package:get/get.dart';
import 'package:majisoft/data/api/aip_client.dart';
import 'package:majisoft/utils/app_constants.dart';

class PopularItemRepo extends GetxService{
  final ApiClient apiClient;
  PopularItemRepo({required this.apiClient});

  Future<Response> getPopularItemList() async{
    return await apiClient.getData(AppConstants.POPULAR_ITEM_URI);
  }
}