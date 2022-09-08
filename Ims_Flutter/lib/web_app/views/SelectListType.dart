// ignore_for_file: file_names, use_key_in_widget_constructors, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:ims/web_app/DataLists.dart';
import 'package:ims/web_app/services/http_services.dart';

class SelectListType extends StatefulWidget {
  const SelectListType({Key? key}) : super(key: key);
  @override
  _ListUsersState createState() => _ListUsersState();
}

class _ListUsersState extends State<SelectListType> {
  // Global key that uniquely identifies the form widget and is used for validation
  final _formKey = GlobalKey<FormState>();

  static final List roles = [AllOperators[0]['id'].toString(), 'ALL'];

  late String dropdownvalue = 'ALL';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Available Items")),
        body: ListView(
          key: _formKey,
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              const SizedBox(width: 25),
              const Text(
                "Select the Branch (operator): ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              ),
              DropdownButton<String>(
                value: dropdownvalue,
                icon: const Icon(Icons.arrow_downward),
                underline: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      height: 5,
                      width: 100,
                      color: Colors.deepOrangeAccent),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },
                items: roles.map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: Text(value.toString())),
                    value: value,
                  );
                }).toList(),
              ),
            ]),
            const SizedBox(height: 50),
            InkWell(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: const Center(
                      child: Text("Search",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold))),
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.deepOrangeAccent),
                ),
                onTap: () async {
                  await Httpservices.List_Items_admin(dropdownvalue, context);
                }),
            for (var i = 0; i < AllItems.length; i++)
              ProductBox(
                title: AllItems[i]['title'],
                author: AllItems[i]['author'],
                genre: AllItems[i]['genre'],
                rfid: AllItems[i]['rfid'].toString(),
                date: AllItems[i]['date'].toString(),
                publisher: AllItems[i]['publisher'],
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
