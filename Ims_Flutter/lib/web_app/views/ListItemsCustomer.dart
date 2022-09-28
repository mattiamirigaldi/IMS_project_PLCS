// ignore_for_file: file_names, use_key_in_widget_constructors, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:ims/web_app/DataLists.dart';
import 'package:ims/web_app/model/item.dart';
import 'package:ims/web_app/views/ItemPage.dart';

class ListItemsCustomer extends StatelessWidget {
  const ListItemsCustomer();
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
        appBar: AppBar(
          title: (Row(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: const Image(
                image: AssetImage("images/ims.jpg"),
                width: 45,
                height: 45,
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            const Text("All items page")
          ])),
        ),
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
          children: <Widget>[
            for (var i = 0; i < AllItems.length; i++)
              InkWell(
                child: ProductBox(
                  title: AllItems[i]['title'],
                  author: AllItems[i]['author'],
                  genre: AllItems[i]['genre'],
                  publisher: AllItems[i]['publisher'],
                  availability: avaflag[i],
                ),
                onTap: () {
                  Item item = Item(
                      id: AllItems[i]['id'].toString(),
                      rfid: AllItems[i]['rfid'].toString(),
                      author: AllItems[i]['author'],
                      title: AllItems[i]['title'],
                      // urlImage: AllItems[i]['imagePath'],
                      urlImage: AllItems[i]['image'],
                      color: Color.fromARGB(255, 236, 234, 152),
                      price: 20.0,
                      description: AllItems[i]['description'],
                      avaflag: avaflag[i],
                      available: (avaflag[i] == 'yes'),
                      favorite: false,
                      location: AllItems[i]['loc'],
                      category: AllItems[i]['genre']);
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 350),
                          pageBuilder: (context, __, ___) =>
                              ItemPage(item: item)));
                },
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
    required this.publisher,
    required this.availability,
  }) : super(key: key);
  final String title;
  final String author;
  final String genre;
  final String publisher;
  final String availability;

  @override
  Widget build(BuildContext context) {
    late String TextToShow;
    TextStyle sty1;
    if (availability == 'yes') {
      TextToShow = "Book is Avalible";
      sty1 = const TextStyle(fontWeight: FontWeight.bold, color: Colors.green);
    } else {
      TextToShow = "Rented by another Customer";
      sty1 = const TextStyle(fontWeight: FontWeight.bold, color: Colors.red);
    }
    return Container(
        padding: const EdgeInsets.all(2),
        height: 170,
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
                          Text("Author: " + author),
                          Text("Genre: " + genre),
                          Text("Publisher: " + publisher),
                          Text(TextToShow, style: sty1),
                        ],
                      )))
            ])));
  }
}
