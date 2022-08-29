// ignore_for_file: file_names, non_constant_identifier_names

//import 'dart:html';

import 'package:flutter/material.dart';

class MItemsList extends StatelessWidget {
  final List bookTitle;
  final List bookAuthor;
  final List bookGenre;
  final List bookRFID;
  final List bookAvalible;
  final List bookLocation;
  const MItemsList({
    Key? key,
    required this.bookTitle,
    required this.bookAuthor,
    required this.bookGenre,
    required this.bookRFID,
    required this.bookAvalible,
    required this.bookLocation,
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
                name: bookTitle[i],
                description: bookAuthor[i],
                price: bookGenre[i],
                RFID: bookRFID[i],
                Avalible: bookAvalible[i],
                Location: bookLocation[i],
              ),
          ],
        ));
  }
}

class ProductBox extends StatelessWidget {
  const ProductBox({
    Key? key,
    required this.name,
    required this.description,
    required this.price,
    required this.RFID,
    required this.Avalible,
    required this.Location,
  }) : super(key: key);
  final String name;
  final String description;
  final String price;
  final int RFID;
  final int Avalible;
  final String Location;

  @override
  Widget build(BuildContext context) {
    // String TextToShow;
    // if (Avalible == null) {
    //   TextToShow = "Book is not Avalible";
    // } else {
    //   TextToShow = "Location is: " + Location;
    // }
    // ;
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
                          Text("RFID: " + RFID.toString()),
                          Text("cus_id: " + Avalible.toString()),
                        ],
                      )))
            ])));
  }
}
