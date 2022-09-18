// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:ims/web_app/DataLists.dart';
import 'package:ims/web_app/services/http_services.dart';
import 'package:ims/web_app/views/Operator/AddBookRFID.dart';

class AddTotemPage extends StatefulWidget {
  const AddTotemPage({Key? key}) : super(key: key);
  @override
  _GenreListState createState() => _GenreListState();
}

// _RegisterPageState inherits the state of RegisterPage
class _GenreListState extends State<AddTotemPage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form
  final _formKey = GlobalKey<FormState>();
  // Register form data
  late String branch;
  late String NewBranchName;
  late String MacAddress;

  late List<String> _branch = [];
  static List<String> branchlist = [];
  static late String dropdownvaluebranch = 'New Branch';

  @override
  Widget build(BuildContext context) {
    branchlist.clear();
    for (var i = 0; i < AllBranches.length; i++) {
      branchlist.add(AllBranches[i]);
    }
    branchlist.add('New Branch');
    _branch = branchlist;
    double width_screen = MediaQuery.of(context).size.width;
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
            const Text("Register new Totem page")
          ])),
        ),
        body: Center(
          child: SizedBox(
            width: width_screen * 0.7,
            child: Form(
              key: _formKey,
              child: ListView(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: Center(
                        child: Text(
                          "Totem details".toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.7)),
                          textAlign: TextAlign.center,
                          textScaleFactor: 3,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "xx:xx:xx:xx:xx:xx",
                          labelText: 'mac address',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            MacAddress = value;
                          });
                        },
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    selectBranch(),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                        child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: const Center(
                                child: Text("SUBMIT NEW TOTEM",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20))),
                            height: 60,
                            width: width_screen * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                colors: <Color>[
                                  Color.fromARGB(255, 22, 78, 163),
                                  Color(0xFF1976D2),
                                  Color.fromARGB(255, 36, 121, 190),
                                ],
                              ),
                            )),
                        onTap: () async {
                          if (_formKey.currentState != null) {
                            if (_formKey.currentState!.validate()) {
                              if (branch == 'New Branch') {
                                ShowPopUp();
                              } else {
                                await Httpservices.webAddTotem(
                                    branch, MacAddress, context);
                              }
                            }
                          } else {}
                        })
                  ]),
            ),
          ),
        ));
  }

  Row selectBranch() {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      const SizedBox(width: 25),
      const Text(
        "Select branch : ",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
      ),
      DropdownButton<String>(
        value: dropdownvaluebranch,
        icon: const Icon(Icons.arrow_downward),
        underline: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Container(
              alignment: Alignment.centerLeft,
              height: 5,
              width: 100,
              color: Colors.lightBlue),
        ),
        onChanged: (String? newValue) {
          setState(() {
            dropdownvaluebranch = newValue!;
            branch = dropdownvaluebranch;
          });
        },
        items: _branch.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Text(value)),
            value: value,
          );
        }).toList(),
      ),
    ]);
  }

  Future ShowPopUp() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Enter name of the New Branch'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  NewBranchName = value;
                });
              },
              decoration: const InputDecoration(
                  hintText: "ex: branch_x, branch_y, ..."),
            ),
            actions: <Widget>[
              TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white)),
                child: const Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 68, 156, 71)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white)),
                child: const Text('OK'),
                onPressed: () {
                  setState(() async {
                    await Httpservices.webAddTotem(
                        NewBranchName, MacAddress, context);
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
