// ignore_for_file: file_names, must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:ims/web_app/views/components/profile_widget.dart';
import './../services/http_services.dart';
import 'components/textfield_widget.dart';
import 'package:ims/web_app/model/user.dart';

var UserData = Httpservices.user_buffer;

late String NEWfirstname; // = UserData.firstname;
late String NEWlasttname; // = UserData.lastname;
late String NEWusername; //= UserData.username;
late String NEWmail; // = UserData.mail;
late String NEWpwd; //= UserData.pwd;

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);
  //NOTE : in a dart if an identifier start with '_' then it is private to its library
  @override
  _SettingPageState createState() => _SettingPageState();
}

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
                imagePath: UserData.imagePath,
                isEdit: true,
                onClicked: () async {},
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'First Name',
                text: UserData.firstname,
                onChanged: (value) {
                  NEWfirstname = value;
                },
              ),
              TextFieldWidget(
                label: ' Last Name',
                text: UserData.lastname,
                onChanged: (value) {
                  NEWlasttname = value;
                },
              ),
              TextFieldWidget(
                label: 'Username',
                text: UserData.username,
                onChanged: (value) {
                  NEWusername = value;
                },
              ),
              TextFieldWidget(
                label: 'email',
                text: UserData.mail,
                onChanged: (value) {
                  NEWmail = value;
                },
              ),
              TextFieldWidget(
                label: 'Password',
                text: UserData.pwd,
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
                    //await Httpservices.settings_ch(NEWfirstname, NEWlasttname,
                    //    NEWusername, NEWmail, NEWpwd, context);
                    await Httpservices.settings_ch(
                        'a', 'a', 'a', 'a', 'a', context);
                  })
            ]),
      ),
    );
  }
}
