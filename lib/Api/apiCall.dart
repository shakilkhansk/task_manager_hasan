import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager_hasan/Controllers/AuthController.dart';
import 'package:task_manager_hasan/Screen/Auth/LoginScreen.dart';
import 'package:task_manager_hasan/app.dart';

class ApiRequest {
  Future<ApiResponse> postRequest(String url, {Map<String, dynamic>? body,bool loginScreen = false}) async {
    print(url);
    print(body);
    try {
      final Response response = await post(
        Uri.parse(url),
        headers: {
          'Content-type': 'Application/json',
          'token' : AuthController.token.toString(),
        },
        body: jsonEncode(body),
      );
      print(response.body);
      if (response.statusCode == 200) {
        return ApiResponse(
            isSuccess: true,
            jsonResponse: jsonDecode(response.body),
            statusCode: response.statusCode);
      }else if(response.statusCode==401){
        if(!loginScreen){
          backToLogin();
        }
        return ApiResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMsg: 'Authentication failed login again');
      } else {
        return ApiResponse(
            isSuccess: false,
            jsonResponse: jsonDecode(response.body),
            statusCode: response.statusCode,
            errorMsg: 'Request failed plz try again');
      }
    } catch (e) {
      return ApiResponse(isSuccess: false, errorMsg: e.toString());
    }
  }
  Future<ApiResponse> getRequest(String url) async {
    try {
      final Response response = await get(
        Uri.parse(url),
        headers: {
          'Content-type': 'Application/json',
          'token' : AuthController.token.toString(),
        },
      );
print(response.body);
      if (response.statusCode == 200) {
        return ApiResponse(
            isSuccess: true,
            jsonResponse: jsonDecode(response.body),
            statusCode: response.statusCode);
      }else if(response.statusCode==401){
          backToLogin();
        return ApiResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMsg: 'Authentication failed login again');
      } else {
        return ApiResponse(
            isSuccess: false,
            jsonResponse: jsonDecode(response.body),
            statusCode: response.statusCode,
            errorMsg: 'Request failed plz try again');
      }
    } catch (e) {
      return ApiResponse(isSuccess: false, errorMsg: e.toString());
    }
  }
  Future<void> backToLogin() async {
    await AuthController.logOut();
    Navigator.pushAndRemoveUntil(MyApp.navigationKey.currentContext!, MaterialPageRoute(builder: (context) => LoginScreen(),), (route) => false);
  }
}

class ApiResponse {
  final int? statusCode;
  final bool isSuccess;
  final Map<String, dynamic>? jsonResponse;
  final String? errorMsg;

  ApiResponse(
      {this.statusCode = -1,
      required this.isSuccess,
      this.jsonResponse,
      this.errorMsg = 'Something went wrong!'});
}
