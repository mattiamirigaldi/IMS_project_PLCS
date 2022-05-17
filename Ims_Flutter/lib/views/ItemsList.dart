import 'package:flutter/material.dart';
import './../services/http_services.dart';

class ItemsList extends StatelessWidget {
  // final int bookid;
  final List bookTitle;
  final List bookAuthor;
  final List bookGenre;

  // final String bookRFID;

  const ItemsList({
    Key? key,
    // required this.bookid,
    required this.bookTitle,
    required this.bookAuthor,
    required this.bookGenre,
    // required this.bookRFID,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Available Titles")),
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
          children: <Widget>[
            ProductBox(
              name: bookTitle[0],
              description: bookAuthor[0],
              price: bookGenre[0],
            ),
          ],
        ));
  }
}

class ProductBox extends StatelessWidget {
  const ProductBox(
      {Key? key,
      required this.name,
      required this.description,
      required this.price})
      : super(key: key);
  final String name;
  final String description;
  final String price;
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
                          Text(description),
                          Text("Price: " + price.toString()),
                        ],
                      )))
            ])));
  }
}
