// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:ims/web_app/data/book_data.dart';
import 'package:ims/web_app/model/item.dart';
import 'package:ims/web_app/views/ItemPage.dart';

class FavoriteItemsPage extends StatefulWidget {

  const FavoriteItemsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoriteItemsPage> createState() => _FavoriteItemsPageState();
}

class _FavoriteItemsPageState extends State<FavoriteItemsPage> {
  _FavoriteItemsPageState();
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Favorite items")),
        body: Column(children: <Widget>[
          // Container(
          //   padding: const EdgeInsets.all(10),
          //   child: CustomAppBar(userName: customer),
          //   //alignment: Alignment.topCenter,
          //   width: double.infinity,
          //   height: 150,
          // ),
          const SizedBox(height : 30),
          Text("Your favorite items ",
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
              child: GridView.builder(
                itemCount: allItems.length,            // HERE SHOULD BE USED A LIS OF PREFERRED ITEMS
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
