// ignore_for_file: file_names

import 'package:flutter/material.dart';
import './../services/http_services.dart';

class TotemLoginPage extends StatefulWidget {
  const TotemLoginPage({Key? key}) : super(key: key);
  @override
  _TotemLoginPageState createState() => _TotemLoginPageState();
}

class _TotemLoginPageState extends State<TotemLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Totem Login Page")),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Center(
                child: Text("Welcome to Totem Login Page",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textScaleFactor: 2)),
            const Center(
                child: Text("Pleas scan you RFID",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textScaleFactor: 2)),
            InkWell(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: const Center(
                      child: Text("LOGIN",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold))),
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.deepOrangeAccent),
                ),
                onTap: () async {
                  // if(_formKey.currentState != null) {
                  //   if (_formKey.currentState!.validate()){
                  await Httpservices.totemLogin(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Login Success")));
                  //   }
                  //   } else {

                  // }
                })
          ]),
    );
  }
}
