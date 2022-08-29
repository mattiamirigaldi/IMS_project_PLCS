// Date associated to the profile logged in

import 'dart:convert';
// ignore_for_file: camel_case_types

import 'package:ims/Web_app/model/customer.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Data are persisted locally on the device using the package shared preferences

class UserData {
  static late SharedPreferences _preferences;
  static const _keyUser = 'user';
  static const myCustomer = Customer(
    imagePath:
        "https://img.icons8.com/ios-filled/50/000000/user-male-circle.png",
    firstName: 'Micheal',
    lastName: 'Scott',
    userName: 'mattiamiri',
    email: 'michealscott@gmail.com',
    news:
        'He is often considered a "goofy" boss by the employees of Dunder Mifflin. He is often the butt of everybodies jokes. Michael constantly tries to intermix his work life with his social life by inviting employees of Dunder Mifflin to come over house or get coffee',
  pwd : "123"
  );

  // method to get at initalization the user locally stored in the device
  static Future init() async => 
  _preferences = await SharedPreferences.getInstance();

  // method to have new user in disk
  static Future setUser(Customer user) async {
    final json = jsonEncode(user.toJson());
    await _preferences.setString(_keyUser, json);
  }

  static Customer getCustomer(){
    final json = _preferences.getString(_keyUser);
    return json == null ? myCustomer :  Customer.fromJson(jsonDecode(json));
  }
  

  
}


