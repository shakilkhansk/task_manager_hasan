import 'package:flutter/material.dart';
import 'package:task_manager_hasan/Controllers/AuthController.dart';
import 'package:task_manager_hasan/Screen/EditProfileScreen.dart';

import '../Screen/Auth/LoginScreen.dart';

class ProfileSection extends StatefulWidget {
  const ProfileSection({super.key, this.enableOnTap = false});
  final bool enableOnTap;

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if(widget.enableOnTap){
          Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen(),));
        }
      },
      leading: const CircleAvatar(child: Icon(Icons.person)),
      title: Text("${AuthController.user?.firstName??''} ${AuthController.user!.lastName??''}",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      subtitle: Text(AuthController.user?.email??'',style: TextStyle(color: Colors.white),),
      trailing: IconButton(icon: const Icon(Icons.logout), onPressed: () async {
        await AuthController.logOut();
        if(mounted){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen(),), (route) => false);
        }
      },),
      tileColor: Colors.green,
    );
  }
}
