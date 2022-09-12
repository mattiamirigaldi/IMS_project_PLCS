// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:ims/web_app/views/Operator/AddBookRFID.dart';

class AddBook extends StatefulWidget {
  const AddBook({Key? key}) : super(key: key);
  @override
  _GenreListState createState() => _GenreListState();
}

// _RegisterPageState inherits the state of RegisterPage
class _GenreListState extends State<AddBook> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form
  final _formKey = GlobalKey<FormState>();
  // Register form data
  late String Publisher;
  late String Date;
  late String Title;
  late String Author;
  late String Genre;
  late String RFID;
  late String Loc;
  late String Description;

  @override
  Widget build(BuildContext context) {
    double width_screen = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: (Row(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: const Image(
                image: AssetImage("images/ims.jpg"),
                width: 45,
                height: 45,
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            const Text("Register new item page")
          ])),
        ),
        body: Center(
          child: Container(
            width: width_screen * 0.7,
            child: Form(
              key: _formKey,
              child: ListView(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: Center(
                        child: Text(
                          "Item details",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.7)),
                          textAlign: TextAlign.center,
                          textScaleFactor: 3,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Enter the Book's Publisher",
                          labelText: 'Publisher',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            Publisher = value;
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
                          horizontal: 20, vertical: 10),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Enter the Book's Date",
                          labelText: 'Date',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            Date = value;
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
                          horizontal: 20, vertical: 10),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Enter the Book's Location",
                          labelText: 'Location',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            Loc = value;
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
                          horizontal: 20, vertical: 10),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Enter the Book's Description",
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            Description = value;
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
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                        child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: const Center(
                                child: Text("SUBMIT NEW ITEM",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20))),
                            height: 60,
                            width: width_screen * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                colors: <Color>[
                                  Color.fromARGB(255, 22, 78, 163),
                                  Color(0xFF1976D2),
                                  Color.fromARGB(255, 36, 121, 190),
                                ],
                              ),
                            )),
                        onTap: () async {
                          if (_formKey.currentState != null) {
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MAddBookRFID(
                                            Title: Title,
                                            Author: Author,
                                            Genre: Genre,
                                            Publisher: Publisher,
                                            Date: Date,
                                            Loc: Loc,
                                            Description: Description,
                                            context: context,
                                          )));
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Register item data success")));
                            }
                          } else {}
                        })
                  ]),
            ),
          ),
        ));
  }
}
