// ignore_for_file: import_of_legacy_library_into_null_safe, non_constant_identifier_names, file_names, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// to display loading animation
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ims/Mobile/Operator/MRemoveBook.dart';
// to route
import '../../../routes.dart';
import '../MHomePage_op.dart';
import '../MRemoveCustomer.dart';

String baseUrl = Myroutes.baseUrl;

class Httpservices {
  static final _client = http.Client();
  static final _totemOprLoginRFIDUrl =
      Uri.parse(baseUrl + '/mobile/OprLoginRFID');
  static final _totemOprLoginCredentialUrl =
      Uri.parse(baseUrl + '/mobile/OprLoginCredential');
  //static final _bookcheckurl = Uri.parse(baseUrl + '/mobile/BookCheck');
  static final _totemAddCustomer =
      Uri.parse(baseUrl + '/mobile/Operator/AddCustomer');
  static final _totemAddCustomerCheck =
      Uri.parse(baseUrl + '/mobile/Operator/AddCustomerCheck');
  static final _totemRemoveCustomer =
      Uri.parse(baseUrl + '/mobile/Operator/RemoveCustomer');
  static final _totemAddBook = Uri.parse(baseUrl + '/mobile/Operator/AddBook');
  static final _totemRemoveBook =
      Uri.parse(baseUrl + '/mobile/Operator/RemoveBook');

  // Login with rfid method
  static totemLoginOp(context) async {
    http.Response response = await _client.get(_totemOprLoginRFIDUrl);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "Operator_not_found") {
        await EasyLoading.showError(json[0]);
      } else {
        await EasyLoading.showSuccess("Welcome dear Operator");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const hmpage_op()));
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

  // Login with credentials method
  static totemLoginCredentialOp(userName, password, context) async {
    http.Response response = await _client.post(_totemOprLoginCredentialUrl,
        body: {"userName": userName, "password": password});
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "not_found") {
        await EasyLoading.showError(json[0]);
      } else {
        await EasyLoading.showSuccess("Welcome Back " + json[1]);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const hmpage_op()));
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

  // Add customer check
  static totemAddCustomerCheck(username) async {
    http.Response response = await _client
        .post(_totemAddCustomerCheck, body: {"username": username});
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return json[0];
    } else {
      EasyLoading.showError("Error code : ${response.statusCode.toString()}");
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

  // Remove customer
  static RemoveCheck(context) async {
    http.Response response = await _client.get(_totemRemoveCustomer);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "no") {
        await EasyLoading.showError('User Not Found');
      } else {
        await EasyLoading.showSuccess('User removed successfully');
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const TRemoveCustomer()));
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

  // Add book method
  static totemAddbook(Title, Author, Genre, Location, context) async {
    http.Response response = await _client.post(_totemAddBook, body: {
      "Title": Title,
      "Author": Author,
      "Genre": Genre,
      "Location": Location,
    });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "done") {
        await EasyLoading.showSuccess("Book added successfully");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const hmpage_op()));
      } else {
        await EasyLoading.showError(json[0]);
      }
    } else {
      EasyLoading.showError("Error code : ${response.statusCode.toString()}");
    }
  }

  // Remove book method
  static totemRemoveBook(context) async {
    http.Response response = await _client.get(_totemRemoveBook);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "Done") {
        await EasyLoading.showSuccess("Book removed successfully");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const TRemoveBook()));
      } else {
        await EasyLoading.showError("The Book is not in the database");
      }
    }
  }
}
