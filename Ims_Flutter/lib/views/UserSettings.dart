// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import './../services/http_services.dart';

class SettingPage extends StatelessWidget {
  SettingPage(
      {Key? key,
      required this.myFirstName,
      required this.myLastName,
      required this.myEmail,
      required this.myPwd,
      required this.myUserName})
      : super(key: key);

  String myUserName;
  String myFirstName;
  String myLastName;
  String myEmail;
  String myPwd;

  late String email = myEmail;
  late String firstName = myFirstName;
  late String lastName = myLastName;
  late String userName = myUserName;
  late String password = myPwd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("User Settings page")),
        body: Form(
          child: ListView(children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Center(
                child: Text(
                  "Modify your data",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 11, 212, 145)),
                  textAlign: TextAlign.center,
                  textScaleFactor: 2,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                initialValue: myFirstName,
                decoration: const InputDecoration(
                  hintText: "Enter your first name",
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  firstName = value;
                },
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                initialValue: myLastName,
                decoration: const InputDecoration(
                  hintText: "Enter your last name",
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  lastName = value;
                },
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                initialValue: myUserName,
                decoration: const InputDecoration(
                    hintText: "Enter your username",
                    labelText: 'Username',
                    border: OutlineInputBorder()),
                onChanged: (value) {
                  userName = value;
                },
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                initialValue: myEmail,
                decoration: const InputDecoration(
                    hintText: "Enter your email address",
                    labelText: 'Email',
                    border: OutlineInputBorder()),
                onChanged: (value) {
                  email = value;
                },
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                initialValue: myPwd,
                decoration: const InputDecoration(
                    hintText: "Enter your password",
                    labelText: 'Password',
                    border: OutlineInputBorder()),
                onChanged: (value) {
                  password = value;
                },
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                initialValue: myPwd,
                decoration: const InputDecoration(
                    hintText: "Confirm your password",
                    labelText: 'Password validation',
                    border: OutlineInputBorder()),
                validator: (String? value) {
                  if (value != password) {
                    return 'Password is not correct';
                  }
                  return null;
                },
              ),
            ),
            InkWell(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: const Center(
                      child: Text("Confirm",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold))),
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 18, 155, 18)),
                ),
                onTap: () async {
                  await Httpservices.settings_ch(myUserName, firstName,
                      lastName, userName, email, password, context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Settings Changed")));
                })
          ]),
        ));
  }

  void setState(Null Function() param0) {}
}
