// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';

class ItemsList extends StatelessWidget {
  final List bookid;
  final List bookTitle;
  final List bookAuthor;
  final List bookGenre;
  final List bookRFID;

  const ItemsList({
    Key? key,
    required this.bookid,
    required this.bookTitle,
    required this.bookAuthor,
    required this.bookGenre,
    required this.bookRFID,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Available Titles")),
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
          children: <Widget>[
            for (var i = 0; i < bookTitle.length; i++)
              ProductBox(
                id: bookid[i],
                name: bookTitle[i],
                description: bookAuthor[i],
                price: bookGenre[i],
                RFID: bookRFID[i],
              ),
          ],
        ));
  }
}

class ProductBox extends StatelessWidget {
  const ProductBox(
      {Key? key,
      required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.RFID})
      : super(key: key);
  final int id;
  final String name;
  final String description;
  final String price;
  final int RFID;
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
                          Text(name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          Text("By " + description),
                          Text(
                            "Genre: " + price,
                          ),
                          Text("ID: " + id.toString()),
                          Text("RFID: " + RFID.toString()),
                        ],
                      )))
            ])));
  }
}
