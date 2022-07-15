// ignore_for_file: import_of_legacy_library_into_null_safe, non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// to display loading animation
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ims/Mobile/MWelcomePage.dart';
// to route
import '../../../routes.dart';
import 'package:ims/Mobile/User/MHomePage_us.dart';
import 'package:ims/Mobile/User/MRentPage.dart';
import 'package:ims/Mobile/User/MReturnPage.dart';
import '../MHomePage_us.dart';

String baseUrl = Myroutes.baseUrl;

class Httpservices {
  static final _client = http.Client();
  static final _totemWelcomeUrl = Uri.parse(baseUrl + '/mobile');
  static final _totemUsrLoginRFIDUrl =
      Uri.parse(baseUrl + '/mobile/UsrLoginRFID');
  static final _totemUsrLoginCredentialUrl =
      Uri.parse(baseUrl + '/mobile/UsrLoginCredential');
  static final _totemRentUrl = Uri.parse(baseUrl + '/mobile/User/RentBook');
  static final _totemReturnUrl = Uri.parse(baseUrl + '/mobile/User/ReturnBook');
  static final _bookcheckRenturl = Uri.parse(baseUrl + '/mobile/BookCheckRent');
  static final _bookcheckReturnurl =
      Uri.parse(baseUrl + '/mobile/BookCheckReturn');

  // Redirect to Welcome page method
  static totemWelcome(context) async {
    http.Response response = await _client.get(_totemWelcomeUrl);
    if (response.statusCode == 200) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MWelcome()));
    }
  }

  // Login with rfid method
  static totemLoginUs(context) async {
    http.Response response = await _client.get(_totemUsrLoginRFIDUrl);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "not_found") {
        await EasyLoading.showError("User not fount");
      } else if (json[0] == "operator") {
        await EasyLoading.showError("Dear Operator, you are not a User");
      } else {
        await EasyLoading.showSuccess("Welcome dear " + json[1]);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const hmpage_us()));
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

  // Login with credentials method
  static totemLoginCredentialUs(userName, password, context) async {
    http.Response response = await _client.post(_totemUsrLoginCredentialUrl,
        body: {"userName": userName, "password": password});
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == 'not_found') {
        await EasyLoading.showError(json[0]);
      } else {
        await EasyLoading.showSuccess("Welcome Back " + json[1]);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const hmpage_us()));
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

  // book check Rent
  static Book_check_rent(context) async {
    http.Response response = await _client.get(_bookcheckRenturl);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "not_found") {
        await EasyLoading.showError('Book Not Found');
      } else if (json[0] == "Book_not_available") {
        await EasyLoading.showError("Book_not_available");
      } else {
        //await Httpservices.totemRentBook(rfid, context);
        http.Response response = await _client.get(_totemRentUrl);
        if (response.statusCode == 200) {
          await EasyLoading.showSuccess("Book rented successfully");
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const TRentPage()));
        }
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

  // book Check Return
  static Book_check_return(context) async {
    http.Response response = await _client.get(_bookcheckReturnurl);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "not_found") {
        await EasyLoading.showError('Book Not Found');
      } else {
        //await Httpservices.totemReturnBook(context);
        http.Response response = await _client.get(_totemReturnUrl);
        if (response.statusCode == 200) {
          await EasyLoading.showSuccess("Book returned successfully");
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const TReturnPage()));
        }
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }
}
