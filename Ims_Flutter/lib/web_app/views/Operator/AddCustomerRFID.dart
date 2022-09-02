// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:ims/web_app/services/http_services.dart';

class TAddCustomerRFID extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String password;
  final String role;

  const TAddCustomerRFID(
      {Key? key,
      required this.firstName,
      required this.lastName,
      required this.username,
      required this.email,
      required this.password,
      required this.role,
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
                  child: Text(
                      "You can scan your RFID using the totem. Please confirm your registeration",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black))),
              // InkWell(
              //   onTap: () async {
              //     await Httpservices.totemAddCustomer(
              //         widget.firstName,
              //         widget.lastName,
              //         widget.username,
              //         widget.email,
              //         widget.password,
              //         "yes",
              //         context);
              //   },
              //   child: Center(
              //     child: Container(
              //       margin: const EdgeInsets.symmetric(
              //           horizontal: 30, vertical: 20),
              //       child: const Center(
              //           child: Text("Add New User",
              //               style: TextStyle(
              //                   fontSize: 30,
              //                   fontWeight: FontWeight.bold,
              //                   color: Colors.black))),
              //       height: 100,
              //       width: 1500,
              //       decoration: BoxDecoration(
              //         color: Colors.green,
              //         borderRadius: BorderRadius.circular(20),
              //       ),
              //     ),
              //   ),
              // ),
              InkWell(
                onTap: () async {
                  await Httpservices.totemAddCustomer(
                      widget.firstName,
                      widget.lastName,
                      widget.username,
                      widget.email,
                      widget.password,
                      "no",
                      widget.role,
                      context);
                },
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: const Center(
                        child: Text("Add New User without RFID",
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
