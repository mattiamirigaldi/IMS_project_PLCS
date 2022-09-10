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
  late String role = "customers";
  late bool _obscureText = true;
  static const _roles = ["customers", "operators", "admins"];
  String dropdownvalue = _roles[0];
  @override
  Widget build(BuildContext context) {
    double width_screen = MediaQuery.of(context).size.width;
    double height_screen = MediaQuery.of(context).size.height;
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
              const Text("Login page")
            ])
          ),
        ),
        body: Center(
          child: Container(
            width: width_screen*0.7,
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
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
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: GestureDetector(
                            onTap:(){
                              setState(() {
                                 _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off)
                          ),
                        ),
                        hintText: "Enter your password",
                        labelText: "Password",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        password = value;
                      },
                      obscureText: _obscureText,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: <
                      Widget>[
                    const SizedBox(width: 25),
                    const Text(
                      "Select your role : ",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                    DropdownButton<String>(
                      value: dropdownvalue,
                      icon: const Icon(Icons.arrow_downward),
                      underline: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Container(
                            alignment: Alignment.centerLeft,
                            height: 5,
                            width: 100,
                            color: Colors.deepOrangeAccent),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                          role = dropdownvalue;
                        });
                      },
                      items: _roles.map<DropdownMenuItem<String>>((String value) {
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
                  const SizedBox(height: 50),
                  InkWell(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: const Center(
                            child: Text("LOGIN",
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
                            await Httpservices.login(
                                username, password, role, context);
                          }
                        } else {}
                      })
                ],
              ),
            ),
          ),
        ));
  }
}
