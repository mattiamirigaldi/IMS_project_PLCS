// ignore_for_file: file_names

import 'package:flutter/material.dart';
import './../services/http_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Global key that uniquely identifies the form widget and is used for validation
  final _formKey = GlobalKey<FormState>();
  // Login parameters
  late String username;
  late String password;
  late String role;
  static const _roles =[
    "Customer",
    "Operator",
    "Admin"
  ];
  String dropdownvalue = _roles[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Login page")),
        body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Center(
                    child: Text("Sign in to your account",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrangeAccent),
                        textAlign: TextAlign.center,
                        textScaleFactor: 2)),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children : <Widget>[
                  const SizedBox(width: 25),
                  const Text("Select your role : ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),),
                  DropdownButton<String>(
                  value: dropdownvalue,
                  icon : const Icon(Icons.arrow_downward),
                  underline: Padding(
                    padding: const EdgeInsets.symmetric(horizontal : 30),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 5, width: 100, color: Colors.deepOrangeAccent),
                  ),
                  onChanged: (String? newValue){
                    setState(() {
                      dropdownvalue = newValue!;
                      role = dropdownvalue;
                    });
                  },
                  items: _roles.map<DropdownMenuItem<String>>((String value){
                    return DropdownMenuItem<String>(
                      child: Padding(
                        padding : const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        child: Text(value)), 
                      value: value,
                    );
                  }).toList(),
                ),
                ]
              ),
              const SizedBox(height: 50),
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
                        await Httpservices.login(username, password, context);
                        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login Success")));
                      }
                    } else {}
                  })
            ],
          ),
        ));
  }
}
