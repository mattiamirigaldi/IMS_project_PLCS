// ignore_for_file: file_names, must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:ims/web_app/DataLists.dart';
import 'package:ims/web_app/views/components/profile_widget.dart';
import './../services/http_services.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);
  //NOTE : in a dart if an identifier start with '_' then it is private to its library
  @override
  _SettingPageState createState() => _SettingPageState();
}

late String NEWfirstname = TheWebUser[0]['firstname'];
late String NEWlastname = TheWebUser[0]['lastname'];
late String NEWusername = TheWebUser[0]['username'];
late String NEWmail = TheWebUser[0]['mail'];
late String NEWpwd = TheWebUser[0]['pwd'];

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Settings page")),
      body: Form(
        child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            children: <Widget>[
              ProfileWidget(
                imagePath: TheWebUser[0]['imagePath'],
                isEdit: true,
                onClicked: () async {},
              ),
              const SizedBox(height: 24),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "First Name",
                ),
                initialValue: TheWebUser[0]['firstname'],
                onChanged: (value) {
                  NEWfirstname = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Last Name",
                ),
                initialValue: TheWebUser[0]['lastname'],
                onChanged: (value) {
                  NEWlastname = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Username",
                ),
                initialValue: TheWebUser[0]['username'],
                onChanged: (value) {
                  NEWusername = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Email",
                ),
                initialValue: TheWebUser[0]['mail'],
                onChanged: (value) {
                  NEWmail = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
                initialValue: TheWebUser[0]['pwd'],
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
                    await Httpservices.settings(NEWfirstname, NEWlastname,
                        NEWusername, NEWmail, NEWpwd, context);
                  })
            ]),
      ),
    );
  }
}
