// ignore_for_file: file_names, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:ims/web_app/DataLists.dart';
import 'package:ims/web_app/model/user.dart';
import 'package:ims/web_app/services/http_services.dart';
import 'package:ims/web_app/views/Operator/ModifyUserPage.dart';

class ListUsers extends StatefulWidget {
  const ListUsers({Key? key}) : super(key: key);
  @override
  _ListUsersState createState() => _ListUsersState();
}

List<String> branches = ['ALL'];
List<String> roles = ['operators', 'customers'];
String dropdownvalueBranch = 'ALL';
String dropdownvalueTable = roles[0];

class _ListUsersState extends State<ListUsers> {
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
            const Text("All users page")
          ])),
        ),
        body: ListView(
          key: _formKey,
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
          children: <Widget>[
            (TheWebUser[0]['role'] == 'admins')
                ? (selectBranch())
                : (const SizedBox(
                    height: 20,
                  )),
            //const SizedBox(height: 50),
            InkWell(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: const Center(
                      child: Text("Search",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20))),
                  height: 50,
                  width: 400,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blueGrey.withOpacity(0.4)),
                ),
                onTap: () async {
                  if (TheWebUser[0]['role'] == 'admins') {
                    await Httpservices.WebListUsers(
                        dropdownvalueTable, dropdownvalueBranch, context);
                  } else {
                    await Httpservices.WebListUsers(TheWebUser[0]['admin_id'],
                        TheWebUser[0]['branch'], context);
                  }
                }),
            for (var i = 0; i < AllUsers.length; i++)
              InkWell(
                  child: ProductBox(
                    firstname: AllUsers[i]['firstname'],
                    lastname: AllUsers[i]['lastname'],
                    username: AllUsers[i]['username'],
                    branch: AllUsers[i]['branch'],
                    rfid: AllUsers[i]['rfid'].toString(),
                  ),
                  onTap: () {
                    User user = User(
                      firstName: AllUsers[i]['firstname'],
                      lastname: AllUsers[i]['lastname'],
                      username: AllUsers[i]['username'],
                      mail: AllUsers[i]['mail'],
                      rfid: AllUsers[i]['rfid'].toString(),
                      imagePath:
                          'https://img.icons8.com/ios-filled/50/000000/user-male-circle.png',
                      role: dropdownvalueTable,
                      admin_id: AllUsers[i]['admin_id'].toString(),
                      news:
                          'He is often considered a "goofy" boss by the employees of Dunder Mifflin. He is often the butt of everybodies jokes. Michael constantly tries to intermix his work life with his social life by inviting employees of Dunder Mifflin to come over house or get coffee',
                      pwd: AllUsers[i]['pwd'],
                      opr_id: AllUsers[i]['opr_id'].toString(),
                      color: Color.fromARGB(255, 99, 181, 221),
                    );
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ModifyUserPage(user: user)));
                  }),
          ],
        ));
  }

  Row selectBranch() {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      selectTable(),
      const SizedBox(width: 35),
      const Text(
        "Select the Branch : ",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
      ),
      DropdownButton<String>(
        value: dropdownvalueBranch,
        icon: const Icon(Icons.arrow_downward),
        underline: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Container(
              alignment: Alignment.centerLeft,
              height: 5,
              width: 100,
              color: Colors.blueGrey),
        ),
        onChanged: (String? newValue) {
          setState(() {
            dropdownvalueBranch = newValue!;
          });
        },
        items: branches.map<DropdownMenuItem<String>>((String value) {
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

  Row selectTable() {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      const SizedBox(width: 35),
      const Text(
        "Select user type : ",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
      ),
      DropdownButton<String>(
        value: dropdownvalueTable,
        icon: const Icon(Icons.arrow_downward),
        underline: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Container(
              alignment: Alignment.centerLeft,
              height: 5,
              width: 100,
              color: Colors.blueGrey),
        ),
        onChanged: (String? newValue) {
          setState(() {
            dropdownvalueTable = newValue!;
          });
        },
        items: roles.map<DropdownMenuItem<String>>((String value) {
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
}

class ProductBox extends StatelessWidget {
  const ProductBox({
    Key? key,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.branch,
    required this.rfid,
  }) : super(key: key);
  final String firstname;
  final String lastname;
  final String username;
  final String branch;
  final String rfid;

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
                          Text(firstname,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          Text("lastname " + lastname),
                          Text("username: " + username),
                          Text("branch: " + branch),
                          Text("rfid: " + rfid),
                        ],
                      )))
            ])));
  }
}
