// ignore_for_file: import_of_legacy_library_into_null_safe, non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// to display loading animation
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ims/Mobile/MLogin.dart';
import 'package:ims/Mobile/MWelcomePage.dart';
import 'package:ims/Mobile/User/MItemsList.dart';
import 'package:ims/Mobile/User/user_data.dart';
// to route
import '../../../routes.dart';
import 'package:ims/Mobile/User/MHomePage_us.dart';
import 'package:ims/Mobile/User/MRentPage.dart';
import 'package:ims/Mobile/User/MReturnPage.dart';
import '../MHomePage_us.dart';

//import 'package:validator/validator.dart';

//String baseUrlMobile = Myroutes.baseUrlMobile;
String baseUrlMobile = 'http://' + (Myroutes.baseUrlMobile) + ':5000';
//String baseUrlMobile = Myroutes.baseUrl;

class Httpservices {
  static final _client = http.Client();
  static final _totemWelcomeUrl = Uri.parse(baseUrlMobile + '/mobile');
  static final _totemUsrLoginRFIDUrl =
      Uri.parse(baseUrlMobile + '/mobile/UsrLoginRFID');
  static final _MobileUsrLoginCredentialUrl =
      Uri.parse(baseUrlMobile + '/mobile/UsrLoginCredential');
  static final _totemRentUrl =
      Uri.parse(baseUrlMobile + '/mobile/User/RentBook');
  static final _totemReturnUrl =
      Uri.parse(baseUrlMobile + '/mobile/User/ReturnBook');
  static final _bookcheckRenturl =
      Uri.parse(baseUrlMobile + '/mobile/BookCheckRent');
  static final _bookcheckReturnurl =
      Uri.parse(baseUrlMobile + '/mobile/BookCheckReturn');
  static final _urlcheck = Uri.parse(baseUrlMobile + '/mobileurlcheck');

  static mobileurl(context) async {
    http.Response response = await _client.get(_urlcheck);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "111") {
        await EasyLoading.showSuccess("The entered IP is Valid");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MLoginPage()));
      } else {
        await EasyLoading.showSuccess("4444444");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const MWelcome()));
      }
    } else {
      await EasyLoading.showError(
          "URL is not valid === " + response.statusCode.toString());
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MWelcome()));
    }
  }

  // Redirect to Welcome page method
  static totemWelcome(context) async {
    http.Response response = await _client.get(_totemWelcomeUrl);
    if (response.statusCode == 200) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MWelcome()));
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
  static MobileLoginUs(context) async {
    http.Response response = await _client.get(_totemUsrLoginRFIDUrl);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "not_found") {
        await EasyLoading.showError("User not fount");
      } else if (json[0] == "operator") {
        await EasyLoading.showError("Dear Operator, you are not a User");
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
  static MobileLoginCredentialUs(userName, password, context) async {
    http.Response response = await _client.post(_MobileUsrLoginCredentialUrl,
        body: {"userName": userName, "password": password});
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "not found") {
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

  // List the Rented Items
  static List_User_Items(context) async {
    http.Response response = await _client.get(Uri.parse(baseUrlMobile +
        "/mobile/UserItems/" +
        user_buffer.admin_id +
        '/' +
        user_buffer.opr_id +
        '/' +
        user_buffer.rfid));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] != "You don't have any Item") {
        await EasyLoading.showSuccess("You have some Items");
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
            MaterialPageRoute(builder: (context) => const hmpage_us()));
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

  // List ALL Items
  static List_All_Items(context) async {
    http.Response response = await _client.get(
        Uri.parse(baseUrlMobile + "/mobile/AllItems/" + user_buffer.admin_id));
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
