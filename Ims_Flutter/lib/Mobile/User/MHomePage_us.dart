// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:ims/Mobile/DataLists.dart';
import 'package:ims/Mobile/MLogin.dart';
import 'package:ims/Mobile/User/UserSettings.dart';
import 'services/MUs_http_services.dart';

class hmpage_us extends StatelessWidget {
  const hmpage_us({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.green,
            title: const Image(
              image: AssetImage('images/logo.png'),
              height: 50,
            ),
            actions: <Widget>[
              FloatingActionButton(
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MLoginPage()));
                },
                child: const Icon(Icons.exit_to_app_rounded),
                backgroundColor: const Color.fromARGB(255, 28, 67, 29),
              ),
            ]),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                  child: Text("HELLO DEAR " + TheUser[0]['firstname'],
                      textScaleFactor: 2)),
              const Center(
                  child: Text("Please select a service", textScaleFactor: 2)),
              InkWell(
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    child: const Center(
                        child: Text("Your Items",
                            style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.black))),
                    height: 100,
                    width: 1500,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                onTap: () async {
                  await Httpservices.List_User_Items(context);
                },
              ),
              InkWell(
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    child: const Center(
                        child: Text("All Items",
                            style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.black))),
                    height: 100,
                    width: 1500,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                onTap: () async {
                  await Httpservices.List_All_Items(context);
                },
              ),
              InkWell(
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    child: const Center(
                        child: Text("Settings",
                            style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.black))),
                    height: 100,
                    width: 1500,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingPage()));
                },
              ),
            ]));
  }
}
