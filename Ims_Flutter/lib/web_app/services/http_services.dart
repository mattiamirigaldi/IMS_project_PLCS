// ignore_for_file: import_of_legacy_library_into_null_safe, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// to display loading animation
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ims/web_app/DataLists.dart';
import 'package:ims/web_app/views/Operator/ListItems.dart';
import 'package:ims/web_app/views/Operator/ManageCustomerPage.dart';
import 'package:ims/web_app/views/Operator/ManageItemsPage.dart';
import 'package:ims/web_app/views/SelectListType.dart';
import 'package:ims/web_app/views/Operator/ListUserItems.dart';

// to route
import '../../routes.dart';
// parameters
import './../views/DashBoard.dart';
import '../views/ItemsList.dart';
import '../views/Operator/ListIUsers.dart';

String baseUrl = Myroutes.baseUrl;
String AddCustomerUrl = baseUrl + '/web/AddCustomer/';
String AddCustomerCheckUrl = baseUrl + '/web/AddCustomerCheck/';
String RemoveCustomerUrl = baseUrl + '/web/RemoveCustomer/';
String RemoveBookUrl = baseUrl + '/web/RemoveBook/';
String AddBookUrl = baseUrl + '/web/AddBook/';
String ListCustomersUrl = baseUrl + '/web/ListCustomers/';
String SettingsUrl = baseUrl + '/web/settings/';
String usrcheckUrl = baseUrl + '/web/usrcheck/';
String UserEditUrl = baseUrl + '/web/user_edit/';
String RemoveUserUrl = baseUrl + '/web/RemoveUser/';

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
        if (role == 'admins') {
          http.Response response2 = await _client
              .get(baseUrl + '/web/admins/' + TheWebUser[0]['id'].toString());
          if (response2.statusCode == 200) {
            var json2 = jsonDecode(response2.body);
            if (json2[0] == "not_found") {
              await EasyLoading.showError(json[0]);
            } else {
              AllOperators.clear();
              AllOperators.addAll(json2);
            }
          }
        }
        await EasyLoading.showSuccess(
            "Welcome dear " + TheWebUser[0]['firstname']);
        //Navigator.push(context,
        //    MaterialPageRoute(builder: (context) => const DashBoard()));
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const manageItems()));
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

  static bool username_valid = true;
  static usrcheck(value, context) async {
    http.Response response = await _client.get(Uri.parse(usrcheckUrl +
        TheWebUser[0]['role'] +
        '/' +
        TheWebUser[0]['admin_id'].toString() +
        '/' +
        TheWebUser[0]['username'] +
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

  static user_edit(newFirstName, newLastname, newUsername, oldUsername, newMail,
      newPwd, newRfid, userRole, context) async {
    http.Response response = await _client.post(
        Uri.parse(UserEditUrl +
            TheWebUser[0]['username'] +
            '/' +
            TheWebUser[0]['role']),
        body: {
          "firstname": newFirstName,
          "lastname": newLastname,
          "username": newUsername,
          "oldUsername": oldUsername,
          "mail": newMail,
          "password": newPwd,
          "rfid": newRfid,
          "userRole": userRole,
        });
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User edited successfully")));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const ListUsers()));
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

  static List_Items_admin(opr_id, context) async {
    http.Response response = await _client.get(Uri.parse(baseUrl +
        "/web/items/" +
        TheWebUser[0]['id'].toString() +
        '/' +
        opr_id));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "not_found") {
        AllItems.clear();
        await EasyLoading.showError(
            "There are No Ietms for the selected branch");
      } else {
        AllItems.clear();
        AllItems.addAll(json);
        await EasyLoading.showSuccess(AllItems[0]['title']);
      }
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SelectListType()));
    } else {
      await EasyLoading?.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }

  static List_Items(context) async {
    http.Response response = await _client.get(Uri.parse(baseUrl +
        "/web/items/" +
        TheWebUser[0]['admin_id'].toString() +
        '/' +
        TheWebUser[0]['id'].toString()));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      AllItems.clear();
      AllItems.addAll(json);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const ListItems()));
    } else {
      await EasyLoading?.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }

  // List Customers
  static WebListCustomers(rl, context) async {
    http.Response response = await _client.post(
        ListCustomersUrl +
            TheWebUser[0]['admin_id'].toString() +
            '/' +
            TheWebUser[0]['rfid'].toString() +
            '/' +
            TheWebUser[0]['role'],
        body: {"rl": rl});
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
            TheWebUser[0]['admin_id'].toString() +
            '/' +
            TheWebUser[0]['rfid'].toString() +
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
            TheWebUser[0]['admin_id'].toString() +
            '/' +
            TheWebUser[0]['rfid'].toString() +
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
            TheWebUser[0]['admin_id'].toString() +
            '/' +
            TheWebUser[0]['rfid'].toString() +
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

// Remove user
  static webRemoveUser(oldUsername, userRole, BuildContext context) async {
    http.Response response = await _client.post(
        RemoveUserUrl +
            TheWebUser[0]['admin_id'].toString() +
            '/' +
            TheWebUser[0]['rfid'].toString() +
            '/' +
            TheWebUser[0]['role'],
        body: {"username": oldUsername, "role": userRole});
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "no") {
        await EasyLoading.showError('User Not Found');
      } else {
        await EasyLoading.showSuccess('User removed successfully');
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ListUsers()));
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

// List the Rented Items
  static List_User_Items(context) async {
    http.Response response = await _client.get(Uri.parse(baseUrl +
        "/web/UserItems/" +
        TheWebUser[0]['admin_id'].toString() +
        '/' +
        TheWebUser[0]['opr_id'].toString() +
        '/' +
        TheWebUser[0]['rfid'].toString()));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "You don't have any Items") {
        await EasyLoading.showError(json[0]);
      } else {
        await EasyLoading.showSuccess("You have some Items");
        AllItems.clear();
        AllItems.addAll(json);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ListUserItems()));
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
            TheWebUser[0]['admin_id'].toString() +
            '/' +
            TheWebUser[0]['rfid'].toString() +
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
            TheWebUser[0]['admin_id'].toString() +
            '/' +
            TheWebUser[0]['rfid'].toString() +
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
