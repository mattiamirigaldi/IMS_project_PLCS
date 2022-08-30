// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:ims/Web_app/model/user.dart';
import 'package:ims/Web_app/views/components/profile_widget.dart';
import './../services/http_services.dart';
import 'dart:io';

import 'components/textfield_widget.dart';
import '../data/user_data.dart';


class SettingPage extends StatefulWidget {
  final User myCustomer;
  const SettingPage({
      Key? key,
      required this.myCustomer,
  }) : super(key: key);
  //NOTE : in a dart if an identifier start with '_' then it is private to its library
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage>{
  final _formKey = GlobalKey<FormState>();
  
  late User user = widget.myCustomer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("User Settings page")),
        body: Form(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            children: <Widget>[
              ProfileWidget(
                imagePath: user.imagePath,
                isEdit : true,
                onClicked: () async {},),
                const SizedBox(height : 24),
              TextFieldWidget(
                label: 'First Name',
                text: user.firstName,
                onChanged: (value) {
                  user = user.copy(firstName: value);
                },
              ),
              TextFieldWidget(
                label: ' Last Name',
                text: user.lastName,
                onChanged: (value) {
                  user = user.copy(lastName: value);
                },
              ),
              TextFieldWidget(
                label: 'Username',
                text: user.userName,
                onChanged: (value) {
                  user = user.copy(userName: value);
                },
              ),
              TextFieldWidget(
                label: 'email',
                text: user.email,
                onChanged: (value) {
                  user = user.copy(email: value);
                },
              ),
               TextFieldWidget(
                label: 'Password',
                text: user.pwd,
                onChanged: (value) {
                  user = user.copy(pwd: value);
                },
              ),
                InkWell(
                    child: Container(
                      margin:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: const Center(
                          child: Text("Save",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))),
                      height: 50,
                      width: 500,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue),
                    ),
                    onTap: () async {
                      UserData.setUser(user); // to save new customer in the disk
                      await Httpservices.settings_ch(user ,context);
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("User edited successfully")));
                    })
              ]),
        ),
    );
  }
}
