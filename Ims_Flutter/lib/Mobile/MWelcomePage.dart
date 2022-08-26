// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import './../routes.dart';
import 'User/services/MUs_http_services.dart';

class MWelcome extends StatelessWidget {
  const MWelcome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    late String URLaddress = "172.21.211.15";
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.green,
            title:
                //Text("HELLO DEAR BOOK LOVER!"),
                const Image(
              image: AssetImage('images/logo.png'),
              height: 50,
            )),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Center(
                  child: Text("Hello dear book lover!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.normal),
                      textScaleFactor: 2)),
              const Center(
                  child: Text("Welcome to",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.normal),
                      textScaleFactor: 2)),
              const Center(
                child: Text("IMS",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                    textScaleFactor: 3),
              ),
              const Center(
                  child: Text("(MOBILE APP)",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textScaleFactor: 2)),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  child: Center(
                      child: Image.asset('images/bookies.png',
                          width: 400, height: 100))),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                child: TextFormField(
                  initialValue: URLaddress,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                      hintText: "Enter URL to access the server",
                      labelText: "Server URL",
                      border: OutlineInputBorder()),
                  onChanged: (String value) {
                    {
                      URLaddress = value;
                    }
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
                onTap: () async {
                  if (URLaddress.isEmpty) {
                    //await EasyLoading.showError("Please Enter the URL!");
                  } else {
                    Myroutes.baseUrlMobile = URLaddress;
                    //ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //    content: Text("URL is " + Myroutes.baseUrlMobile)));
                    await Httpservices.mobileurl(context);
                  }
                  //Navigator.push(
                  //    context,
                  //    MaterialPageRoute(
                  //        builder: (context) => const TLoginPage()));
                },
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 20),
                    child: const Center(
                        child: Text("Enter",
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.black))),
                    height: 80,
                    width: 500,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ]));
  }
}
