import 'dart:math';

import 'package:flutter/material.dart';
import 'package:task_manager_hasan/Api/apiCall.dart';
import 'package:task_manager_hasan/Api/urls.dart';

import '../../Widget/BodyBackground.dart';
import '../../Widget/showSnackMessage.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
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
            child: SingleChildScrollView(
              child: Form(
                key: _myForm,
                child: Column(
                  children: [
                    const SizedBox(height: 80,),
                    Text('Join with us' , style: Theme.of(context).textTheme.titleLarge),
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
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                          hintText: 'First Name'
                      ),
                      validator: (value) {
                        if(value==null || value.trim().isEmpty){
                          return 'Please enter your first name';
                        }
                      },
                    ),
                    const SizedBox(height: 20,),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                          hintText: 'Last Name'
                      ),
                      validator: (value) {
                        if(value==null || value.trim().isEmpty){
                          return 'Please enter your last name';
                        }
                      },
                    ),
                    const SizedBox(height: 20,),
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                          hintText: 'Phone'
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if(value==null || value.trim().isEmpty){
                          return 'Please enter your phone number';
                        }
                        if(!value.startsWith('01') && !RegExp(r'^\d{11}$').hasMatch(value)){
                          return 'Please enter a valid phone number';
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
                      replacement: const Center(child: CircularProgressIndicator()),
                      child: ElevatedButton(onPressed: () async {
                        if (_myForm.currentState!.validate()) {
                          setState(() {
                            loader = true;
                          });
                          final ApiResponse response = await ApiRequest()
                              .postRequest(Urls.registration,body: {
                                'firstName'  :  _firstNameController.text,
                                'lastName'  :  _lastNameController.text,
                                'email'  :  _emailController.text,
                                'phone'  :  _phoneController.text,
                                'password'  :  _passwordController.text,
                          });
                          if(response.isSuccess){
                            clearTextField();
                            if(mounted){
                              showSnackMessage(context,'Registration is successful');
                            }
                          }else{
                            if(mounted){
                              showSnackMessage(context,'Registration failed plz try again',true);
                            }
                          }
                          setState(() {
                            loader = false;
                          });
                        }
                      },
                          child: const Icon(Icons.arrow_circle_right_outlined)),
                    ),
                    ),
                    const SizedBox(height: 48,),
                    Center(child: TextButton(onPressed: () {
                    }, child: const Text('Forget Password?', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.grey,fontSize: 16),),),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?" ,style:  TextStyle(fontWeight: FontWeight.w600,color: Colors.grey),),
                        TextButton(onPressed: () {
                          Navigator.pop(context);
                        }, child: const Text('Sign In', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.green,fontSize: 16),),)
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
  void clearTextField(){
    _emailController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _phoneController.clear();
    _passwordController.clear();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
