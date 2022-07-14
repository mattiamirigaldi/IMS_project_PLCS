// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';

class TRemoveBook extends StatefulWidget {
  const TRemoveBook({Key? key}) : super(key: key);
  @override
  _GenreListState createState() => _GenreListState();
}

class _GenreListState extends State<TRemoveBook> {
  final _formKey = GlobalKey<FormState>();
  String bkid = "21";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.green,
            title: const Image(
              image: AssetImage('images/logo.png'),
              height: 50,
            )),
        body: Form(
          key: _formKey,
          child: ListView(children: const <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Center(
                child: Text(
                  "Please scan the RFID of book you'd like to remove",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                  textAlign: TextAlign.center,
                  textScaleFactor: 2,
                ),
              ),
            ),
          ]),
        ));
  }
}