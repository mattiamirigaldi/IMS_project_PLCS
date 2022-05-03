import 'package:flutter/material.dart';
// to handle http protocol : 
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
// to display loading animation
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Httpservices {
  
  static final _client = http.Client();
  static var _loginUrl  = Uri.parse('http://127.0.0.1:5000/login');
  static var _registerUrl = Uri.parse('http://127.0.0.1:5000/register');

  static register(firstName, lastName, userName, email, password, context) async {
    http.Response response = await _client.post(
        _registerUrl, 
        body: {
          "firstName" : firstName,
          "lastName": lastName,
          "userName": userName,
          "email" : email,
          "password":password
        }
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == 'user already exist') {
        await EasyLoading.showError(json[0]);
      } else {
        await EasyLoading.showSuccess(json[0]);
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => Dashboard()));
      } 
    } else {
      
      await EasyLoading?.showError(
          "Error Code : ${response.statusCode.toString()}");   
      }
  }
}