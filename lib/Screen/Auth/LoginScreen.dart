import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_hasan/Api/apiCall.dart';
import 'package:task_manager_hasan/Api/urls.dart';
import 'package:task_manager_hasan/Controllers/AuthController.dart';
import 'package:task_manager_hasan/Models/UserModel.dart';
import 'package:task_manager_hasan/Screen/Auth/EmailVerify.dart';
import 'package:task_manager_hasan/Screen/Auth/RegistrationScreen.dart';
import 'package:task_manager_hasan/Screen/Home/main_bottom_nav.dart';
import 'package:task_manager_hasan/Widget/showSnackMessage.dart';

import '../../Widget/BodyBackground.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _myForm = GlobalKey<FormState>();
  bool loader = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _myForm,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 80,),
                    Text('Get start with us' , style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 20,),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                          hintText: 'Email'
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if(value==null || value.trim().isEmpty){
                          return 'Please enter your email address';
                        }
                        if(!value.contains('@')){
                          return 'Please enter a valid email address';
                        }
                      },
                    ),
                    const SizedBox(height: 20,),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                      obscureText: true,
                      validator: (value) {
                        if(value==null || value.trim().isEmpty){
                          return 'Please enter your password';
                        }
                        if(value.length<6){
                          return 'Minimum 6 digit is required';
                        }
                      },
                    ),
                    const SizedBox(height: 20,),
                    SizedBox(width: double.infinity,
                    child: Visibility(
                      visible: !loader,
                      replacement: Center(child: CircularProgressIndicator()),
                      child: ElevatedButton(onPressed: () {
                        if(_myForm.currentState!.validate()){
                          login();
                        }
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => MainBottomNav(),));
                      },
                          child: const Icon(Icons.arrow_circle_right_outlined)),
                    ),
                    ),
                    const SizedBox(height: 48,),
                    Center(child: TextButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EmailVerify(),));
                    }, child: const Text('Forget Password?', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.grey,fontSize: 16),),),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?" ,style:  TextStyle(fontWeight: FontWeight.w600,color: Colors.grey),),
                        TextButton(onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreen(),));
                        }, child: const Text('Sign Up', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.green,fontSize: 16),),)
                      ],
                    )

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> login()async {
    setState(() {
      loader = true;
    });
    ApiResponse response = await ApiRequest().postRequest(Urls.login,
        body: {
          'email'  :  _emailController.text,
          'password'  :  _passwordController.text,
        },loginScreen: true
    );
    setState(() {
      loader = false;
    });
    if(response.isSuccess){
      await AuthController.saveUserData(response.jsonResponse?['token'], UserModel.fromJson(response.jsonResponse?['data']));
      if(mounted){
        Navigator.push(context, MaterialPageRoute(builder: (context) => MainBottomNav(),));
      }
    }else{
      if(response.statusCode==401){
        if(mounted){
          showSnackMessage(context, 'Wrong email or password',true);
        }else{
          if(mounted){
            showSnackMessage(context, 'Login failed try again',true);
          }
        }
      }
    }
  }
}
