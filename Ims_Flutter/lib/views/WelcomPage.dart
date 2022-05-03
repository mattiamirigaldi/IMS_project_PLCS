import 'package:flutter/material.dart';
import './Login.dart';
import './Register.dart';

class WelcomeHome extends StatelessWidget {
  const WelcomeHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("Welcome Page")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget> [
          const Center(child : 
            Text("Welcome to your",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 2)
          ),
          const Center(child : 
            Text("Inventory Management System",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 2)
          ),
          const Center (child : Image(
            image: AssetImage('images/ims.jpg'))
          ),
          InkWell(
              //  onTap: () {
              //   Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => LoginPage()));
              // },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: const Center(
                   child : Text("LOGIN", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))
                ),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
            } ,
            child : Container(
              margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: const Center(
                child: Text("REGISTER", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))
              ),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.deepOrange
              ),
          )
          )
        ]
      )
    );
  }
}