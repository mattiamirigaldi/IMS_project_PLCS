// ignore_for_file: file_names

import 'package:flutter/material.dart';
//import 'package:ims/web_app/model/category.dart';
import 'package:ims/web_app/data/book_data.dart';
import 'package:ims/web_app/data/genre_data.dart';
import 'package:ims/web_app/model/category.dart';
import 'package:ims/web_app/model/item.dart';
import 'package:ims/web_app/views/CategoryPage.dart';
import 'package:ims/web_app/views/ItemPage.dart';

class CategoriesListPage extends StatefulWidget {

  const CategoriesListPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoriesListPage> createState() => _CategoriesListPageState();
}

class _CategoriesListPageState extends State<CategoriesListPage> {
  _CategoriesListPageState();
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
              const Text("Categories page")
            ])
          ),
        ),
        body: Column(children: <Widget>[
          const SizedBox(height : 30),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text("ALL CATEGORIES ".toUpperCase(),
                style:
                    TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color:  Colors.black.withOpacity(0.8))),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
              child: GridView.builder(
                itemCount: allCategory.length,         //HERE SHOULD BE USED LIST OF CATEGORIES
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 40,
                    crossAxisSpacing: 50,
                    childAspectRatio: 1.2),
                itemBuilder: (context, index) =>
                    buildCardItem(category: allCategory[index], context: context),
              ),
            ),
          )
        ]),
      );
}

Widget buildCardItem({required Category category, context}) => Container(
      child: Column(children: [
        Expanded(
          child: AspectRatio(
              aspectRatio: 4 / 3,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Material(
                    child: Ink.image(
                      image: NetworkImage(category.urlImage),
                      fit: BoxFit.contain,
                      child: InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GenrePage(genre: category.name)))),
                    ),
                  ))),
        ),
        const SizedBox(height: 4),
        Text(category.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ]),
    );
