import 'package:flutter/material.dart';
import 'package:flutter_coffee/app/routes.dart';
import 'package:flutter_coffee/screens/splash/view_model/splash_view_model.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_button_widget.dart';

class SplashView extends StatelessWidget {
  SplashView({super.key});
  var viewModel = Get.put(SplashViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Obx((){
          if(viewModel.loadingScreen==true){
            return const CircularProgressIndicator(color: Colors.white,);
          }
          return ConstrainedBox(
            constraints: const BoxConstraints.expand(width: 600, height: 600),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 35),
                  child: Text(
                    "Welcome to Mobile App",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24
                    ),
                  ),
                ),
                CustomButtonWidget(
                  onTab: (){
                    Get.toNamed(RouteName.loginView);
                  },
                  title: "Login",
                ),
                SizedBox(height: 35,),
                CustomButtonWidget(
                  onTab: (){
                    Get.toNamed(RouteName.registerView);
                    //  Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterView()));
                  },
                  title: "Register",
                ),
              ],
            ),
          );
        })
      ),
    );
  }
}
