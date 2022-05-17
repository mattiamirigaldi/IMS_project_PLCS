import 'package:flutter/material.dart';
import './../services/http_services.dart';

class ItemsList extends StatelessWidget {
  // final int bookid;
  final String bookTitle;
  final String bookAuthor;
  final String bookGenre;

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
        appBar: AppBar(title: const Text("Book list")),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                  child: Text(
                      "Title: $bookTitle  -  Author : $bookAuthor - Genre : $bookGenre",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textScaleFactor: 2)),
            ]));
  }
}
