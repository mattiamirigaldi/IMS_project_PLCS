// ignore_for_file: file_names, non_constant_identifier_names

//import 'dart:html';

import 'package:flutter/material.dart';

class MListCustomers extends StatelessWidget {
  final List fname;
  final List lname;
  final List uname;
  final List email;
  final List rfid;
  const MListCustomers({
    Key? key,
    required this.fname,
    required this.lname,
    required this.uname,
    required this.email,
    required this.rfid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Customers List")),
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
          children: <Widget>[
            for (var i = 0; i < fname.length; i++)
              ProductBox(
                fname: fname[i],
                lname: lname[i],
                uname: uname[i],
                email: email[i],
                rfid: rfid[i],
              ),
          ],
        ));
  }
}

class ProductBox extends StatelessWidget {
  const ProductBox({
    Key? key,
    required this.fname,
    required this.lname,
    required this.uname,
    required this.email,
    required this.rfid,
  }) : super(key: key);
  final String fname;
  final String lname;
  final String uname;
  final String email;
  final int rfid;

  @override
  Widget build(BuildContext context) {
    // String TextToShow;
    // if (Avalible == null) {
    //   TextToShow = "Book is not Avalible";
    // } else {
    //   TextToShow = "Location is: " + Location;
    // }
    // ;
    return Container(
        padding: const EdgeInsets.all(2),
        height: 120,
        child: Card(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text("Firstname: " + uname,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          Text("Lastname: " + lname),
                          Text(
                            "Username: " + uname,
                          ),
                          Text("email: " + email),
                          Text("rfid: " + rfid.toString()),
                        ],
                      )))
            ])));
  }
}
