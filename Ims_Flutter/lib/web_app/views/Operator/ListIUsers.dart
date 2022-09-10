// ignore_for_file: file_names, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:ims/web_app/DataLists.dart';
import 'package:ims/web_app/model/user.dart';
import 'package:ims/web_app/services/http_services.dart';
import 'package:ims/web_app/views/Operator/RemoveCustomerPage.dart';
import 'package:ims/web_app/views/Operator/ModifyUserPage.dart';

class ListUsers extends StatefulWidget {
  const ListUsers({Key? key}) : super(key: key);
  @override
  _ListUsersState createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
  // Global key that uniquely identifies the form widget and is used for validation
  final _formKey = GlobalKey<FormState>();
  late String rl = "customers";
  static const _roles = ["customers", "operators"];
  String dropdownvalue = _roles[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Available Users")),
        body: ListView(
          key: _formKey,
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              const SizedBox(width: 25),
              const Text(
                "Select user type : ",
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
                    rl = dropdownvalue;
                  });
                },
                items: _roles.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: Text(value)),
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
                  await Httpservices.WebListCustomers(rl, context);
                }),
            for (var i = 0; i < AllUsers.length; i++)
              InkWell(
                child: ProductBox(
                  firstname: AllUsers[i]['firstname'],
                  lastname: AllUsers[i]['lastname'],
                  username: AllUsers[i]['username'],
                  mail: AllUsers[i]['mail'],
                  rfid: AllUsers[i]['rfid'].toString(),
                ),
                onTap: () {
                  User user = User(
                  firstName: AllUsers[i]['firstname'],
                  lastname: AllUsers[i]['lastname'],
                  username: AllUsers[i]['username'],
                  mail: AllUsers[i]['mail'],
                  rfid: AllUsers[i]['rfid'].toString(), 
                  imagePath: 'https://img.icons8.com/ios-filled/50/000000/user-male-circle.png',
                  role: "customer",
                  admin_id: AllUsers[i]['admin_id'].toString(),
                  news:  'He is often considered a "goofy" boss by the employees of Dunder Mifflin. He is often the butt of everybodies jokes. Michael constantly tries to intermix his work life with his social life by inviting employees of Dunder Mifflin to come over house or get coffee',
                  pwd: AllUsers[i]['pwd'],
                  opr_id: AllUsers[i]['opr_id'].toString(),
                  color: Color.fromARGB(255, 99, 181, 221),
                  );
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ModifyUserPage(user :user)));
                } 
              ),
          ],
        ));
  }
}

class ProductBox extends StatelessWidget {
  const ProductBox({
    Key? key,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.mail,
    required this.rfid,
  }) : super(key: key);
  final String firstname;
  final String lastname;
  final String username;
  final String mail;
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
                          Text("mail: " + mail),
                          Text("rfid: " + rfid),
                        ],
                      )))
            ])));
  }
}
