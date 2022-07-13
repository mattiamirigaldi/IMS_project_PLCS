// ignore_for_file: import_of_legacy_library_into_null_safe, non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// to display loading animation
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ims/Totem/Operator/TRemoveBook.dart';
// to route

import '../THomePage_op.dart';
import '../TRemoveCustomer.dart';

String baseUrl = 'http://172.22.32.112:5000';

class Httpservices {
  static final _client = http.Client();
  static final _totemLoginUrl = Uri.parse(baseUrl + '/totem/login');
  static final _loginUrl = Uri.parse(baseUrl + '/login');
  static final _bookcheckurl = Uri.parse(baseUrl + '/totem/BookCheck');
  static final _totemAddCustomer =
      Uri.parse(baseUrl + '/totem/Operator/AddCustomer');
  static final _totemRemoveCustomer =
      Uri.parse(baseUrl + '/totem/Operator/RemoveCustomer');
  static final _totemAddBook = Uri.parse(baseUrl + '/totem/Operator/AddBook');
  static final _totemRemoveBook =
      Uri.parse(baseUrl + '/totem/Operator/RemoveBook');

  // Login with rfid method
  static totemLoginOp(context) async {
    http.Response response = await _client.get(_totemLoginUrl);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "not_found") {
        await EasyLoading.showError(json[0]);
      } else {
        await EasyLoading.showSuccess(json[4]);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const hmpage_op()));
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

  // Login with credentials method
  static totemLoginCredentialOp(userName, password, context) async {
    http.Response response = await _client
        .post(_loginUrl, body: {"userName": userName, "password": password});
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "not_found") {
        await EasyLoading.showError(json[0]);
      } else {
        await EasyLoading.showSuccess("Welcome Back " + userName);
        var json = jsonDecode(response.body);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const hmpage_op()));
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

  // Add customer method
  static totemAddCustomer(
    firstName,
    lastName,
    username,
    email,
    password,
    context,
  ) async {
    await EasyLoading.showSuccess("entered in http services");
    http.Response response = await _client.post(_totemAddCustomer, body: {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "username": username,
      "password": password
    });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "new User added to the database successfully") {
        await EasyLoading.showSuccess(json[0]);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const hmpage_op()));
      } else {
        await EasyLoading.showError(json[0]);
      }
    } else {
      EasyLoading.showError("Error code : ${response.statusCode.toString()}");
    }
  }

  // Remove customer check
  static RemoveCheck(context) async {
    http.Response response = await _client.get(_totemLoginUrl);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var rfid = 0;
      if (json[0] == "not_found") {
        await EasyLoading.showError('User Not Found');
      } else {
        rfid = json[6];
        await Httpservices.totemRemoveCustomer(rfid, context);
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

  // Remove customer method
  static totemRemoveCustomer(rfid, context) async {
    http.Response response = await _client.get(_totemRemoveCustomer);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      await EasyLoading.showSuccess(json[0]);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const TRemoveCustomer()));
    }
  }

  // Add book method
  static totemAddBook(rfid) async {
    http.Response response =
        await _client.post(_totemAddBook, body: {"rfid": rfid});
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "Book already in db") {
        await EasyLoading.showError(json[0]);
      } else {
        await EasyLoading.showSuccess("Book added correctly");
      }
    } else {
      EasyLoading.showError("Error code : ${response.statusCode.toString()}");
    }
  } // Remove book method

  // Remove book check
  static RemoveCheck_b(context) async {
    http.Response response = await _client.get(_bookcheckurl);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var rfid = 0;
      if (json[0] == "not_found") {
        await EasyLoading.showError('Book Not Found');
      } else {
        rfid = json[5];
        await Httpservices.totemRemoveBook(rfid, context);
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

  // Remove book method
  static totemRemoveBook(rfid, context) async {
    http.Response response = await _client.get(_totemRemoveBook);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      await EasyLoading.showSuccess(json[0]);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const TRemoveBook()));
    }
  }
}
