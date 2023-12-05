import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_hasan/Controllers/AuthController.dart';
import 'package:task_manager_hasan/Screen/Auth/LoginScreen.dart';
import 'package:task_manager_hasan/Screen/Home/main_bottom_nav.dart';
import 'package:task_manager_hasan/Widget/BodyBackground.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState(){
    super.initState();
    goLogin();
  }
  Future<void> goLogin() async {
    final bool isLogged = await AuthController.checkAuth();
    Future.delayed(const Duration(seconds: 2),() {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => isLogged ? MainBottomNav() :  LoginScreen(),), (route) => false);
    },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child : Center(
          child: SvgPicture.asset('assets/images/app-logo.svg',width: 120,),
        ),
      ),
    );
  }
}
