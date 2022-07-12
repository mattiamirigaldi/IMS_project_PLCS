// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:ims/Totem/User/TLoginCredentials.dart';
import 'Operator/TLoginOperator.dart';
import './User/services/TUs_http_services.dart';

class TLoginPage extends StatefulWidget {
  const TLoginPage({Key? key}) : super(key: key);
  @override
  _TLoginPageState createState() => _TLoginPageState();
}

class _TLoginPageState extends State<TLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Image(
              image: AssetImage('images/logo.png'),
              height: 50,
            ),
        backgroundColor: Colors.green,),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child : Center(
                      child: Image(image: AssetImage('images/ims.jpg'), height: 200, width: 200))
            ),
            const Center(
                child: Text("Welcome ",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textScaleFactor: 3)),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Center(
                child: Text("Please scan your RFID then click LOGIN button",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textScaleFactor: 2)),
            ),
            // If wanted to implement with inf loop :
            // Padding(
            //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            //       child: Center(
            //           child: CircularProgressIndicator(
            //               valueColor:
            //                   AlwaysStoppedAnimation<Color>(Colors.green)))),
            InkWell(
                child: Center(
                  child: Container(
                    margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: const Center(
                      child: Text("LOGIN",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold))),
                    height: 50,
                    width: 800,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green),
                  )),
                onTap: () async {
                  // if(_formKey.currentState != null) {
                  //   if (_formKey.currentState!.validate()){
                  await Httpservices.totemLoginUs(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Login Success")));
                  //   }
                  //   } else {

                  // }
                }),
               Align( 
                alignment: Alignment.bottomLeft,
                child:  InkWell(
                  child: const Text("> Login with credentials", style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 25,
                    color: Colors.blue)),
                  onTap: (){ Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TLoginCredentials()));},
                  
                  ),),
               const SizedBox(height: 20),
               Align(
                 alignment: Alignment.bottomLeft,
                 child: InkWell(
                    child: const Text("> Login as operator", style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 25,
                      color: Colors.blue)),
                    onTap: (){
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TLoginOperator()));
                    },
                    ),
               )   
          ]),
    );
  }
}
