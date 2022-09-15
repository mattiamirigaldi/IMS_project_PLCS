// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:ims/web_app/views/Guest/GuestDashboard.dart';
import 'package:ims/web_app/services/http_services.dart';
import './Login.dart';
import './Register.dart';

class WelcomeHome extends StatelessWidget {
  const WelcomeHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
          const SizedBox(
            height: 80,
          ),
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
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Center(
                  child: ClipRRect(
                child: Image.asset(
                  'images/ims.jpg',
                  width: 200,
                  height: 200,
                ),
                borderRadius: BorderRadius.circular(20),
              ))),
          InkWell(
            onTap: () async {
              //await Httpservices.login('o1', 'o1', 'operators', context);
              //await Httpservices.login('c1', 'c1', 'customers', context);
              //Navigator.push(context,
              //    MaterialPageRoute(builder: (context) => const LoginPage()));
              // await Httpservices.login('c1', 'c1', 'customers', context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
            child: Center(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                child: const Center(
                    child: Text("LOGIN",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black))),
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
                margin:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                child: const Center(
                    child: Text("REGISTER AS ADMIN",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black))),
                height: 50,
                width: 800,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 1, 154, 16)),
              ))),
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GuestDashBoard()));
              },
              child: Center(
                  child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                child: const Center(
                    child: Text("ENTER AS GUEST",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black))),
                height: 50,
                width: 800,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 224, 48, 48)),
              ))),
        ]));
  }
}
