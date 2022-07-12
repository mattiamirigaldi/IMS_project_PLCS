// ignore_for_file: import_of_legacy_library_into_null_safe, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// to display loading animation
import 'package:flutter_easyloading/flutter_easyloading.dart';
// to route 

import 'package:ims/Totem/User/THomePage_us.dart';
import '../THomePage_op.dart';

String baseUrl = 'http://127.0.0.1:5000';

class Httpservices {
  
  static final _client = http.Client();
  static final _totemLoginUrl = Uri.parse(baseUrl+'/totem/Operator');
  static final _loginUrl = Uri.parse( baseUrl+'Operator/login');
  static final _totemAddCustomer = Uri.parse(baseUrl + 'totem/Operator/AddCustomer');
  static final _totemRemoveCustomer = Uri.parse(baseUrl + 'totem/Operator/RemoveCustomer');
  static final _totemAddBook = Uri.parse(baseUrl+ '/totem/Operator/AddBook');
  static final _totemRemoveBook = Uri.parse(baseUrl+ '/totem/Operator/RemoveBook');
  
  // Login with rfid method
  static totemLoginOp(context) async {
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

  // Login with credentials method
  static totemLoginCredentialOp (userName, password, context) async {
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

  
  // Add customer method 
  static totemAddCustomer (rfid) async {
    http.Response response = await _client
      .post(_totemAddCustomer, body: {"rfid": rfid});
      if (response.statusCode == 200){
        var json = jsonDecode(response.body);
        if(json[0] == "Customer already in db"){
          await EasyLoading.showError(json[0]);
        } else {
          await EasyLoading.showSuccess("Customer registered successfully");
        }
      } else {
        EasyLoading.showError("Error code : ${response.statusCode.toString()}");
      }
  }

    // Remove customer method 
  static totemRemoveCustomer(rfid) async {
    http.Response response = await _client
      .post(_totemRemoveCustomer, body: {"rfid": rfid});
      if (response.statusCode == 200){
        var json = jsonDecode(response.body);
        if(json[0] == "Customer not in db"){
          await EasyLoading.showError(json[0]);
        } else {
          await EasyLoading.showSuccess("Customer removed successfully");
        }
      } else {
        EasyLoading.showError("Error code : ${response.statusCode.toString()}");
      }
  }

    // Add book method 
  static totemAddBook (rfid) async {
    http.Response response = await _client
      .post(_totemAddBook, body: {"rfid": rfid});
      if (response.statusCode == 200){
        var json = jsonDecode(response.body);
        if(json[0] == "Book already in db"){
          await EasyLoading.showError(json[0]);
        } else {
          await EasyLoading.showSuccess("Book added correctly");
        }
      } else {
        EasyLoading.showError("Error code : ${response.statusCode.toString()}");
      }
  }  // Remove book method 
  static totemRemoveBook (rfid) async {
    http.Response response = await _client
      .post(_totemRemoveBook, body: {"rfid": rfid});
      if (response.statusCode == 200){
        var json = jsonDecode(response.body);
        if(json[0] == "Book not found in db"){
          await EasyLoading.showError(json[0]);
        } else {
          await EasyLoading.showSuccess("Book added successfully");
        }
      } else {
        EasyLoading.showError("Error code : ${response.statusCode.toString()}");
      }
  }
}