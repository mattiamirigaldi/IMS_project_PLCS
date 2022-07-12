import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ims/Totem/TWelcomePage.dart';
import 'package:ims/views/WelcomPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  //this widget is the root of the application
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // MaterialApp is the starting point of the app, says that the app will follow material design and will use material components.
    // Then the top level container in a material app is described by Scaffold, that gives different functionalites like AppBar, Drawer ...
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      title: 'Inventory Management System',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: const TWelcome(),
      builder: EasyLoading.init(),
    );
  }
}
