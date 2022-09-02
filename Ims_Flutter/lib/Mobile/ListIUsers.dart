// ignore_for_file: file_names, use_key_in_widget_constructors
import 'DataLists.dart';
import 'package:flutter/material.dart';

class ListUsers extends StatelessWidget {
  const ListUsers();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Available Titles")),
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
          children: <Widget>[
            for (var i = 0; i < AllUsers.length; i++)
              ProductBox(
                firstname: AllUsers[i]['firstname'],
                lastname: AllUsers[i]['lastname'],
                username: AllUsers[i]['username'],
                mail: AllUsers[i]['mail'],
                rfid: AllUsers[i]['rfid'].toString(),
              ),
          ],
        ));
  }
}

class ProductBox extends StatelessWidget {
  const ProductBox({
    Key? key,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.mail,
    required this.rfid,
  }) : super(key: key);
  final String firstname;
  final String lastname;
  final String username;
  final String mail;
  final String rfid;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(2),
        height: 120,
        child: Card(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(firstname,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          Text("lastname " + lastname),
                          Text("username: " + username),
                          Text("mail: " + mail),
                          Text("rfid: " + rfid),
                        ],
                      )))
            ])));
  }
}
