// ignore_for_file: import_of_legacy_library_into_null_safe, non_constant_identifier_names, file_names, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// to display loading animation
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ims/Totem/Operator/TModifyCustomer.dart';
import 'package:ims/Totem/Operator/opr_data.dart';
// to route
import '../../../routes.dart';
import '../THomePage_op.dart';
import '../TModifyBook.dart';

String baseUrl = Myroutes.baseUrl;
String totemAddCstChk = baseUrl + '/totem/Operator/AddCustomerCheck/';
String totemAddCst = baseUrl + '/totem/Operator/AddCustomer/';
String totemAddBookUrl = baseUrl + '/totem/Operator/AddBook/';
String totemRemoveBookUrl = baseUrl + '/totem/Operator/RemoveBook/';
String totemRemoveCst = baseUrl + '/totem/Operator/RemoveCustomer/';

class Httpservices {
  static final _client = http.Client();
  static final _totemOprLoginRFIDUrl =
      Uri.parse(baseUrl + '/totem/OprLoginRFID');
  static final _totemOprLoginCredentialUrl =
      Uri.parse(baseUrl + '/totem/OprLoginCredential');

  static final opr_buffer = opr_data(
      mail: '',
      username: '',
      lastname: '',
      firstname: '',
      rfid: '',
      adminID: '');

  // Login with rfid method
  static totemLoginOp(context) async {
    http.Response response = await _client.get(_totemOprLoginRFIDUrl);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "Operator not found") {
        await EasyLoading.showError(json[0]);
      } else {
        opr_buffer.firstname = json[1];
        opr_buffer.lastname = json[2];
        opr_buffer.username = json[3];
        opr_buffer.mail = json[4];
        opr_buffer.rfid = json[5];
        opr_buffer.adminID = json[6];
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
        opr_buffer.firstname = json[1];
        opr_buffer.lastname = json[2];
        opr_buffer.username = json[3];
        opr_buffer.mail = json[4];
        opr_buffer.rfid = json[5];
        opr_buffer.adminID = json[6];
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
    http.Response response = await _client.post(
        totemAddCstChk + opr_buffer.adminID + '/' + opr_buffer.rfid,
        body: {"username": username});
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
    http.Response response = await _client
        .post(totemAddCst + opr_buffer.adminID + '/' + opr_buffer.rfid, body: {
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
            MaterialPageRoute(builder: (context) => const TmodifyCustomer()));
      } else {
        await EasyLoading.showError(json[0]);
      }
    } else {
      EasyLoading.showError("Error code : ${response.statusCode.toString()}");
    }
  }

  // Remove customer
  static totemRemoveCustomer(context) async {
    http.Response response = await _client
        .get(totemRemoveCst + opr_buffer.adminID + '/' + opr_buffer.rfid);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "no") {
        await EasyLoading.showError('User Not Found');
      } else {
        await EasyLoading.showSuccess('User removed successfully');
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const TmodifyCustomer()));
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

  // Add book method
  static totemAddbook(
      Title, Author, Genre, Publisher, Date, Description, context) async {
    http.Response response = await _client.post(
        totemAddBookUrl + opr_buffer.adminID + '/' + opr_buffer.rfid,
        body: {
          "Title": Title,
          "Author": Author,
          "Genre": Genre,
          "Publisher": Publisher,
          "Date": Date,
          "Description": Description,
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
    http.Response response = await _client
        .get(totemRemoveBookUrl + opr_buffer.adminID + '/' + opr_buffer.rfid);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "done") {
        await EasyLoading.showSuccess("Book removed successfully");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const TmodifyBook()));
      } else {
        await EasyLoading.showError("The Book is not in the database");
      }
    }
  }
}
