import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_hasan/Models/UserModel.dart';

class AuthController{
  static String? token;
  static UserModel? user;
  static Future<void> saveUserData(String t, UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('token',t);
    await sharedPreferences.setString('user',jsonEncode(model.toJson()));
    token = t;
    user = model;
  }
  static Future<void> updateUserData(UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('user',jsonEncode(model.toJson()));
    user = model;
  }
  static Future<void> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('token');
    user = UserModel.fromJson(jsonDecode(sharedPreferences.getString('user')??'{}'));
  }
  static Future<bool> checkAuth()async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token =  sharedPreferences.getString('token');
    if(token != null){
      await getUserData();
      return true;
    }else{
      return false;
    }
  }


  static Future<void> logOut()async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }


}