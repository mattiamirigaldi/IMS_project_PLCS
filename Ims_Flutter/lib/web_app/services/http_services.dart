// ignore_for_file: import_of_legacy_library_into_null_safe, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// to display loading animation
import 'package:flutter_easyloading/flutter_easyloading.dart';
// to route
import '../../routes.dart';
// parameters
import '../model/customer.dart';
import 'package:ims/Web_app/data/user_data.dart';
import './../views/DashBoard.dart';
import 'package:ims/Web_app/views/UserSettings.dart';
import '../views/ItemsList.dart';

String baseUrl = Myroutes.baseUrl;

class Httpservices {
  static final _client = http.Client();
  static final _loginUrl = Uri.parse(baseUrl + '/login');
  static final _registerUrl = Uri.parse(baseUrl + '/register');

  static register(
      firstName, lastName, userName, email, password, context) async {
    http.Response response = await _client.post(_registerUrl, body: {
      "firstName": firstName,
      "lastName": lastName,
      "userName": userName,
      "email": email,
      "password": password
    });
    //Customer myCustomer
    // myCustomer.userName = userName;
    // myCustomer.name = json[0];
    // myCustomer.email = json[1];
    // myCustomer.imagePath = json[2];
    // myCustomer.news = json[3];

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == 'user already exist') {
        await EasyLoading.showError(json[0]);
      } else {
        await EasyLoading.showSuccess(json[0]);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DashBoard(customer: user_data.myCustomer)));
      }
    } else {
      await EasyLoading?.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }

  static login(userName, password, context) async {
    //Customer myCustomer = user_data.myCustomer;
    http.Response response = await _client
        .post(_loginUrl, body: {"userName": userName, "password": password});
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == 'user not registered') {
        await EasyLoading.showError(json[0]);
      } else {
        await EasyLoading.showSuccess("Welcome Back " + userName);
        var json = jsonDecode(response.body);
        // myCustomer.userName = userName;
        // myCustomer.name = json[0];
        // myCustomer.email = json[1];
        // myCustomer.imagePath = json[2];
        // myCustomer.news = json[3];

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DashBoard(
                      customer: user_data.myCustomer,
                    )));
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

  static settings(userName, context) async {
    http.Response response = await _client.post(
        Uri.parse(baseUrl + "/settings/" + userName),
        body: {"userName": userName});
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SettingPage(
                    myFirstName: json[0],
                    myLastName: json[1],
                    myUserName: json[2],
                    myEmail: json[3],
                    myPwd: json[4],
                  )));
    } else {
      await EasyLoading?.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }

  static settings_ch(myUserName, firstName, lastName, userName, email, password,
      context) async {
    http.Response response = await _client
        .post(Uri.parse(baseUrl + "settings_ch/" + myUserName), body: {
      "firstName": firstName,
      "lastName": lastName,
      "userName": userName,
      "email": email,
      "password": password
    });
    //Customer myCustomer = user_data.myCustomer;
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      // myCustomer.userName = userName;
      // myCustomer.name = json[0];
      // myCustomer.email = json[1];
      // myCustomer.imagePath = json[2];
      // myCustomer.news = json[3];
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DashBoard(customer: user_data.myCustomer)));
    } else {
      await EasyLoading?.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }

  static items(context) async {
    http.Response response =
        await _client.get(Uri.parse(baseUrl + "/web/items"));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ItemsList(
                    bookTitle: json[0],
                    bookAuthor: json[1],
                    bookGenre: json[2],
                    bookRFID: json[3],
                    bookAvalible: json[4],
                    bookLocation: json[5],
                  )));
    } else {
      await EasyLoading?.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }
}
