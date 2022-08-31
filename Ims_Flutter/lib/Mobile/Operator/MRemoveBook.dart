// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'services/MOp_http_services.dart';

class MRemoveBook extends StatefulWidget {
  const MRemoveBook({Key? key}) : super(key: key);
  @override
  _GenreListState createState() => _GenreListState();
}

late String book_title;
late String book_author;

class _GenreListState extends State<MRemoveBook> {
  // ignore: unused_field
  final _formKey = GlobalKey<FormState>();
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
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Center(
                        child: Text(
                            "Please enter Title and Author of the Book you want to remove",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                            textScaleFactor: 1.6)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          hintText: "Enter the Title",
                          labelText: "Title",
                          border: OutlineInputBorder()),
                      onChanged: (value) {
                        setState(() {
                          book_title = value;
                        });
                      },
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          hintText: "Enter the Author",
                          labelText: "Author",
                          border: OutlineInputBorder()),
                      onChanged: (value) {
                        setState(() {
                          book_author = value;
                        });
                      },
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  InkWell(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20),
                        child: const Center(
                            child: Text("Remove (using Name)",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25))),
                        height: 50,
                        width: 800,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.green),
                      ),
                      onTap: () async {
                        if (_formKey.currentState != null) {
                          if (_formKey.currentState!.validate()) {
                            await Httpservices.MobileRemoveBook(
                                book_title, book_author, "no", context);
                          }
                        } else {}
                      })
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Center(
                  child: Text(
                      "Please scan your RFID then click REMOVE button to remove the book",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textScaleFactor: 1.6)),
            ),
            InkWell(
                child: Center(
                    child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: const Center(
                      child: Text("Remove (using RFID)",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold))),
                  height: 50,
                  width: 800,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green),
                )),
                onTap: () async {
                  await Httpservices.MobileRemoveBook(
                      "title", "author", "yes", context);
                }),
          ]),
    );
  }
}
