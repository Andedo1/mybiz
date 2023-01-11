import 'package:get/get.dart';
import 'package:majisoft/data/api/aip_client.dart';

import '../../utils/app_constants.dart';

class UserRepo{
  final ApiClient apiClient;
  UserRepo({required this.apiClient});

  Future<Response> getUserData() async {
    return await apiClient.getData(AppConstants.USERDATA_URI);
  }
}