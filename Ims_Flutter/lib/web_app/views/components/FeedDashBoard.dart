// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ims/web_app/DataLists.dart';
import 'package:ims/web_app/model/item.dart';
//import 'package:ims/web_app/data/book_data.dart';
import 'package:ims/web_app/model/category.dart';
import 'package:ims/web_app/data/genre_data.dart';
import 'package:ims/web_app/views/CategoryPage.dart';
import 'package:ims/web_app/services/http_services.dart';
import 'package:ims/web_app/views/ItemPage.dart';
import 'package:ims/web_app/views/ListItemsAdmin.dart';
import 'package:ims/web_app/views/ListItemsCustomer.dart';
import 'package:ims/web_app/views/ListItemsGuest.dart';
import 'package:ims/web_app/views/Operator/ListItemsOperator.dart';

class FeedDashBoard extends StatefulWidget {
  const FeedDashBoard({Key? key}) : super(key: key);

  @override
  State<FeedDashBoard> createState() => _FeedDashBoardState();
}

class _FeedDashBoardState extends State<FeedDashBoard> {
  static late List<Item> allitemslist = <Item>[];

  @override
  Widget build(BuildContext context) {
    allitemslist.clear();
    for (var i = 0; i < AllItems.length; i++) {
      allitemslist.add(Item(
          id: AllItems[i]['id'].toString(),
          rfid: AllItems[i]['rfid'].toString(),
          author: AllItems[i]['author'],
          title: AllItems[i]['title'],
          urlImage: AllItems[i]['image'],
          color: Color.fromARGB(255, 38, 145, 87),
          price: 20.0,
          description: AllItems[i]['description'],
          avaflag: "avaflag[i]",
          available: (AllItems[i]['cus_id'] == null),
          favorite: false,
          location: AllItems[i]['loc'],
          category: AllItems[i]['genre']));
    }
    return Column(children: <Widget>[
      InkWell(
        onTap: () async {
          await EasyLoading.showError("The number of available items is : " +
              allitemslist.length.toString());
          if (TheWebUser[0]['role'] == 'customers') {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ListItemsCustomer()));
          } else if (TheWebUser[0]['role'] == 'operators') {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ListItemsOperator()));
          } else if (TheWebUser[0]['role'] == 'admins') {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ListItemsAdmin()));
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ListItemsGuest()));
          }
        },
        child: const Center(
          child: Text("All items",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey)),
        ),
      ),
      SizedBox(
          height: 250,
          child: ListView.separated(
              padding: const EdgeInsets.all(22),
              scrollDirection: Axis.horizontal,
              itemCount: allitemslist.length,
              separatorBuilder: (context, _) => const SizedBox(width: 15),
              itemBuilder: (context, index) =>
                  buildCardItem(item: allitemslist[index], context: context))),
      const Text("Search by category",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey)),
      SizedBox(
          height: 250,
          child: ListView.separated(
              padding: const EdgeInsets.all(22),
              scrollDirection: Axis.horizontal,
              itemCount: allCategory.length,
              separatorBuilder: (context, _) => const SizedBox(width: 15),
              itemBuilder: (context, index) => buildCardCategory(
                  item: allCategory[index], context: context)))
    ]);
  }
}

Widget buildCardItem({required Item item, context}) => SizedBox(
      width: 220,
      child: Column(children: [
        Expanded(
          child: AspectRatio(
              aspectRatio: 4 / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Material(
                  child: Ink.image(
                    image: NetworkImage(item.urlImage),
                    fit: BoxFit.fill,
                    child: InkWell(
                        onTap: () => Navigator.push(
                            context,
                            PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 350),
                                pageBuilder: (context, __, ___) =>
                                    ItemPage(item: item)))),
                  ),
                ),
              )),
        ),
        const SizedBox(height: 4),
        Text(item.title,
            style: const TextStyle(
              fontSize: 18,
            )),
        Text(item.author,
            style: const TextStyle(fontSize: 20, color: Colors.grey))
      ]),
    );

Widget buildCardCategory({required Category item, context}) => SizedBox(
      width: 200,
      child: Column(children: [
        Expanded(
          child: AspectRatio(
              aspectRatio: 4 / 3,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Material(
                    child: Ink.image(
                      image: NetworkImage(item.urlImage),
                      //height: 150,
                      //width: 150,
                      fit: BoxFit.fill,
                      child: InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      GenrePage(genre: item.name)))),
                    ),
                  ))),
        ),
        const SizedBox(height: 4),
        Text(item.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
      ]),
    );
