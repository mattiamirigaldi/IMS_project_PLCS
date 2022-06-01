// ignore_for_file: file_names

import 'package:flutter/material.dart';
import './Login.dart';
import './Register.dart';

class WelcomeHome extends StatelessWidget {
  const WelcomeHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Welcome Page")),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Center(
                  child: Text("Welcome to your",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textScaleFactor: 2)),
              const Center(
                  child: Text("Inventory Management System",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textScaleFactor: 2)),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  child: Center(
                      child: Image(image: AssetImage('images/ims.jpg')))),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 30),
                    child: const Center(
                        child: Text("LOGIN",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black))),
                    height: 50,
                    width: 800,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()));
                  },
                  child: Center(
                      child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    child: const Center(
                        child: Text("REGISTER",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black))),
                    height: 50,
                    width: 800,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 1, 154, 16)),
                  ))),
            ]));
  }
}
