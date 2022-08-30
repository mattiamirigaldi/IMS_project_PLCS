// ignore_for_file: import_of_legacy_library_into_null_safe, non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// to display loading animation
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ims/Totem/TWelcomePage.dart';
import 'package:ims/Totem/User/user_data.dart';
// to route
import '../../../routes.dart';
import 'package:ims/Totem/User/THomePage_us.dart';
import 'package:ims/Totem/User/TRentPage.dart';
import 'package:ims/Totem/User/TReturnPage.dart';
import '../THomePage_us.dart';

String baseUrl = Myroutes.baseUrl;
String totemBookRent = baseUrl + "/totem/BookRent/";
String totemBookReturn = baseUrl + "/totem/BookReturn/";

class Httpservices {
  static final _client = http.Client();
  static final _totemWelcomeUrl = Uri.parse(baseUrl + '/totem');
  static final _totemUsrLoginRFIDUrl =
      Uri.parse(baseUrl + '/totem/UsrLoginRFID');
  static final _totemUsrLoginCredentialUrl =
      Uri.parse(baseUrl + '/totem/UsrLoginCredential');

  // Redirect to Welcome page method
  static totemWelcome(context) async {
    http.Response response = await _client.get(_totemWelcomeUrl);
    if (response.statusCode == 200) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const TWelcome()));
    }
  }

  static final user_buffer = user_data(
      mail: '',
      username: '',
      lastname: '',
      firstname: '',
      rfid: '',
      admin_id: '',
      opr_id: '');
  // Login with rfid method
  static totemLoginUs(context) async {
    http.Response response = await _client.get(_totemUsrLoginRFIDUrl);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "not_found") {
        await EasyLoading.showError("User not found");
      } else {
        user_buffer.firstname = json[1];
        user_buffer.lastname = json[2];
        user_buffer.username = json[3];
        user_buffer.mail = json[4];
        user_buffer.rfid = json[5];
        user_buffer.admin_id = json[6];
        user_buffer.opr_id = json[7];
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
      if (json[0] == 'not found') {
        await EasyLoading.showError(json[0]);
      } else {
        user_buffer.firstname = json[1];
        user_buffer.lastname = json[2];
        user_buffer.username = json[3];
        user_buffer.mail = json[4];
        user_buffer.rfid = json[5];
        user_buffer.admin_id = json[6];
        user_buffer.opr_id = json[7];
        await EasyLoading.showSuccess("Welcome Back " + json[1]);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const hmpage_us()));
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

  // book Rent
  static Book_rent(context) async {
    http.Response response = await _client.get(Uri.parse(totemBookRent +
        user_buffer.admin_id +
        '/' +
        user_buffer.opr_id +
        '/' +
        user_buffer.rfid));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "The Item is not in the Database") {
        await EasyLoading.showError(json[0]);
      } else if (json[0] == "Book not available, it's already rented") {
        await EasyLoading.showError(json[0]);
      } else {
        await EasyLoading.showSuccess(json[0]);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const TRentPage()));
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

  // book Return
  static Book_return(context) async {
    http.Response response = await _client.get(Uri.parse(totemBookReturn +
        user_buffer.admin_id +
        '/' +
        user_buffer.opr_id +
        '/' +
        user_buffer.rfid));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "Book Not found") {
        await EasyLoading.showError(json[0]);
      } else {
        await EasyLoading.showSuccess(json[0]);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const TReturnPage()));
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }
}
