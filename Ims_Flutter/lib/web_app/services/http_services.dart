// ignore_for_file: import_of_legacy_library_into_null_safe, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// to display loading animation
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ims/web_app/DataLists.dart';
import 'package:ims/web_app/views/Operator/ManageCustomerPage.dart';
import 'package:ims/web_app/views/Operator/ManageItemsPage.dart';
// to route
import '../../routes.dart';
// parameters
import './../views/DashBoard.dart';
import '../views/ItemsList.dart';
import '../views/ListIUsers.dart';

String baseUrl = Myroutes.baseUrl;
String AddCustomerUrl = baseUrl + '/web/AddCustomer/';
String AddCustomerCheckUrl = baseUrl + '/web/AddCustomerCheck/';
String RemoveCustomerUrl = baseUrl + '/web/RemoveCustomer/';
String RemoveBookUrl = baseUrl + '/web/RemoveBook/';
String AddBookUrl = baseUrl + '/web/AddBook/';
String ListCustomersUrl = baseUrl + '/web/ListCustomers/';
String SettingsUrl = baseUrl + '/web/settings/';

class Httpservices {
  static final _client = http.Client();

  static final _loginUrl = Uri.parse(baseUrl + '/web/login');
  static final _registerUrl = Uri.parse(baseUrl + '/web/register');

  static register(
      firstName, lastName, userName, email, password, context) async {
    http.Response response = await _client.post(_registerUrl, body: {
      "firstName": firstName,
      "lastName": lastName,
      "userName": userName,
      "email": email,
      "password": password
    });

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
        TheWebUser.clear();
        TheWebUser.addAll(json);
        TheWebUser[0]['imagePath'] =
            'https://img.icons8.com/ios-filled/50/000000/user-male-circle.png';
        TheWebUser[0]['news'] =
            'He is often considered a "goofy" boss by the employees of Dunder Mifflin. He is often the butt of everybodies jokes. Michael constantly tries to intermix his work life with his social life by inviting employees of Dunder Mifflin to come over house or get coffee';
        TheWebUser[0]['role'] = role;
        await EasyLoading.showSuccess(
            "Welcome dear " + TheWebUser[0]['firstname']);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DashBoard()));
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

  static settings(
      NEWfirstname, NEWlastname, NEWusername, NEWmail, NEWpwd, context) async {
    http.Response response = await _client.post(
        Uri.parse(SettingsUrl +
            TheWebUser[0]['username'] +
            '/' +
            TheWebUser[0]['role']),
        body: {
          "firstname": NEWfirstname,
          "lastname": NEWlastname,
          "username": NEWusername,
          "mail": NEWmail,
          "password": NEWpwd,
        });
    if (response.statusCode == 200) {
      TheWebUser[0]['firstname'] = NEWfirstname;
      TheWebUser[0]['lastname'] = NEWlastname;
      TheWebUser[0]['username'] = NEWusername;
      TheWebUser[0]['mail'] = NEWmail;
      TheWebUser[0]['pwd'] = NEWpwd;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User edited successfully")));
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

  // List Customers
  static WebListCustomers(context) async {
    http.Response response = await _client.get(ListCustomersUrl +
        TheWebUser[0]['admin_id'].toString() +
        '/' +
        TheWebUser[0]['rfid'].toString() +
        '/' +
        TheWebUser[0]['role']);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "not_found") {
        await EasyLoading.showError("There are No Customers");
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
  static webAddCustomerCheck(role, username) async {
    http.Response response = await _client.post(
        AddCustomerCheckUrl +
            TheWebUser[0]['admin_id'] +
            '/' +
            TheWebUser[0]['rfid'] +
            '/' +
            TheWebUser[0]['role'],
        body: {"username": username, "role": role});
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return json[0];
    } else {
      EasyLoading.showError("Error code : ${response.statusCode.toString()}");
    }
  }

  // Add customer method
  static webAddCustomer(
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
        AddCustomerUrl +
            TheWebUser[0]['admin_id'] +
            '/' +
            TheWebUser[0]['rfid'] +
            '/' +
            TheWebUser[0]['role'],
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
  static webRemoveCheck(cst_username, role, BuildContext context) async {
    http.Response response = await _client.post(
        RemoveCustomerUrl +
            TheWebUser[0]['admin_id'] +
            '/' +
            TheWebUser[0]['rfid'] +
            '/' +
            TheWebUser[0]['role'],
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

  // Add book method
  static webAddbook(
      Title, Author, Genre, Publisher, Date, rfid_flag, context) async {
    http.Response response = await _client.post(
        AddBookUrl +
            TheWebUser[0]['admin_id'] +
            '/' +
            TheWebUser[0]['rfid'] +
            '/' +
            TheWebUser[0]['role'],
        body: {
          "Title": Title,
          "Author": Author,
          "Genre": Genre,
          "Publisher": Publisher,
          "Date": Date,
          "rfid_flag": rfid_flag,
        });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "done") {
        await EasyLoading.showSuccess("Book added successfully");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const manageItems()));
      } else {
        await EasyLoading.showError(json[0]);
      }
    } else {
      EasyLoading.showError("Error code : ${response.statusCode.toString()}");
    }
  }

  // Remove book method
  static webRemoveBook(book_title, book_author, rfid_flag, context) async {
    http.Response response = await _client.post(
        RemoveBookUrl +
            TheWebUser[0]['admin_id'] +
            '/' +
            TheWebUser[0]['rfid'] +
            '/' +
            TheWebUser[0]['role'],
        body: {
          "title": book_title,
          "author": book_author,
          "rfid_flag": rfid_flag
        });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "done") {
        await EasyLoading.showSuccess("Book removed successfully");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const manageItems()));
      } else {
        await EasyLoading.showError("The Book is not in the database");
      }
    } else {
      EasyLoading.showError("Error code : ${response.statusCode.toString()}");
    }
  }
}
