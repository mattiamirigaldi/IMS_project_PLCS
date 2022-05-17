// ignore_for_file: file_names

import 'package:flutter/material.dart';
import './../services/http_services.dart';

class GenreList extends StatefulWidget {
  const GenreList({Key? key}) : super(key: key);
  @override
  _GenreListState createState() => _GenreListState();
}

class _GenreListState extends State<GenreList> {
  final _formKey = GlobalKey<FormState>();
  String bkid = "21";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Genre List")),
        body: Form(
          key: _formKey,
          child: ListView(children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Center(
                child: Text(
                  "Select a genre",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrangeAccent),
                  textAlign: TextAlign.center,
                  textScaleFactor: 2,
                ),
              ),
            ),
            InkWell(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Container(
                        height: 200,
                        decoration: const BoxDecoration(
                            color: Colors.purple,
                            image: DecorationImage(
                              image: AssetImage('images/Adventure.png'),
                            )))),
                onTap: () async {}),
            InkWell(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Container(
                        height: 200,
                        decoration: const BoxDecoration(
                            color: Colors.purple,
                            image: DecorationImage(
                              image: AssetImage('images/Fantasy.png'),
                            )))),
                onTap: () async {}),
            InkWell(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Container(
                        height: 200,
                        decoration: const BoxDecoration(
                            color: Colors.purple,
                            image: DecorationImage(
                              image: AssetImage('images/Horror.png'),
                            )))),
                onTap: () async {}),
            InkWell(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Container(
                        height: 200,
                        decoration: const BoxDecoration(
                            color: Colors.purple,
                            image: DecorationImage(
                              image: AssetImage('images/Mystery.png'),
                            )))),
                onTap: () async {}),
            InkWell(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Container(
                        height: 200,
                        decoration: const BoxDecoration(
                            color: Colors.purple,
                            image: DecorationImage(
                              image: AssetImage('images/Romance.png'),
                            )))),
                onTap: () async {}),
            InkWell(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Container(
                        height: 200,
                        decoration: const BoxDecoration(
                            color: Colors.purple,
                            image: DecorationImage(
                              image: AssetImage('images/Si-Fi.png'),
                            )))),
                onTap: () async {}),
            InkWell(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: const Center(
                      child: Text("ALL",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold))),
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.deepOrangeAccent),
                ),
                onTap: () async {
                  await Httpservices.items(bkid, context);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text("Books")));
                })
          ]),
        ));
  }
}
