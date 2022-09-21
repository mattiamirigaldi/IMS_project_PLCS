// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'services/TUs_http_services.dart';

class TReturnPage extends StatefulWidget {
  const TReturnPage({Key? key}) : super(key: key);
  @override
  _GenreListState createState() => _GenreListState();
}

class _GenreListState extends State<TReturnPage> {
  // ignore: unused_field
  final _formKey = GlobalKey<FormState>();
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Center(
                  child: Text(
                      "Please scan the RFID of the book you want to Return and leave the book on the shelf",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textScaleFactor: 2)),
            ),
            InkWell(
                child: Center(
                    child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: const Center(
                      child: Text("SCAN",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold))),
                  height: 50,
                  width: 800,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue),
                )),
                onTap: () async {
                  await Httpservices.Book_return(context);
                }),
          ]),
    );
  }
}
