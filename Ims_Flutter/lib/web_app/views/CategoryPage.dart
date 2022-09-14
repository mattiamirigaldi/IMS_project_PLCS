// ignore_for_file: file_names

import 'package:flutter/material.dart';
//import 'package:ims/web_app/model/category.dart';
import 'package:ims/web_app/data/book_data.dart';
import 'package:ims/web_app/model/item.dart';
import 'package:ims/web_app/views/ItemPage.dart';

class GenrePage extends StatefulWidget {
  final String genre;

  const GenrePage({
    Key? key,
    required this.genre,
  }) : super(key: key);

  @override
  State<GenrePage> createState() => _GenrePageState(genre: genre);
}

class _GenrePageState extends State<GenrePage> {
  final String genre;
  _GenrePageState({required this.genre});
  @override
  Widget build(BuildContext context) => Scaffold(
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
              Text(genre+" items")
            ])
          ),
        ),
        body: Column(children: <Widget>[
          // Container(
          //   padding: const EdgeInsets.all(10),
          //   child: CustomAppBar(userName: customer),
          //   //alignment: Alignment.topCenter,
          //   width: double.infinity,
          //   height: 150,
          // ),
          const SizedBox(height : 30),
          RichText(
            text: TextSpan(children: [
              const TextSpan(
                text: "All items that are ",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal, color:  Colors.black)
              ),
              TextSpan(
                text: genre.toUpperCase(),
                style: 
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black54)
              )
            ]),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
              child: GridView.builder(
                itemCount: allItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 40,
                    crossAxisSpacing: 50,
                    childAspectRatio: 1.2),
                itemBuilder: (context, index) =>
                    buildCardItem(item: allItems[index], context: context),
              ),
            ),
          )
        ]),
      );
}

Widget buildCardItem({required Item item, context}) => Container(
      child: Column(children: [
        Expanded(
          child: AspectRatio(
              aspectRatio: 4 / 3,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Material(
                    child: Ink.image(
                      image: NetworkImage(item.urlImage),
                      fit: BoxFit.cover,
                      child: InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ItemPage(item: item)))),
                    ),
                  ))),
        ),
        const SizedBox(height: 4),
        Text(item.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text(item.author,
            style: const TextStyle(fontSize: 20, color: Colors.grey))
      ]),
    );
