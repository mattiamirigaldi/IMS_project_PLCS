// ignore_for_file: file_names, must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ims/Mobile/DataLists.dart';
import 'package:ims/Mobile/Operator/services/MOp_http_services.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);
  //NOTE : in a dart if an identifier start with '_' then it is private to its library
  @override
  _SettingPageState createState() => _SettingPageState();
}

late String NEWfirstname = TheUser[0]['firstname'];
late String NEWlastname = TheUser[0]['lastname'];
late String NEWusername = TheUser[0]['username'];
late String NEWmail = TheUser[0]['mail'];
late String NEWpwd = TheUser[0]['pwd'];

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Settings page")),
      body: Form(
        child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            children: <Widget>[
              const SizedBox(height: 24),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "First Name",
                ),
                initialValue: TheUser[0]['firstname'],
                onChanged: (value) {
                  NEWfirstname = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Last Name",
                ),
                initialValue: TheUser[0]['lastname'],
                onChanged: (value) {
                  NEWlastname = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Username",
                ),
                initialValue: TheUser[0]['username'],
                onChanged: (value) async {
                  await HttpservicesOP.usrcheck(value, context);
                  NEWusername = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Email",
                ),
                initialValue: TheUser[0]['mail'],
                onChanged: (value) {
                  NEWmail = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
                initialValue: TheUser[0]['pwd'],
                onChanged: (value) {
                  NEWpwd = value;
                },
              ),
              InkWell(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
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
                    if (HttpservicesOP.username_valid == true) {
                      await HttpservicesOP.settings(NEWfirstname, NEWlastname,
                          NEWusername, NEWmail, NEWpwd, context);
                    } else {
                      await EasyLoading.showError("The Username is not valid");
                    }
                  })
            ]),
      ),
    );
  }
}
