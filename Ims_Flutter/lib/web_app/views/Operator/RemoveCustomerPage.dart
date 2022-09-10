// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:ims/web_app/DataLists.dart';
import 'package:ims/web_app/services/http_services.dart';

class RemoveCustomer extends StatefulWidget {
  const RemoveCustomer({Key? key}) : super(key: key);
  @override
  _GenreListState createState() => _GenreListState();
}

late String cst_username;
late String role = "customers";

class _GenreListState extends State<RemoveCustomer> {
  static const _rolesOp = [
    "customers",
  ];
  static const _rolesAdm = ["operators"];
  late List<String> _roles = [];
  String dropdownvalue = _rolesOp[0];

  // ignore: unused_field
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (TheWebUser[0]['role'] == 'operators') {
      _roles = _rolesOp;
    } else if (TheWebUser[0]['role'] == 'admins') {
      _roles = _rolesOp + _rolesAdm;
    }
    double width_screen = MediaQuery.of(context).size.width;
    double height_screen = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: (Row(children: const [
          ClipRect(
            child: Image(
              image: AssetImage("images/ims.jpg"),
              width: 45,
              height: 45,
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Text("Delete user page")
        ])),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                    child: Center(
                        child: Text(
                            "Please enter username of the user you'd like to remove",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                            textScaleFactor: 2)),
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
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(width: 35),
                        const Text(
                          "Select user role : ",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.normal),
                        ),
                        DropdownButton<String>(
                          value: dropdownvalue,
                          icon: const Icon(Icons.arrow_downward),
                          underline: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: 5,
                                  width: 100,
                                  color: Colors.black.withOpacity(0.4))),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                              role = dropdownvalue;
                            });
                          },
                          items: _roles
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10),
                                  child: Text(value)),
                              value: value,
                            );
                          }).toList(),
                        ),
                      ]),
                  const SizedBox(height: 40),
                  InkWell(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20),
                        child: const Center(
                            child: Text("Remove (Username)",
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
                            await Httpservices.webRemoveCheck(
                                cst_username, role, context);
                          }
                        } else {}
                      })
                ],
              ),
            ),
          ]),
    );
  }
}
