import 'dart:convert';
import 'package:counselaicompanion/backend/util/api_endpoints.dart';
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

import '../../frontend/screens/counsel_cases.dart';

class RegistrationController extends GetxController {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
  var user_pid;
  // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
  var access_token;
  // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
  var access_token_pid;
  // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
  var access_token_expiry;
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> handleSubmit() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url =
          Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.sendOTP);
      Map body = {"email": emailController.text.trim()};
      if (kDebugMode) {
        print(emailController.text);
      }
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['success']) {
          user_pid = json['data']['user_pid'];
          if (kDebugMode) {
            print(user_pid);
          }
          //final SharedPreferences prefs = await _prefs;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error In OTP Generation');
      }
    }
  }

  Future<void> handleOTP() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.verifyOTP);
      Map body = {"user_pid": user_pid, "email": emailController.text.trim()};
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['success']) {
          user_pid = json['data']['user_pid'];
          access_token_pid = json['data']['access_token_pid'];
          access_token = json['data']['access_token'];
          access_token_expiry = json['data']['access_token_expiry'];
          if (kDebugMode) {
            print(user_pid);
            print(access_token_pid);
            print(access_token);
            print(access_token_expiry);
          }
          final SharedPreferences prefs = await _prefs;
          await prefs.setString('user_pid', user_pid);
          await prefs.setString('access_token_pid', access_token_pid);
          await prefs.setString('access_token', access_token);
          await prefs.setString('access_token_expiry', access_token_expiry);
          emailController.clear();
          otpController.clear();
          // navigate to home page
          Get.off(HomePage());
        } else {
          jsonDecode(response.body)['message'] ?? "Unknown Error Occured";
        }
      } else {
        jsonDecode(response.body)['message'] ?? "Unknown Error Occured";
      }
    } catch (e) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: const Text('Error'),
              contentPadding: const EdgeInsets.all(20),
              children: [Text(e.toString())],
            );
          });
    }
  }
}
