// ignore_for_file: import_of_legacy_library_into_null_safe, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// to display loading animation
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ims/Web_app/views/Operator/RemoveItemPage.dart';
// to route
import '../../routes.dart';
// parameters
import 'package:ims/Web_app/model/user.dart';
import 'package:ims/Web_app/data/user_data.dart';
import './../views/DashBoard.dart';
import 'package:ims/Web_app/views/UserSettings.dart';
import '../views/ItemsList.dart';

String baseUrl = Myroutes.baseUrl;

class Httpservices {
  static final _client = http.Client();

  static final _loginUrl = 
      Uri.parse(baseUrl + '/login');
  static final _registerUrl = 
      Uri.parse(baseUrl + '/register');
  static final _addCustomer =
      Uri.parse(baseUrl + '/Web/Operator/AddCustomer');
  static final _addCustomerCheck =
      Uri.parse(baseUrl + '/Web/Operator/AddCustomerCheck');
  static final _removeCustomer =
      Uri.parse(baseUrl + '/Web/Operator/RemoveCustomer');
  static final _addBook = 
      Uri.parse(baseUrl + '/totem/Operator/AddBook');
  static final _removeBook =
      Uri.parse(baseUrl + '/Web/Operator/RemoveBook');

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
                    DashBoard(user: UserData.myCustomer)));
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
        // myCustomer.userName = userName;
        // myCustomer.name = json[0];
        // myCustomer.email = json[1];
        // myCustomer.imagePath = json[2];
        // myCustomer.news = json[3];

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DashBoard(
                      user: UserData.getUser(),
                    )));
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

  // static settings(userName, context) async {

  //   http.Response response = await _client.post(
  //       Uri.parse(baseUrl + "/settings/" + userName),
  //       body: {"userName": userName});
  //   if (response.statusCode == 200) {
  //     var json = jsonDecode(response.body);
  //         User myCustomer(email :  )
      
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => SettingPage(
  //                   myFirstName: json[0],
  //                   myLastName: json[1],
  //                   myUserName: json[2],
  //                   myEmail: json[3],
  //                   myPwd: json[4],
  //                 )));
  //   } else {
  //     await EasyLoading?.showError(
  //         "Error Code : ${response.statusCode.toString()}");
  //   }
  // }

  static settings_ch(User myCustomer,context) async {
    http.Response response = await _client
        .post(Uri.parse(baseUrl + "settings_ch/" + myCustomer.userName), body: {
      "firstName": myCustomer.firstName,
      "lastName": myCustomer.lastName,
      "userName": myCustomer.userName,
      "email": myCustomer.email,
      "password": myCustomer.pwd,
    });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      Navigator.push(
          context,
          MaterialPageRoute(
             builder: (context) => DashBoard(user: UserData.myCustomer)));
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


  // Add customer check
  static addCustomerCheck(username) async {
    http.Response response = await _client
        .post(_addCustomerCheck, body: {"username": username});
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return json[0];
    } else {
      EasyLoading.showError("Error code : ${response.statusCode.toString()}");
    }
  }


  // Add customer method
  static addCustomer(
    firstName,
    lastName,
    username,
    email,
    password,
    context,
  ) async {
    await EasyLoading.showSuccess("entered in http services");
    http.Response response = await _client.post(_addCustomer, body: {
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
            MaterialPageRoute(builder: (context) => const DashBoard(user: UserData.myCustomer)));
      } else {
        await EasyLoading.showError(json[0]);
      }
    } else {
      EasyLoading.showError("Error code : ${response.statusCode.toString()}");
    }
  }


// Remove customer
  static removeCheck(cst_username, usrn_rfid, context) async {
    http.Response response = await _client.post(
        _removeCustomer, body: {"cst_username": cst_username, "usrn_rfid": usrn_rfid});
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "no") {
        await EasyLoading.showError('User Not Found');
      } else {
        await EasyLoading.showSuccess('User removed successfully');
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const DashBoard(user: UserData.myCustomer)));
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }


  // Add item method
  static addItem(
      Title, Author, Genre, Publisher, Date, Description, context) async {
    http.Response response = await _client.post(_addBook, body: {
      "Title": Title,
      "Author": Author,
      "Genre": Genre,
      "Publisher": Publisher,
      "Date": Date,
      "Description": Description,
      "rfid_flag": "yes"
    });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "done") {
        await EasyLoading.showSuccess("Book added successfully");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DashBoard(user: UserData.myCustomer)));
      } else {
        await EasyLoading.showError(json[0]);
      }
    } else {
      EasyLoading.showError("Error code : ${response.statusCode.toString()}");
    }
  }


  // Remove item method
  static removeItem(item_title, item_author, rfid_flag, context) async {
    http.Response response = await _client
        .post(_removeBook, body: {
      "title": item_title,
      "author": item_author,
      "rfid_flag": rfid_flag
    });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "done") {
        await EasyLoading.showSuccess("Item removed successfully");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const DashBoard(user: UserData.myCustomer)));
      } else {
        await EasyLoading.showError("The item is not in the database");
      }
    } else {
      EasyLoading.showError("Error code : ${response.statusCode.toString()}");
    }
  }

}