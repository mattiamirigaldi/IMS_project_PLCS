// ignore_for_file: file_names

import 'package:flutter/material.dart';

class rentPage extends StatefulWidget {
  const rentPage({Key? key}) : super(key: key);
  @override
  _GenreListState createState() => _GenreListState();
}

class _GenreListState extends State<rentPage> {
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
                  "Please scan your items",
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
