// ignore_for_file: file_names, use_key_in_widget_constructors, non_constant_identifier_names
import 'DataLists.dart';
import 'package:flutter/material.dart';

class ListItems extends StatelessWidget {
  const ListItems();
  static late List avaflag = [];
  @override
  Widget build(BuildContext context) {
    avaflag.clear();
    for (var i = 0; i < AllItems.length; i++) {
      if (AllItems[i]['cus_id'] == null) {
        avaflag.add('yes');
      } else {
        avaflag.add(AllItems[i]['cus_id'].toString());
      }
    }
    return Scaffold(
        appBar: AppBar(title: const Text("Available Titles")),
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
          children: <Widget>[
            for (var i = 0; i < AllItems.length; i++)
              ProductBox(
                name: AllItems[i]['name'],
                category: AllItems[i]['category'],
                location: AllItems[i]['loc'],
                rfid: AllItems[i]['rfid'].toString(),
                availability: avaflag[i],
              ),
          ],
        ));
  }
}

class ProductBox extends StatelessWidget {
  const ProductBox({
    Key? key,
    required this.name,
    required this.category,
    required this.location,
    required this.rfid,
    required this.availability,
  }) : super(key: key);
  final String name;
  final String category;
  final String location;
  final String rfid;
  final String availability;

  @override
  Widget build(BuildContext context) {
    late String TextToShow;
    TextStyle sty1;
    if (availability == 'yes') {
      TextToShow = "Book is Avalible";
      sty1 = const TextStyle(fontWeight: FontWeight.bold, color: Colors.green);
    } else {
      TextToShow = "Rented by user " + availability;
      sty1 = const TextStyle(fontWeight: FontWeight.bold, color: Colors.red);
    }
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
                          Text("Category: " + category),
                          Text("Location: " + location),
                          Text("RFID: " + rfid),
                          Text(TextToShow, style: sty1),
                        ],
                      )))
            ])));
  }
}
