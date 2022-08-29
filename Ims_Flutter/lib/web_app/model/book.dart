import 'package:flutter/cupertino.dart';

class Book {
  final int id;
  final String title;
  final String author;
  final String urlImage;
  final Color color;
  final String price;
  final String description;
  final String location;
  bool available;
  bool favorite;

  Book ({
    required this.id,
    required this.author,
    required this.title,
    required this.urlImage,
    required this.color,
    required this.price,
    required this.description,
    required this.available,
    required this.favorite,
    required this.location,
  });

}

