// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import './services/TOp_http_services.dart';

class TInsertCustomerRFID extends StatefulWidget {
  final String FirstName;
  final String LastName;
  final String UserName;
  final String Email;

  const TInsertCustomerRFID(
      {Key? key,
      required this.FirstName,
      required this.LastName,
      required this.UserName,
      required this.Email,
      context,
      lastName,
      username,
      email})
      : super(key: key);
  @override
  _GenreListState createState() => _GenreListState();
}

class _GenreListState extends State<TInsertCustomerRFID> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue,
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
                  await Httpservices.totemInsertCustomerRFID(widget.FirstName,
                      widget.LastName, widget.UserName, widget.Email, context);
                },
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: const Center(
                        child: Text("Add User RFID",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black))),
                    height: 100,
                    width: 1500,
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
