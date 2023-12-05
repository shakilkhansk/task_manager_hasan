import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager_hasan/Screen/Auth/PinVerify.dart';
import 'package:task_manager_hasan/Screen/Auth/RegistrationScreen.dart';

import '../../Widget/BodyBackground.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
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
                Text('Set Password' , style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 5,),
                const Text('Set your new password' , style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 20,),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password'
                  ),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      hintText: 'Confirm Password'
                  ),
                ),
                const SizedBox(height: 20,),
                SizedBox(width: double.infinity,
                child: ElevatedButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PinVerify(),));
                },
                    child: const Text('Confirm')),
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
