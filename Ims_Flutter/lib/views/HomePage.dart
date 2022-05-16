// ignore_for_file: file_names
import 'package:flutter/material.dart';
import './../services/http_services.dart';

class HomePage extends StatelessWidget {
  final String userName;
  final String myname;
  final String myemail;
  const HomePage(
      {Key? key,
      required this.userName,
      required this.myname,
      required this.myemail})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("HOME Page")),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                  child: Text(
                      "Welcome Dear $myname  -  your Email is : $myemail",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textScaleFactor: 2)),
              InkWell(
                onTap: () async {
                  await Httpservices.settings(userName, context);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text("SeTtInGs")));
                },
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 30),
                    child: const Center(
                        child: Text("Settings",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black))),
                    height: 50,
                    width: 800,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ]));
  }
}
