// ignore_for_file: file_names

import 'package:flutter/material.dart';
import './../services/http_services.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  //NOTE : in a dart if an identifier start with '_' then it is private to its library
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

// _RegisterPageState inherits the state of RegisterPage
class _RegisterPageState extends State<RegisterPage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form
  final _formKey = GlobalKey<FormState>();
  // Register form data
  late String email;
  late String firstName;
  late String lastName;
  late String username;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Register page")),
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
                      "Register your account",
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
                      hintText: "Enter your first name",
                      labelText: 'First Name',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        firstName = value;
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
                      hintText: "Enter your last name",
                      labelText: 'Last Name',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        lastName = value;
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
                        hintText: "Enter your username",
                        labelText: 'Username',
                        border: OutlineInputBorder()),
                    onChanged: (value) {
                      setState(() {
                        username = value;
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
                        hintText: "Enter your email address",
                        labelText: 'Email',
                        border: OutlineInputBorder()),
                    onChanged: (value) {
                      setState(() {
                        email = value;
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
                        hintText: "Enter your password",
                        labelText: 'Password',
                        border: OutlineInputBorder()),
                    onChanged: (value) {
                      setState(() {
                        password = value;
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
                        hintText: "Confirm your password",
                        labelText: 'Password validation',
                        border: OutlineInputBorder()),
                    validator: (String? value) {
                      if (value != password) {
                        return 'Password is not correct';
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
                          child: Text("SUBMIT",
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
                          await Httpservices.register(firstName, lastName,
                              username, email, password, context);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Register Success")));
                        }
                      } else {}
                    })
              ]),
        ));
  }
}
