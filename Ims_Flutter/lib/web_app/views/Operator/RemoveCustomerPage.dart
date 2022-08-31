// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:ims/web_app/services/http_services.dart';

class RemoveCustomer extends StatefulWidget {
  const RemoveCustomer({Key? key}) : super(key: key);
  @override
  _GenreListState createState() => _GenreListState();
}

class _GenreListState extends State<RemoveCustomer> {
  late String cst_username;
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
                            "Please enter username of the Customer you want to remove",
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
                          hintText: "Enter the username",
                          labelText: "Username",
                          border: OutlineInputBorder()),
                      onChanged: (value) {
                        setState(() {
                          cst_username = value;
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
                            child: Text("Remove customer",
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
                            await Httpservices.removeCheck(context);
                          }
                        }
                      })
                ],
              ),
            ),
          ]),
    );
  }
}
