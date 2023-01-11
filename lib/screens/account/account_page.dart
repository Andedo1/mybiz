import 'package:flutter/material.dart';
import 'package:majisoft/controllers/auth_controller.dart';
import 'package:majisoft/controllers/cart_controller.dart';
import 'package:majisoft/controllers/user_controller.dart';
import 'package:majisoft/root/custom_loading_screen.dart';
import 'package:majisoft/routes/routes_helper.dart';
import 'package:majisoft/utils/dimensions.dart';
import 'package:majisoft/widgets/app_icon.dart';
import 'package:majisoft/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../widgets/account_widget.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userIsLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_userIsLoggedIn){
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: BigText(text: "Profile", size: 24, color: Colors.white,),
      ),
      body: GetBuilder<UserController>(builder: (userController){
        return _userIsLoggedIn?(userController.isLoading?
        SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: Dimension.height30,),
              // Profile icon
              AppIcon(
                icon: Icons.person,
                backgroundColor: Colors.green,
                iconColor: Colors.white,
                iconSize: Dimension.height15*5,
                size: Dimension.height15*10,
              ),
              SizedBox(height: Dimension.height30,),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Name
                      AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.person,
                          backgroundColor: Colors.green,
                          iconColor: Colors.white,
                          iconSize: Dimension.height10*5/2,
                          size: Dimension.height10*5,
                        ),
                        bigText: BigText(text: userController.userModel.name,),
                      ),
                      SizedBox(height: Dimension.height20,),
                      // Phone
                      AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.phone,
                          backgroundColor: Colors.yellow,
                          iconColor: Colors.white,
                          iconSize: Dimension.height10*5/2,
                          size: Dimension.height10*5,
                        ),
                        bigText: BigText(text: userController.userModel.phone,),
                      ),
                      SizedBox(height: Dimension.height20,),
                      // Email
                      AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.mail,
                          backgroundColor: Colors.yellow,
                          iconColor: Colors.white,
                          iconSize: Dimension.height10*5/2,
                          size: Dimension.height10*5,
                        ),
                        bigText: BigText(text: userController.userModel.email,),
                      ),
                      SizedBox(height: Dimension.height20,),
                      // Address
                      AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.location_on,
                          backgroundColor: Colors.yellow,
                          iconColor: Colors.white,
                          iconSize: Dimension.height10*5/2,
                          size: Dimension.height10*5,
                        ),
                        bigText: BigText(text: 'Bermuda plaza',),
                      ),
                      SizedBox(height: Dimension.height20,),
                      // About
                      AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.message,
                          backgroundColor: Colors.yellow,
                          iconColor: Colors.white,
                          iconSize: Dimension.height10*5/2,
                          size: Dimension.height10*5,
                        ),
                        bigText: BigText(text: 'Messages',),
                      ),
                      SizedBox(height: Dimension.height20,),
                      // About
                      GestureDetector(
                        onTap: (){
                          if(Get.find<AuthController>().userLoggedIn()){
                            Get.find<AuthController>().clearSharedData();
                            Get.find<CartController>().clear();
                            Get.find<CartController>().clearCartHistory();
                            Get.toNamed(RoutesHelper.getSignInPage());
                          }
                        },
                        child: AccountWidget(
                          appIcon: AppIcon(
                            icon: Icons.logout,
                            backgroundColor: Colors.redAccent,
                            iconColor: Colors.white,
                            iconSize: Dimension.height10*5/2,
                            size: Dimension.height10*5,
                          ),
                          bigText: BigText(text: 'Logout',),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ):
        const CustomLoadingScreen()):
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: Dimension.width20*5,
                height: Dimension.height20*8,
                margin: EdgeInsets.only(left: Dimension.width20, right: Dimension.width20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimension.radius20),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      "assets/images/padlock.png"
                    )
                  )
                ),
              ),
              SizedBox(height: Dimension.screenHeight*0.05,),
              GestureDetector(
                onTap: (){
                  Get.toNamed(RoutesHelper.getSignInPage());
                },
                child: Container(
                  width: double.maxFinite,
                  height: Dimension.height20*3,
                  margin: EdgeInsets.only(left: Dimension.width20, right: Dimension.width20),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(Dimension.radius20),
                  ),
                  child: Center(
                    child: BigText(
                      text: "Sign in",
                      color: Colors.white,
                      size: Dimension.font26,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },)
    );
  }
}
