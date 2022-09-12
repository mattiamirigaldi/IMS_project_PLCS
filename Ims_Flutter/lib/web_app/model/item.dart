import 'package:flutter/cupertino.dart';

class Item {
  final String id;
  final String rfid;
  final String title;
  final String author;
  final String urlImage;
  final Color color;
  final double price;
  final String description;
  final String location;
  final String category;
  final String avaflag;
  bool available;
  bool favorite;

  Item({
    required this.id,
    required this.rfid,
    required this.author,
    required this.title,
    required this.urlImage,
    required this.color,
    required this.price,
    required this.description,
    required this.avaflag,
    required this.available,
    required this.favorite,
    required this.location,
    required this.category,
  });
}
