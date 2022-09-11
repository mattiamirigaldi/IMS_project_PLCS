// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:ims/Totem/TWelcomePage.dart';
import './TRentPage.dart';
import './TReturnPage.dart';

class hmpage_us extends StatelessWidget {
  const hmpage_us({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.green,
            title:
                //Text("HELLO DEAR BOOK LOVER!"),
                const Image(
              image: AssetImage('images/logo.png'),
              height: 50,
            ),
            actions: <Widget>[
              FloatingActionButton(
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TWelcome()));
                },
                child: const Icon(Icons.exit_to_app_rounded),
                backgroundColor: const Color.fromARGB(255, 28, 67, 29),
              ),
            ]),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Center(child: Text("Please select a service")),
              InkWell(
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 30),
                    child: const Center(
                        child: Text("Rent",
                            style: TextStyle(
                                fontSize: 50,
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
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TRentPage()));
                },
              ),
              InkWell(
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 30),
                    child: const Center(
                        child: Text("Return",
                            style: TextStyle(
                                fontSize: 50,
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
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TReturnPage()));
                },
              ),
            ]));
  }
}
