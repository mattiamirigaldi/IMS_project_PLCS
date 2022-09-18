// ignore_for_file: file_names, use_key_in_widget_constructors, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:ims/web_app/DataLists.dart';
import 'package:ims/web_app/model/item.dart';
import 'package:ims/web_app/services/http_services.dart';
import 'package:ims/web_app/views/Operator/ModifyItemPage.dart';

class ListTotemsPage extends StatefulWidget {
  const ListTotemsPage({Key? key}) : super(key: key);
  @override
  _ListUsersState createState() => _ListUsersState();
}

String dropdownvalue = 'ALL';
List<String> branches = ['ALL'];

class _ListUsersState extends State<ListTotemsPage> {
  // Global key that uniquely identifies the form widget and is used for validation
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                  await Httpservices.webListTotems(dropdownvalue, context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ListTotemsPage()));
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
            for (var i = 0; i < AllTotems.length; i++)
              InkWell(
                child: ProductBox(
                  branch: AllTotems[i]['branch'],
                  macaddress: AllTotems[i]['macAddress'],
                ),
              ),
          ],
        ));
  }
}

class ProductBox extends StatelessWidget {
  const ProductBox({
    Key? key,
    required this.branch,
    required this.macaddress,
  }) : super(key: key);
  final String branch;
  final String macaddress;
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
                          Text(branch,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          Text(macaddress,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      )))
            ])));
  }
}
