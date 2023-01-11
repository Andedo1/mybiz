import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:majisoft/controllers/auth_controller.dart';
import 'package:majisoft/models/signup_body_model.dart';
import 'package:majisoft/root/custom_loading_screen.dart';
import 'package:majisoft/root/show_snackback.dart';
import 'package:majisoft/screens/auth/signin_page.dart';
import 'package:majisoft/utils/dimensions.dart';
import 'package:majisoft/widgets/big_text.dart';
import 'package:majisoft/widgets/text_field.dart';
import 'package:get/get.dart';

import '../../routes/routes_helper.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();
    var nameController = TextEditingController();
    var signUpImages = [
      "t.png",
      "f.png",
      "g.png",
    ];
    void _register(AuthController authController){
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String phone = phoneController.text.trim();
      String name = nameController.text.trim();

      if(email.isEmpty){
        showCustomSnackBack("Email is required", title: "Email Address");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBack("Email is not a valid email address", title: "Invalid email address");
      }else if (password.isEmpty){
        showCustomSnackBack("Password is required", title: "Password");
      }else if(password.length<6){
        showCustomSnackBack("Password must be more than 6 characters", title: "Password");
      }else if(phone.isEmpty){
        showCustomSnackBack("Phone number is required", title: "Phone");
      }else if(name.isEmpty){
        showCustomSnackBack("Name is required", title: "Name");
      }else{
        SignUpBody signUpBody = SignUpBody(name: name, phone: phone, email: email, password: password);
        authController.registration(signUpBody).then((status){
          if(status.isSuccess){
            Get.toNamed(RoutesHelper.getSignInPage());
          }else{
            showCustomSnackBack(status.message);
          }
        });
      }
    }
    return Scaffold(
      body: GetBuilder<AuthController>(builder: (authController){
        return !authController.isLoading?SingleChildScrollView(
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
              // Email
              AppTextField(
                textEditingController: emailController,
                hintText: "Email",
                icon: Icons.email,
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
              // Name
              AppTextField(
                textEditingController: nameController,
                hintText: "Name",
                icon: Icons.person,
              ),
              SizedBox(height: Dimension.height20,),
              // Phone
              AppTextField(
                textEditingController: phoneController,
                hintText: "Phone",
                icon: Icons.phone_android,
              ),
              SizedBox(height: Dimension.height20,),
              // Sign up button
              GestureDetector(
                onTap: (){
                  _register(authController);
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
                      text: "Sign Up",
                      size: Dimension.font20+Dimension.font20/2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimension.height10,),
              // Have an account
              RichText(
                  text: TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>const SignInPage()),
                    text: "Have an account already?",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimension.font20,
                    ),
                  )
              ),
              SizedBox(height: Dimension.screenHeight*0.05,),
              // Sign up with other methods
              RichText(
                text: TextSpan(
                  text: "Sign up using one of the following methods",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimension.font16,
                  ),
                ),
              ),
              Wrap(
                  children: List.generate(3, (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: Dimension.radius30,
                      backgroundImage: AssetImage(
                          "assets/images/${signUpImages[index]}"
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ))
              )
            ],
          ),
        ):
        const CustomLoadingScreen();
      },)
    );
  }
}
