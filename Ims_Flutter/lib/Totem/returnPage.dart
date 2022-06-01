// ignore_for_file: file_names

import 'package:flutter/material.dart';

class returnPage extends StatelessWidget {
  const returnPage({Key? key}) : super(key: key);
  @override
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
          child: ListView(children: const <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Center(
                child: Text(
                  "Please scan your items and place them on the RETURN shelf",
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
