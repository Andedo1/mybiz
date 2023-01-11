import 'package:get/get.dart';
import 'package:majisoft/data/api/aip_client.dart';
import 'package:majisoft/models/signup_body_model.dart';
import 'package:majisoft/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.sharedPreferences, required this.apiClient});

  // User registration
  Future<Response> registration(SignUpBody signUpBody) async{
    return await apiClient.postData(AppConstants.REGISTRATION_URI, signUpBody.toJson());
  }

  // User Login
  Future<Response> login(String phone, String password) async{
    return await apiClient.postData(AppConstants.LOGIN_URI,
        {"phone":phone, "password":password});
  }

  Future<bool> saveUserToken(String token) async{
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }


  Future<String> getUserToken() async {
    return sharedPreferences.getString(AppConstants.TOKEN)??"None";
  }


  bool userLoggedIn(){
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }


  Future<void> saveUserNumberAndPassword(String number, String password) async{
    try{
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
      await sharedPreferences.setString(AppConstants.PHONE, number);
    }catch(e){
      rethrow;
    }
  }

  bool clearSharedData(){
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.PASSWORD);
    sharedPreferences.remove(AppConstants.PHONE);
    apiClient.token='';
    apiClient.updateHeader('');
    return true;
  }

}