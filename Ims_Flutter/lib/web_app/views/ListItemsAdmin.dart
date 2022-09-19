// ignore_for_file: file_names, use_key_in_widget_constructors, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:ims/web_app/DataLists.dart';
import 'package:ims/web_app/model/item.dart';
import 'package:ims/web_app/services/http_services.dart';
import 'package:ims/web_app/views/Operator/ModifyItemPage.dart';

class ListItemsAdmin extends StatefulWidget {
  const ListItemsAdmin({Key? key}) : super(key: key);
  @override
  _ListUsersState createState() => _ListUsersState();
}

String dropdownvalue = 'ALL';
List<String> branches = ['ALL'];

class _ListUsersState extends State<ListItemsAdmin> {
  // Global key that uniquely identifies the form widget and is used for validation
  final _formKey = GlobalKey<FormState>();
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
    branches.clear();
    branches.add('ALL');
    for (var i = 0; i < AllBranches.length; i++) {
      branches.add(AllBranches[i]);
    }
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
                onChanged: (String? newValue) async {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                  await Httpservices.List_Items(dropdownvalue, context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ListItemsAdmin()));
                },
                items: branches.map<DropdownMenuItem<String>>((value) {
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
            const SizedBox(height: 20),
            for (var i = 0; i < AllItems.length; i++)
              InkWell(
                child: ProductBox(
                  name: AllItems[i]['name'],
                  category: AllItems[i]['category'],
                  location: AllItems[i]['branch'],
                  rfid: AllItems[i]['rfid'].toString(),
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
                      color: Color.fromARGB(255, 211, 255, 89),
                      price: 20.0,
                      description: AllItems[i]['description'],
                      avaflag: avaflag[i],
                      available: (avaflag[i] == 'yes'),
                      favorite: false,
                      location: AllItems[i]['loc'],
                      category: AllItems[i]['genre']);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ModifyItemPage(item: item)));
                },
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
                          Text("Branch: " + location),
                          Text("RFID: " + rfid),
                          Text(TextToShow, style: sty1),
                        ],
                      )))
            ])));
  }
}
