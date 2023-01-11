import 'package:get/get.dart';
import 'package:majisoft/data/repository/user_repo.dart';
import 'package:majisoft/models/response_model.dart';
import 'package:majisoft/models/user_model.dart';

class UserController extends GetxController implements GetxService{
  final UserRepo userRepo;

  UserController({required this.userRepo});

  bool _isLoading = false;
  late UserModel _userModel;
  UserModel get userModel=>_userModel;

  bool get isLoading => _isLoading;

  Future<ResponseModel> getUserInfo() async{
    Response response = await userRepo.getUserData();
    late ResponseModel responseModel;
    print(response.body.toString());
    if(response.statusCode==200){
      _userModel = UserModel.fromJson(response.body);
      _isLoading = true;
      responseModel = ResponseModel(true, "successfully");
    }else{
      print("did not get data");
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }


}