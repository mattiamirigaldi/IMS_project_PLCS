// ignore_for_file: import_of_legacy_library_into_null_safe, non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// to display loading animation
import 'package:flutter_easyloading/flutter_easyloading.dart';
// to route

import 'package:ims/Totem/User/THomePage_us.dart';
import 'package:ims/Totem/User/TRentPage.dart';
import '../THomePage_us.dart';
import '../TReturnPage.dart';

String baseUrl = 'http://172.22.79.117:5000';

class Httpservices {
  static final _client = http.Client();
  static final _totemLoginUrl = Uri.parse(baseUrl + '/totem/user/login');
  static final _loginUrl = Uri.parse(baseUrl + '/login');
  static final _totemRentUrl = Uri.parse(baseUrl + '/totem/User/RentBook');
  static final _totemReturnUrl = Uri.parse(baseUrl + '/totem/User/ReturnBook');
  static final _bookcheckurl = Uri.parse(baseUrl + '/totem/BookCheck');

  // Login with rfid method
  static totemLoginUs(context) async {
    http.Response response = await _client.get(_totemLoginUrl);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "not_found") {
        await EasyLoading.showError(json[0]);
      } else {
        await EasyLoading.showSuccess(json[4]);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const hmpage_us()));
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

  // Login with credentials method
  static totemLoginCredentialUs(userName, password, context) async {
    http.Response response = await _client
        .post(_loginUrl, body: {"userName": userName, "password": password});
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == 'not_found') {
        await EasyLoading.showError(json[0]);
      } else {
        await EasyLoading.showSuccess("Welcome Back " + userName);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const hmpage_us()));
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

  // Rent book check
  static Book_check_rent(context) async {
    http.Response response = await _client.get(_bookcheckurl);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var rfid = 0;
      if (json[0] == "not_found") {
        await EasyLoading.showError('Book Not Found');
      } else {
        rfid = json[5];
        await Httpservices.totemRentBook(rfid, context);
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

//Return book Check
  static Book_check_return(context) async {
    http.Response response = await _client.get(_bookcheckurl);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var rfid = 0;
      if (json[0] == "not_found") {
        await EasyLoading.showError('Book Not Found');
      } else {
        rfid = json[5];
        await Httpservices.totemReturnBook(rfid, context);
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

  // Rent book method
  static totemRentBook(rfid, context) async {
    http.Response response = await _client.get(_totemRentUrl);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      await EasyLoading.showSuccess(json[0]);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const TRentPage()));
    }
  }

  // Return book method
  static totemReturnBook(rfid, context) async {
    http.Response response = await _client.get(_totemReturnUrl);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      await EasyLoading.showSuccess(json[0]);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const TReturnPage()));
    }
  }
}
