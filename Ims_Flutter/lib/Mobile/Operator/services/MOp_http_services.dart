// ignore_for_file: import_of_legacy_library_into_null_safe, non_constant_identifier_names, file_names, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// to display loading animation
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ims/Mobile/DataLists.dart';
import 'package:ims/Mobile/Operator/MModifyBook.dart';
// to route
import '../../../routes.dart';
import '../../ListIUsers.dart';
import '../../ListItems.dart';
import '../MHomePage_op.dart';
import '../MRemoveCustomer.dart';

String baseUrlMobile = 'http://' + (Myroutes.baseUrlMobile) + ':5000';
String ListCustomers = baseUrlMobile + '/mobile/ListCustomers/';
String AddCustomerCheck = baseUrlMobile + '/mobile/AddCustomerCheck/';
String AddCustomer = baseUrlMobile + '/mobile/AddCustomer/';
String RemoveCustomer = baseUrlMobile + '/mobile/RemoveCustomer/';
String MobileAddBook = baseUrlMobile + '/mobile/AddBook/';
String MobileRmBook = baseUrlMobile + '/mobile/RemoveBook/';

class HttpservicesOP {
  static final _client = http.Client();
  static final _totemOprLoginRFIDUrl =
      Uri.parse(baseUrlMobile + '/mobile/OprLoginRFID');
  static final _MobileOprLoginCredentialUrl =
      Uri.parse(baseUrlMobile + '/mobile/OprLoginCredential');

  // Login with rfid method
  static totemLoginOp(context) async {
    http.Response response = await _client.get(_totemOprLoginRFIDUrl);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "not found") {
        await EasyLoading.showError(json[0]);
      } else {
        TheUser.clear();
        TheUser.addAll(json);
        await EasyLoading.showSuccess(
            "Welcome Back " + TheUser[0]['firstname']);
        await EasyLoading.showSuccess("Welcome dear Operator");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const hmpage_op()));
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

  // Login with credentials method
  static MobileLoginCredentialOp(userName, password, context) async {
    http.Response response = await _client.post(_MobileOprLoginCredentialUrl,
        body: {"userName": userName, "password": password});
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "not found") {
        await EasyLoading.showError(json[0]);
      } else {
        TheUser.clear();
        TheUser.addAll(json);
        await EasyLoading.showSuccess(
            "Welcome Back " + TheUser[0]['firstname']);
        //Navigator.push(context,
        //    MaterialPageRoute(builder: (context) => const hmpage_op()));
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MmodifyBook()));
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

// Settings ************************************************************
  static bool username_valid = true;
  static usrcheck(value, context) async {
    http.Response response = await _client.get(Uri.parse(baseUrlMobile +
        "/mobile/usrcheck/operators/" +
        TheUser[0]['admin_id'].toString() +
        '/' +
        TheUser[0]['username'] +
        '/' +
        value));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json == "ok") {
        username_valid = true;
      } else {
        username_valid = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(json)));
      }
    } else {
      await EasyLoading?.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }

  static settings(
      NEWfirstname, NEWlastname, NEWusername, NEWmail, NEWpwd, context) async {
    http.Response response = await _client.post(
        Uri.parse(baseUrlMobile +
            "/mobile/settings/operators/" +
            TheUser[0]['username']),
        body: {
          "firstname": NEWfirstname,
          "lastname": NEWlastname,
          "username": NEWusername,
          "mail": NEWmail,
          "password": NEWpwd,
        });
    if (response.statusCode == 200) {
      TheUser[0]['firstname'] = NEWfirstname;
      TheUser[0]['lastname'] = NEWlastname;
      TheUser[0]['username'] = NEWusername;
      TheUser[0]['mail'] = NEWmail;
      TheUser[0]['pwd'] = NEWpwd;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User edited successfully")));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const hmpage_op()));
    } else {
      await EasyLoading?.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }
// Settings ************************************************************

  // List Customers
  static MobileListCustomers(context) async {
    http.Response response = await _client.get(Uri.parse(ListCustomers +
        TheUser[0]['admin_id'].toString() +
        '/' +
        TheUser[0]['rfid'].toString()));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "not_found") {
        EasyLoading.showError("There are No Customers");
      } else {
        await EasyLoading.showSuccess("There are some Customers");
        AllUsers.clear();
        AllUsers.addAll(json);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ListUsers()));
      }
    } else {
      EasyLoading.showError("Error code : ${response.statusCode.toString()}");
    }
  }

  // Add customer check
  static totemAddCustomerCheck(username) async {
    http.Response response = await _client.post(
        AddCustomerCheck +
            TheUser[0]['admin_id'].toString() +
            '/' +
            TheUser[0]['rfid'].toString(),
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
    rfid_flag,
    context,
  ) async {
    http.Response response = await _client.post(
        AddCustomer +
            TheUser[0]['admin_id'].toString() +
            '/' +
            TheUser[0]['rfid'].toString(),
        body: {
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "username": username,
          "password": password,
          "rfid_flag": rfid_flag,
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
  static RemoveCheck(cst_username, usrn_rfid, context) async {
    http.Response response = await _client.post(
        RemoveCustomer +
            TheUser[0]['admin_id'].toString() +
            '/' +
            TheUser[0]['rfid'].toString(),
        body: {"cst_username": cst_username, "usrn_rfid": usrn_rfid});
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "no") {
        await EasyLoading.showError('User Not Found');
      } else {
        await EasyLoading.showSuccess('User removed successfully');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const TRemoveCustomer()));
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

  // List ALL Items
  static List_All_Items(context) async {
    http.Response response = await _client.get(Uri.parse(baseUrlMobile +
        "/mobile/AllItems/" +
        TheUser[0]['admin_id'].toString() +
        '/' +
        TheUser[0]['rfid'].toString()));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "The are No items") {
        await EasyLoading.showError(json[0]);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MmodifyBook()));
      } else {
        await EasyLoading.showSuccess("The Items are here");
        AllItems.clear();
        AllItems.addAll(json);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ListItems()));
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

  // Add book method
  static MobileAddbook(Titlee, Author, Genre, Publisher, Date, Loc, Description,
      rfid_flag, context) async {
    http.Response response = await _client.post(
        MobileAddBook +
            TheUser[0]['admin_id'].toString() +
            '/' +
            TheUser[0]['rfid'].toString(),
        body: {
          "Title": Titlee,
          "Author": Author,
          "Genre": Genre,
          "Publisher": Publisher,
          "Date": Date,
          "Loc": Loc,
          "Description": Description,
          "rfid_flag": rfid_flag,
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
  static MobileRemoveBook(book_title, book_author, rfid_flag, context) async {
    http.Response response = await _client.post(
        MobileRmBook +
            TheUser[0]['admin_id'].toString() +
            '/' +
            TheUser[0]['rfid'].toString(),
        body: {
          "title": book_title,
          "author": book_author,
          "rfid_flag": rfid_flag
        });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "done") {
        await EasyLoading.showSuccess("Book removed successfully");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MmodifyBook()));
      } else {
        await EasyLoading.showError("The Book is not in the database");
      }
    } else {
      EasyLoading.showError("Error code : ${response.statusCode.toString()}");
    }
  }
}
