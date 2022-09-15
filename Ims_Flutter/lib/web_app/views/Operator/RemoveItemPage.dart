// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:ims/web_app/services/http_services.dart';

class RemoveBook extends StatefulWidget {
  const RemoveBook({Key? key}) : super(key: key);
  @override
  _GenreListState createState() => _GenreListState();
}

late String book_title;
late String book_author;

class _GenreListState extends State<RemoveBook> {
  // ignore: unused_field
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double width_screen = MediaQuery.of(context).size.width;
    return Scaffold(
     appBar: AppBar(
          title: (
            Row(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: const Image(
                  image: AssetImage("images/ims.jpg"),
                  width: 45,
                  height: 45,
                ),
              ),
              const SizedBox(width: 30,),
              const Text("Delete item page")
            ])
          ),
        ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: width_screen*0.7,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 50),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                        child: Center(
                            child: Text(
                                "Please enter Title and Author of the item to remove".toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black.withOpacity(0.8)),
                                textAlign: TextAlign.center,
                                textScaleFactor: 2)),
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
                            horizontal: 30, vertical: 20),
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
                      const SizedBox(height: 20,),
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
                                color: Colors.amber),
                          ),
                          onTap: () async {
                            if (_formKey.currentState != null) {
                              if (_formKey.currentState!.validate()) {
                                await Httpservices.webRemoveBook(
                                    book_title, book_author, "no", context);
                              }
                            } else {}
                          })
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
