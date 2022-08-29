// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:ims/Web_app/model/customer.dart';
import 'package:ims/Web_app/views/components/profile_widget.dart';
import './../services/http_services.dart';
import 'dart:io';

import 'components/textfield_widget.dart';
import '../data/user_data.dart';


class SettingPage extends StatefulWidget {
  final Customer myCustomer;
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
  
  late Customer customer = widget.myCustomer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("User Settings page")),
        body: Form(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            children: <Widget>[
              ProfileWidget(
                imagePath: customer.imagePath,
                isEdit : true,
                onClicked: () async {},),
                const SizedBox(height : 24),
              TextFieldWidget(
                label: 'First Name',
                text: customer.firstName,
                onChanged: (value) {
                  customer = customer.copy(firstName: value);
                },
              ),
              TextFieldWidget(
                label: ' Last Name',
                text: customer.lastName,
                onChanged: (value) {
                  customer = customer.copy(lastName: value);
                },
              ),
              TextFieldWidget(
                label: 'Username',
                text: customer.userName,
                onChanged: (value) {
                  customer = customer.copy(userName: value);
                },
              ),
              TextFieldWidget(
                label: 'email',
                text: customer.email,
                onChanged: (value) {
                  customer = customer.copy(email: value);
                },
              ),
               TextFieldWidget(
                label: 'Password',
                text: customer.pwd,
                onChanged: (value) {
                  customer = customer.copy(pwd: value);
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
                      UserData.setUser(customer); // to save new customer in the disk
                      await Httpservices.settings_ch(customer ,context);
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("User edited successfully")));
                    })
              ]),
        ),
    );
  }
}
