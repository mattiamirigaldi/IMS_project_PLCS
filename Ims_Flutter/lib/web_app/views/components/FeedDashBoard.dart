import 'package:flutter/material.dart';
import 'package:ims/Web_app/model/book.dart';
import 'package:ims/Web_app/data/book_data.dart';
import 'package:ims/Web_app/model/genre.dart';
import 'package:ims/Web_app/data/genre_data.dart';
import 'package:ims/Web_app/views/GenrePage.dart';
import 'package:ims/Web_app/views/ItemPage.dart';


class FeedDashBoard extends StatefulWidget {
  const FeedDashBoard({Key? key}) : super(key: key);

  @override
  State<FeedDashBoard> createState() => _FeedDashBoardState();
}

class _FeedDashBoardState extends State<FeedDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      const Text(
        "All items", 
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueGrey) 
      ),
      Container(
        height: 250,
        child: ListView.separated(
          padding: EdgeInsets.all(22),
          scrollDirection: Axis.horizontal,
          itemCount: allBooks.length,
          separatorBuilder: (context, _) => SizedBox(width: 15),
          itemBuilder: (context, index) => buildCardItem(item: allBooks[index], context: context) 
        )
      ),
      Text(
        "Search by genre", 
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueGrey) 
      ),
      Container(
        height: 250,
        child: ListView.separated(
          padding: EdgeInsets.all(22),
          scrollDirection: Axis.horizontal,
          itemCount: allGenre.length,
          separatorBuilder: (context, _) => SizedBox(width: 15),
          itemBuilder: (context, index) => buildCardGenre(item: allGenre[index], context: context) 
        )
      ) 
    ]);
  }
}


Widget buildCardItem( {required Book item, context }) => Container(
  width : 220,
  child: Column(children: [
    Expanded(
      child: AspectRatio (
        aspectRatio: 4/3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Material(
            child: Ink.image(
              image: NetworkImage(item.urlImage),
              fit: BoxFit.fill,
              child: InkWell(
                onTap: () => Navigator.push(context,
                 MaterialPageRoute(builder: (context) => ItemPage(item: item)))
              ),
              
              ),
          )
        )
      ),
    ),
    const SizedBox(height: 4),
    Text(item.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    Text(item.author, style: TextStyle(fontSize: 20, color: Colors.grey))
  ]),
); 

Widget buildCardGenre( {required Genre item, context }) => Container(
  width : 200,
  child: Column(children: [
    Expanded(
      child: AspectRatio (
        aspectRatio: 4/3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Material(
            child: Ink.image(
              image: NetworkImage(item.urlImage),
              //height: 150,
              //width: 150,
              fit: BoxFit.fill,
              child: InkWell(
                onTap: () => Navigator.push(context,
                 MaterialPageRoute(builder: (context) => GenrePage(genre : item.name)))
              ),
              
              ),
          )
        )
      ),
    ),
    const SizedBox(height: 4),
    Text(item.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
  ]),
); 
