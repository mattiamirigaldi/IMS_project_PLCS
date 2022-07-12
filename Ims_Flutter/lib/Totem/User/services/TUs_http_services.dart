// ignore_for_file: import_of_legacy_library_into_null_safe, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// to display loading animation
import 'package:flutter_easyloading/flutter_easyloading.dart';
// to route 

import 'package:ims/Totem/User/THomePage_us.dart';
import '../THomePage_us.dart';

String baseUrl = 'http://127.0.0.1:5000';

class Httpservices {
  
  static final _client = http.Client();
  static final _totemLoginUrl = Uri.parse(baseUrl+'/totem');
  static final _loginUrl = Uri.parse( baseUrl+'/login');

  static totemLogin(context) async {
    http.Response response = await _client.get(_totemLoginUrl);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == 'user not registered') {
        await EasyLoading.showError('Error');
      } else {
        await EasyLoading.showSuccess(json[0]);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => hmpage_us( )));
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

  static totemLoginCredential (userName, password, context) async {
    http.Response response = await _client
        .post(_loginUrl, body: {"userName": userName, "password": password});
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == 'user not registered') {
        await EasyLoading.showError(json[0]);
      } else {
        await EasyLoading.showSuccess("Welcome Back " + userName);
        var json = jsonDecode(response.body);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => hmpage_us()
            )
        );
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

  // rent book method 
  static totemRentBook (rfid){

  }
  // return book method
  static totemReturnBook (rfid){
    
  }

}