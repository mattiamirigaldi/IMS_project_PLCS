// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ims/Totem/Operator/services/TOp_http_services.dart';
import 'TAddBookRFID.dart';

class TAddBook extends StatefulWidget {
  const TAddBook({Key? key}) : super(key: key);
  @override
  _GenreListState createState() => _GenreListState();
}

// _RegisterPageState inherits the state of RegisterPage
class _GenreListState extends State<TAddBook> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form
  final _formKey = GlobalKey<FormState>();
  // Register form data
  late String Location;
  late String Title;
  late String Author;
  late String Genre;
  late String RFID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Add new Book")),
        body: Form(
          key: _formKey,
          child: ListView(
              //crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Center(
                    child: Text(
                      "Book details",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrangeAccent),
                      textAlign: TextAlign.center,
                      textScaleFactor: 2,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Enter the Book's Title",
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        Title = value;
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Enter the Book's Author",
                      labelText: 'Author',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        Author = value;
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Enter the Book's Genre",
                      labelText: 'Genre',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        Genre = value;
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Enter the Book's Location",
                      labelText: 'Location',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        Location = value;
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
                          horizontal: 20, vertical: 20),
                      child: const Center(
                          child: Text("SUBMIT new Book data",
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
                      if (_formKey.currentState != null) {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TAddBookRFID(
                                        Title: Title,
                                        Author: Author,
                                        Genre: Genre,
                                        Location: Location,
                                        context: context,
                                      )));
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Register user data success")));
                        }
                      } else {}
                    })
              ]),
        ));
  }
}
