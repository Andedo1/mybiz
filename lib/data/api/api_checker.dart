import 'package:get/get.dart';
import 'package:majisoft/root/show_snackback.dart';

import '../../routes/routes_helper.dart';

class ApiChecker{
  static void checkApi(Response response){
    if(response.statusCode==401){
      Get.offNamed(RoutesHelper.getSignInPage());
    }else{
      showCustomSnackBack(response.statusText!);
    }
  }
}