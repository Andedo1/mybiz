import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:majisoft/root/custom_loading_screen.dart';
import 'package:majisoft/routes/routes_helper.dart';
import 'package:majisoft/screens/auth/signup_page.dart';
import 'package:majisoft/utils/dimensions.dart';
import 'package:majisoft/widgets/big_text.dart';
import 'package:majisoft/widgets/text_field.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../root/show_snackback.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController){
      String phone = emailController.text.trim();
      String password = passwordController.text.trim();

      if(phone.isEmpty){
        showCustomSnackBack("Email is required", title: "Email Address");
      }else if (password.isEmpty){
        showCustomSnackBack("Password is required", title: "Password");
      }else if(password.length<6){
        showCustomSnackBack("Password must be more than 6 characters", title: "Password");
      }else{
        authController.login(phone, password).then((status){
          if(status.isSuccess){
            Get.toNamed(RoutesHelper.getInitial());
            //print("Successful login");
          }else{
            showCustomSnackBack(status.message);
          }
        });
      }
    }
    return Scaffold(
      body: GetBuilder<AuthController>(builder: (authController){
        return authController.isLoading? const CustomLoadingScreen():
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimension.screenHeight*0.05,),
              // Logo
              SizedBox(
                height: Dimension.screenHeight*0.15,
                child: const Center(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage(
                        "assets/images/logo.png"
                    ),
                  ),
                ),
              ),
              //Welcome Message
              Container(
                margin: EdgeInsets.only(left: Dimension.width20),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello",
                      style: TextStyle(
                        fontSize: Dimension.font20*3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Sign in to your account",
                      style: TextStyle(
                        fontSize: Dimension.font20,
                        color: Colors.grey[500],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: Dimension.height20,),
              // Email
              AppTextField(
                textEditingController: emailController,
                hintText: "Phone",
                icon: Icons.phone_android,
              ),
              SizedBox(height: Dimension.height20,),
              // Password
              AppTextField(
                textEditingController: passwordController,
                hintText: "Password",
                icon: Icons.password,
                isObscure: true,
              ),
              SizedBox(height: Dimension.height20,),
              Row(
                children: [
                  Expanded(child: Container()),
                  RichText(
                      text: TextSpan(
                        //recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                        text: "Forgot your password?",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimension.font20,
                        ),
                      )
                  ),
                  SizedBox(width: Dimension.width20,)
                ],
              ),
              SizedBox(height: Dimension.screenHeight*0.05,),
              // Sign in button
              GestureDetector(
                onTap: (){
                  _login(authController);
                },
                child: Container(
                  width: Dimension.screenWidth/2,
                  height: Dimension.screenHeight/13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimension.radius30),
                    color: Colors.green,
                  ),
                  child: Center(
                    child: BigText(
                      text: "Sign In",
                      size: Dimension.font20+Dimension.font20/2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimension.screenHeight*0.05,),
              RichText(
                  text: TextSpan(
                      text: "Don't have an account?",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimension.font20,
                      ),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap=()=>Get.to(()=>const SignUpPage(),
                                transition: Transition.fade),
                          text: " Create",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: Dimension.font20,
                          ),
                        )
                      ]
                  )
              ),
            ],
          ),
        );

      },)
    );
  }
}
