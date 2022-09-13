// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:ims/web_app/services/http_services.dart';

late String BranchName;
late String OperatorID;

class TAddCustomerRFID extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String password;
  final String branch;
  final String role;

  const TAddCustomerRFID(
      {Key? key,
      required this.firstName,
      required this.lastName,
      required this.username,
      required this.email,
      required this.password,
      required this.branch,
      required this.role,
      context})
      : super(key: key);
  @override
  _GenreListState createState() => _GenreListState();
}

class _GenreListState extends State<TAddCustomerRFID> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double width_screen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Image(
            image: AssetImage('images/logo.png'),
            height: 50,
          )),
      body: Center(
        child: Container(
          width: width_screen * 0.7,
          child: Form(
            child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                children: <Widget>[
                  const SizedBox(height: 24),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "New Branch Name",
                    ),
                    onChanged: (value) {
                      BranchName = value;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Operator ID",
                    ),
                    onChanged: (value) {
                      OperatorID = value;
                    },
                  ),
                  const SizedBox(height: 80),
                  InkWell(
                    onTap: () async {
                      await Httpservices.webAddCustomer(
                          widget.firstName,
                          widget.lastName,
                          widget.username,
                          widget.email,
                          widget.password,
                          BranchName,
                          OperatorID,
                          widget.role,
                          context);
                    },
                    child: Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20),
                        child: const Center(
                            child: Text("Add New User without RFID",
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
                ]),
          ),
        ),
      ),
    );
  }

  Row selectBranch() {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: TextFormField(
          decoration: const InputDecoration(
              hintText: "Enter New branch's name",
              labelText: 'Name the new branch',
              border: OutlineInputBorder()),
          onChanged: (value) {
            setState(() {
              BranchName = value;
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
      const SizedBox(width: 25),
      const Text(
        "Select branch : ",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
      ),
    ]);
  }
}
