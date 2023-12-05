import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_hasan/Screen/Auth/PasswordReset.dart';
import 'package:task_manager_hasan/Screen/Auth/RegistrationScreen.dart';

import '../../Widget/BodyBackground.dart';

class PinVerify extends StatefulWidget {
  const PinVerify({super.key});

  @override
  State<PinVerify> createState() => _PinVerifyState();
}

class _PinVerifyState extends State<PinVerify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const SizedBox(height: 80,),
                Text('Pin Verify' , style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 5,),
                const Text('A 6 digit OTP will send to your email' , style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 20,),
                PinCodeTextField(
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    inactiveColor: Colors.white,
                    selectedFillColor: Colors.white
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,

                  enableActiveFill: true,
                  onCompleted: (v) {
                    print("Completed");
                  },
                  onChanged: (value) {
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  }, appContext: context,
                ),
                const SizedBox(height: 20,),
                SizedBox(width: double.infinity,
                child: ElevatedButton(onPressed: () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PasswordReset(),), (route) => false);
                },
                    child: const Text('Verify')),
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
    );
  }
}
