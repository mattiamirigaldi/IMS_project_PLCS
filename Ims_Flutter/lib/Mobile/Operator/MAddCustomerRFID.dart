// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import './services/MOp_http_services.dart';

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
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black))),
              InkWell(
                onTap: () async {
                  await HttpservicesOP.RfidReader(context);
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('RFID READER'),
                          content: const Text("Please scan the Book's RFID"),
                          actions: <Widget>[
                            TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white)),
                              child: const Text('CANCEL'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            TextButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<
                                          Color>(
                                      const Color.fromARGB(255, 68, 156, 71)),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white)),
                              child: const Text('OK'),
                              onPressed: () async {
                                await HttpservicesOP.MobileAddCustomerNFC(
                                    widget.firstName,
                                    widget.lastName,
                                    widget.username,
                                    widget.email,
                                    widget.password,
                                    "yes",
                                    context);
                              },
                            ),
                          ],
                        );
                      });
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
              InkWell(
                onTap: () async {
                  await HttpservicesOP.MobileAddCustomer(
                      widget.firstName,
                      widget.lastName,
                      widget.username,
                      widget.email,
                      widget.password,
                      "no",
                      context);
                },
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: const Center(
                        child: Text("Add New User without RFID",
                            style: TextStyle(
                                fontSize: 25,
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
