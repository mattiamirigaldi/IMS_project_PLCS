// ignore_for_file: file_names, non_constant_identifier_names

//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:ims/Totem/Operator/TInsertCustomerRFID.dart';

class TCustomersList extends StatelessWidget {
  final List FirstName;
  final List LastName;
  final List UserName;
  final List Email;

  const TCustomersList({
    Key? key,
    required this.FirstName,
    required this.LastName,
    required this.UserName,
    required this.Email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("RFID Pending Customers")),
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
          children: <Widget>[
            for (var i = 0; i < FirstName.length; i++)
              InkWell(
                  child: ProductBox(
                    FirstName: FirstName[i],
                    LastName: LastName[i],
                    UserName: UserName[i],
                    Email: Email[i],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TInsertCustomerRFID(
                                  FirstName: FirstName[i],
                                  LastName: LastName[i],
                                  UserName: UserName[i],
                                  Email: Email[i],
                                  context: context,
                                )));
                  })
          ],
        ));
  }
}

class ProductBox extends StatelessWidget {
  const ProductBox({
    Key? key,
    required this.FirstName,
    required this.LastName,
    required this.UserName,
    required this.Email,
  }) : super(key: key);
  final String FirstName;
  final String LastName;
  final String UserName;
  final String Email;

  @override
  Widget build(BuildContext context) {
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
                          Text("FirstName: " + FirstName,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          Text("LastName: " + LastName),
                          Text("UserName: " + UserName),
                          Text("Email: " + Email),
                        ],
                      )))
            ])));
  }
}
