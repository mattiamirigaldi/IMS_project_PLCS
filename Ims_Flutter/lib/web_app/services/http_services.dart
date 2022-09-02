// ignore_for_file: import_of_legacy_library_into_null_safe, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// to display loading animation
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ims/web_app/views/Operator/ManageCustomerPage.dart';
// to route
import '../../routes.dart';
// parameters
import 'package:ims/web_app/model/user.dart';
import './../views/DashBoard.dart';
import '../views/ItemsList.dart';

String baseUrl = Myroutes.baseUrl;
String AddCustomer = baseUrl + '/Web/AddCustomer';
String AddCustomerCheck = baseUrl + '/Web/AddCustomerCheck';
String RemoveCustomer = baseUrl + '/Web/RemoveCustomer';

class Httpservices {
  static final _client = http.Client();

  static final _loginUrl = Uri.parse(baseUrl + '/login');
  static final _registerUrl = Uri.parse(baseUrl + '/register');
//  static final AddCustomer = Uri.parse(baseUrl + '/Web/AddCustomer');
//  static final AddCustomerCheck = Uri.parse(baseUrl + '/Web/AddCustomerCheck');
//  static final RemoveCustomer =
//      Uri.parse(baseUrl + '/Web/Operator/RemoveCustomer');
  static final _addBook = Uri.parse(baseUrl + '/totem/Operator/AddBook');
  static final _removeBook = Uri.parse(baseUrl + '/Web/Operator/RemoveBook');

  static var user_buffer = User(
      mail: '',
      username: '',
      lastname: '',
      firstname: '',
      rfid: '',
      admin_id: '',
      opr_id: '',
      imagePath:
          'https://img.icons8.com/ios-filled/50/000000/user-male-circle.png',
      news:
          'He is often considered a "goofy" boss by the employees of Dunder Mifflin. He is often the butt of everybodies jokes. Michael constantly tries to intermix his work life with his social life by inviting employees of Dunder Mifflin to come over house or get coffee',
      pwd: '',
      role: "");

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
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const DashBoard()));
      }
    } else {
      await EasyLoading?.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }

  static login(username, password, role, context) async {
    http.Response response = await _client.post(_loginUrl,
        body: {"userName": username, "password": password, "role": role});
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "not_found") {
        await EasyLoading.showError(json[0]);
      } else {
        await EasyLoading.showSuccess("Welcome Back " + username);
        if (role == "operators") {
          user_buffer.firstname = json[1];
          user_buffer.lastname = json[2];
          user_buffer.username = json[3];
          user_buffer.mail = json[4];
          user_buffer.pwd = json[5];
          user_buffer.rfid = json[6];
          user_buffer.opr_id = json[6];
          user_buffer.admin_id = json[7];
          user_buffer.role = "opr";
        } else if (role == "admins") {
          user_buffer.firstname = json[1];
          user_buffer.lastname = json[2];
          user_buffer.username = json[3];
          user_buffer.mail = json[4];
          user_buffer.pwd = json[5];
          user_buffer.rfid = json[6];
          user_buffer.admin_id = json[6];
          user_buffer.role = "adm";
        } else if (role == "customers") {
          user_buffer.firstname = json[1];
          user_buffer.lastname = json[2];
          user_buffer.username = json[3];
          user_buffer.mail = json[4];
          user_buffer.pwd = json[5];
          user_buffer.rfid = json[6];
          user_buffer.opr_id = json[7];
          user_buffer.admin_id = json[8];
          user_buffer.role = "cus";
        }
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DashBoard()));
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

  static settings_ch(
      NEWfirstname, NEWlastname, NEWusername, NEWmail, NEWpwd, context) async {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User edited successfully")));
    await EasyLoading.showSuccess("Welcome Back " + NEWfirstname);
    http.Response response = await _client.post(
        Uri.parse(baseUrl + "/settings_ch/" + user_buffer.username),
        body: {
          "firstname": NEWfirstname,
          "lastname": NEWlastname,
          "username": NEWusername,
          "mail": NEWmail,
          "password": NEWpwd,
        });
    if (response.statusCode == 200) {
      //var json = jsonDecode(response.body);
      user_buffer.firstname = NEWfirstname;
      user_buffer.lastname = NEWlastname;
      user_buffer.username = NEWusername;
      user_buffer.mail = NEWmail;
      user_buffer.pwd = NEWpwd;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const DashBoard()));
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
  static totemAddCustomerCheck(role, username) async {
    http.Response response = await _client.post(
        AddCustomerCheck +
            '/' +
            user_buffer.admin_id +
            '/' +
            user_buffer.rfid +
            '/' +
            user_buffer.role,
        body: {"username": username, "role": role});
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
    rfid_flag,
    role,
    context,
  ) async {
    http.Response response = await _client.post(
        AddCustomer +
            '/' +
            user_buffer.admin_id +
            '/' +
            user_buffer.rfid +
            '/' +
            user_buffer.role,
        body: {
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "username": username,
          "password": password,
          "rfid_flag": rfid_flag,
          "role": role,
        });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "new User added to the database successfully") {
        await EasyLoading.showSuccess(json[0]);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const manageCustomer()));
      } else {
        await EasyLoading.showError(json[0]);
      }
    } else {
      EasyLoading.showError("Error code : ${response.statusCode.toString()}");
    }
  }

  // Remove customer
  static RemoveCheck(cst_username, role, BuildContext context) async {
    http.Response response = await _client.post(
        RemoveCustomer +
            '/' +
            user_buffer.admin_id +
            '/' +
            user_buffer.rfid +
            '/' +
            user_buffer.role,
        body: {"cst_username": cst_username, "role": role});
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "no") {
        await EasyLoading.showError('User Not Found');
      } else {
        await EasyLoading.showSuccess('User removed successfully');
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const manageCustomer()));
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
            MaterialPageRoute(builder: (context) => const DashBoard()));
      } else {
        await EasyLoading.showError(json[0]);
      }
    } else {
      EasyLoading.showError("Error code : ${response.statusCode.toString()}");
    }
  }

  // Remove item method
  static removeItem(context) async {
    http.Response response = await _client.get(_removeBook);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "done") {
        await EasyLoading.showSuccess("Book removed successfully");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const DashBoard()));
      } else {
        await EasyLoading.showError("The Book is not in the database");
      }
    }
  }
}
