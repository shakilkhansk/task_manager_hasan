import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager_hasan/Screen/Auth/PinVerify.dart';
import 'package:task_manager_hasan/Screen/Auth/RegistrationScreen.dart';

import '../../Widget/BodyBackground.dart';

class EmailVerify extends StatefulWidget {
  const EmailVerify({super.key});

  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
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
                Text('Your email address' , style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 5,),
                const Text('A 6 digit OTP will send to your email' , style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 20,),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Email'
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20,),
                SizedBox(width: double.infinity,
                child: ElevatedButton(onPressed: () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PinVerify(),), (route) => false);
                },
                    child: const Icon(Icons.arrow_circle_right_outlined)),
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
