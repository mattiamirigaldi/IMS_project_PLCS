// ignore_for_file: import_of_legacy_library_into_null_safe, non_constant_identifier_names, file_names, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// to display loading animation
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ims/Mobile/Operator/MListItems.dart';
import 'package:ims/Mobile/Operator/MModifyBook.dart';
// to route
import '../../../routes.dart';
import '../MHomePage_op.dart';
import '../MListCustomers.dart';
import '../MRemoveCustomer.dart';
import 'package:ims/Mobile/Operator/opr_data.dart';

String baseUrlMobile = 'http://' + (Myroutes.baseUrlMobile) + ':5000';
String ListCustomers = baseUrlMobile + '/mobile/ListCustomers/';
String AddCustomerCheck = baseUrlMobile + '/mobile/AddCustomerCheck/';
String AddCustomer = baseUrlMobile + '/mobile/AddCustomer/';
String RemoveCustomer = baseUrlMobile + '/mobile/RemoveCustomer/';
String MobileAddBook = baseUrlMobile + '/mobile/AddBook/';
String MobileRmBook = baseUrlMobile + '/mobile/RemoveBook/';

class Httpservices {
  static final _client = http.Client();
  static final _totemOprLoginRFIDUrl =
      Uri.parse(baseUrlMobile + '/mobile/OprLoginRFID');
  static final _MobileOprLoginCredentialUrl =
      Uri.parse(baseUrlMobile + '/mobile/OprLoginCredential');

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
      if (json[0] == "Operator_not_found") {
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
  static MobileLoginCredentialOp(userName, password, context) async {
    http.Response response = await _client.post(_MobileOprLoginCredentialUrl,
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
        await EasyLoading.showSuccess("Welcome Back " + json[5]);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const hmpage_op()));
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

  // List Customers
  static MobileListCustomers(context) async {
    http.Response response = await _client.get(
        Uri.parse(ListCustomers + opr_buffer.adminID + '/' + opr_buffer.rfid));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "not_found") {
        EasyLoading.showError("There are No Customers");
      } else {
        await EasyLoading.showSuccess("You have some Items");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MListCustomers(
                      fname: json[0],
                      lname: json[1],
                      uname: json[2],
                      email: json[3],
                      rfid: json[4],
                    )));
      }
    } else {
      EasyLoading.showError("Error code : ${response.statusCode.toString()}");
    }
  }

  // Add customer check
  static totemAddCustomerCheck(username) async {
    http.Response response = await _client.post(
        AddCustomerCheck + opr_buffer.adminID + '/' + opr_buffer.rfid,
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
    http.Response response = await _client
        .post(AddCustomer + opr_buffer.adminID + '/' + opr_buffer.rfid, body: {
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
        RemoveCustomer + opr_buffer.adminID + '/' + opr_buffer.rfid,
        body: {"cst_username": cst_username, "usrn_rfid": usrn_rfid});
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

  // List ALL Items
  static List_All_Items(context) async {
    http.Response response = await _client.get(
        Uri.parse(baseUrlMobile + "/mobile/AllItems/" + opr_buffer.adminID));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] != "No book in the library") {
        //await EasyLoading.showSuccess("You have some Items");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MItemsList(
                      bookTitle: json[0],
                      bookAuthor: json[1],
                      bookGenre: json[2],
                      bookRFID: json[3],
                      bookAvalible: json[4],
                      bookLocation: json[5],
                    )));
      } else {
        await EasyLoading.showError(json[0]);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MmodifyBook()));
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

  // Add book method
  static MobileAddbook(Title, Author, Genre, Publisher, Date, context) async {
    http.Response response = await _client.post(
        MobileAddBook + opr_buffer.adminID + '/' + opr_buffer.rfid,
        body: {
          "Title": Title,
          "Author": Author,
          "Genre": Genre,
          "Publisher": Publisher,
          "Date": Date,
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
  static MobileRemoveBook(context) async {
    http.Response response = await _client.get(
        Uri.parse(MobileRmBook + opr_buffer.adminID + '/' + opr_buffer.rfid));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "done") {
        await EasyLoading.showSuccess("Book removed successfully");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MmodifyBook()));
      } else {
        await EasyLoading.showError("The Book is not in the database");
      }
    }
  }
}
