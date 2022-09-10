// ignore_for_file: file_names, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:ims/web_app/DataLists.dart';
import 'package:ims/web_app/model/item.dart';
import 'package:ims/web_app/views/Operator/ModifyItemPage.dart';

class ListItems extends StatelessWidget {
  const ListItems();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: (
            Row(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: const Image(
                  image: AssetImage("images/ims.jpg"),
                  width: 45,
                  height: 45,
                ),
              ),
              const SizedBox(width: 30,),
              const Text("All items page")
            ])
          ),
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
                  rfid: AllItems[i]['rfid'].toString(),
                  date: AllItems[i]['date'].toString(),
                  publisher: AllItems[i]['publisher'],
                ),
                onTap: () {
                  Item item = Item(
                    id: AllItems[i]['rfid'].toString(),
                    author: AllItems[i]['author'], 
                    title: AllItems[i]['title'], 
                   // urlImage: AllItems[i]['urlImage'],
                    urlImage: 'https://thumbs.dreamstime.com/z/old-mystery-book-icon-outline-style-old-mystery-book-icon-outline-old-mystery-book-vector-icon-web-design-isolated-white-198523618.jpg',
                    color: Color.fromARGB(255, 211, 255, 89),
                    price: 20.0, 
                    description: "NEEDED TO BE ADD IN BACKEDN",
                    available: true, 
                    favorite: false, 
                    location: "NEEDED TO BE ADD IN BACKED", 
                    category: AllItems[i]['genre']
                  );
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ModifyItemPage(item: item)));
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
    // String TextToShow;
    // if (Avalible == null) {
    //   TextToShow = "Book is not Avalible";
    // } else {
    //   TextToShow = "Location is: " + Location;
    // }
    // ;
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
                          Text("By " + author),
                          Text("Genre: " + genre),
                          Text("RFID: " + rfid),
                          Text("date: " + date),
                          Text("Publisher: " + publisher),
                        ],
                      )))
            ])));
  }
}
