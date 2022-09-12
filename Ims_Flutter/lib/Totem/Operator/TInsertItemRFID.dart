// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import './services/TOp_http_services.dart';

class TInsertItemRFID extends StatefulWidget {
  final String name;
  final String Location;

  const TInsertItemRFID(
      {Key? key, required this.name, required this.Location, context})
      : super(key: key);
  @override
  _GenreListState createState() => _GenreListState();
}

class _GenreListState extends State<TInsertItemRFID> {
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
                  await Httpservices.totemInsertItemRFID(
                      widget.name, widget.Location, context);
                },
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: const Center(
                        child: Text("Add Item RFID",
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
