// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:ims/Web_app/services/http_services.dart';

class removeItem extends StatefulWidget {
  const removeItem({Key? key}) : super(key: key);
  @override
  _GenreListState createState() => _GenreListState();
}

class _GenreListState extends State<removeItem> {
  late String item_title;
  late String item_author;
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
                            "Please enter Title and Author of the item you'd like to remove",
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
                          item_title = value;
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
                          item_author = value;
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
                            child: Text("Remove item",
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
                            await Httpservices.removeItem(
                                item_title, item_author, "no", context);
                          }
                        }
                      }
                    ),
              ],),
            )
      ])
    ); 
  }
}
