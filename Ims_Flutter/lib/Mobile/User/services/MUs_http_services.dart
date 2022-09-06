// ignore_for_file: import_of_legacy_library_into_null_safe, non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// to display loading animation
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ims/Mobile/DataLists.dart';
import 'package:ims/Mobile/MLogin.dart';
import 'package:ims/Mobile/MWelcomePage.dart';
import 'package:ims/Mobile/User/MItemsList.dart';
import 'package:ims/Mobile/User/user_data.dart';
import 'package:ims/web_app/data/user_data.dart';
import 'package:ims/web_app/views/ItemsList.dart';
// to route
import '../../../routes.dart';
import 'package:ims/Mobile/User/MHomePage_us.dart';
import 'package:ims/Mobile/User/MRentPage.dart';
import 'package:ims/Mobile/User/MReturnPage.dart';
import '../../ListItems.dart';
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
  static MobileWelcome(context) async {
    http.Response response = await _client.get(_totemWelcomeUrl);
    if (response.statusCode == 200) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MWelcome()));
    }
  }

  // Login with rfid method
  static MobileLoginUs(context) async {
    http.Response response = await _client.get(_totemUsrLoginRFIDUrl);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "not found") {
        await EasyLoading.showError("User not fount");
      } else {
        TheUser.clear();
        TheUser.addAll(json);
        await EasyLoading.showSuccess(
            "Welcome Back " + TheUser[0]['firstname']);
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
        TheUser.clear();
        TheUser.addAll(json);
        await EasyLoading.showSuccess(
            "Welcome Back " + TheUser[0]['firstname']);
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
        TheUser[0]['admin_id'].toString() +
        '/' +
        TheUser[0]['opr_id'].toString() +
        '/' +
        TheUser[0]['rfid'].toString()));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "You don't have any Item") {
        await EasyLoading.showError(json[0]);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const hmpage_us()));
      } else {
        await EasyLoading.showSuccess("You have some Items");
        AllItems.clear();
        AllItems.addAll(json);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ListItems()));
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
        TheUser[0]['opr_id'].toString()));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "The are No items") {
        await EasyLoading.showError(json[0]);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const hmpage_us()));
      } else {
        await EasyLoading.showSuccess("The Items are here");
        AllItems.clear();
        AllItems.addAll(json);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ListItems()));
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

  static bool username_valid = true;

  static usrcheck(value, context) async {
    http.Response response = await _client.get(Uri.parse(baseUrlMobile +
        "/mobile/usrcheck/customers/" +
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
            "/mobile/settings/customers/" +
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
          context, MaterialPageRoute(builder: (context) => const hmpage_us()));
    } else {
      await EasyLoading?.showError(
          "Error Code : ${response.statusCode.toString()}");
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
