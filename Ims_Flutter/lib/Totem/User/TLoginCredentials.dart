// ignore_for_file: file_names

import 'package:flutter/material.dart';
import './services/TUs_http_services.dart';

class TLoginCredentials extends StatefulWidget {
  const TLoginCredentials({Key? key}) : super(key: key);
  @override
  _TLoginCredentials createState() => _TLoginCredentials();
}

class _TLoginCredentials extends State<TLoginCredentials> {
  // Global key that uniquely identifies the form widget and is used for validation
  final _formKey = GlobalKey<FormState>();
  // Login parameters
  late String username;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Login page")),
        body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Center(
                    child: Text("Sign in to your account",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                        textAlign: TextAlign.center,
                        textScaleFactor: 2)),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  decoration: const InputDecoration(
                      hintText: "Enter your username",
                      labelText: "Username",
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
                    hintText: "Enter your password",
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    password = value;
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
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                        color: Colors.blue),
                  ),
                  onTap: () async {
                    if (_formKey.currentState != null) {
                      if (_formKey.currentState!.validate()) {
                        await Httpservices.totemLoginCredentialUs(
                            username, password, context);
                        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login Success")));
                      }
                    } else {}
                  })
            ],
          ),
        ));
  }
}
