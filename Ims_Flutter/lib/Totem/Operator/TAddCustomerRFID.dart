// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import './services/TOp_http_services.dart';

class TAddCustomerRFID extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String password;

  const TAddCustomerRFID(
      {Key? key,
      required this.firstName,
      required this.lastName,
      required this.username,
      required this.email,
      required this.password,
      context})
      : super(key: key);
  @override
  _GenreListState createState() => _GenreListState();
}

class _GenreListState extends State<TAddCustomerRFID> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.green,
            title: const Image(
              image: AssetImage('images/logo.png'),
              height: 50,
            )),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Center(
                  child: Text("scan RFID and press the button",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black))),
              InkWell(
                onTap: () async {
                  await EasyLoading.showSuccess(
                      "received first name = " + widget.firstName);
                  await Httpservices.totemAddCustomer(
                      widget.firstName,
                      widget.lastName,
                      widget.username,
                      widget.email,
                      widget.password,
                      context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("New User added successfully")));
                },
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: const Center(
                        child: Text("Add New User",
                            style: TextStyle(
                                fontSize: 30,
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
              ),
            ]));
  }
}
