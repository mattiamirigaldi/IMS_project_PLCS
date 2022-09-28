// ignore_for_file: file_names, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:ims/web_app/DataLists.dart';

class ListUserItems extends StatelessWidget {
  const ListUserItems();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Your Loans")),
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
          children: <Widget>[
            for (var i = 0; i < AllItems.length; i++)
              ProductBox(
                title: AllItems[i]['title'],
                author: AllItems[i]['author'],
                genre: AllItems[i]['genre'],
                rfid: AllItems[i]['rfid'].toString(),
                date: AllItems[i]['date'].toString(),
                publisher: AllItems[i]['publisher'],
              ),
          ],
        ));
  }
}

class ProductBox extends StatelessWidget {
  const ProductBox({
    Key? key,
    required this.title,
    required this.author,
    required this.genre,
    required this.rfid,
    required this.date,
    required this.publisher,
  }) : super(key: key);
  final String title;
  final String author;
  final String genre;
  final String rfid;
  final String date;
  final String publisher;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(2),
        height: 150,
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
                          Text(title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          Text("Author : " + author),
                          Text("Genre : " + genre),
                          Text("RFID : " + rfid),
                          Text("date : " + date),
                          Text("Publisher : " + publisher),
                        ],
                      )))
            ])));
  }
}
