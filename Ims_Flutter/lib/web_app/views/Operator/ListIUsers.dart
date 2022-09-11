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

class _ListUsersState extends State<ListUsers> {
  // Global key that uniquely identifies the form widget and is used for validation
  final _formKey = GlobalKey<FormState>();
  late String rl = "customers";
  late String userRole;
  static const _rolesOp = [
    "customers",
  ];
  static const _rolesAdm = ["operators"];
  late List<String> _roles = [];
  String dropdownvalue = _rolesOp[0];

  @override
  Widget build(BuildContext context) {
    if (TheWebUser[0]['role'] == 'operators') {
      _roles = _rolesOp;
    } else if (TheWebUser[0]['role'] == 'admins') {
      _roles = _rolesOp + _rolesAdm;
    }
    double width_screen = MediaQuery.of(context).size.width;
    double height_screen = MediaQuery.of(context).size.height;
    return Scaffold(
<<<<<<< HEAD
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
              const Text("All users page")
            ])
          ),
=======
        appBar: AppBar(
          title: (Row(children: const [
            ClipRect(
              child: Image(
                image: AssetImage("images/ims.jpg"),
                width: 45,
                height: 45,
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Text("Available users page")
          ])),
>>>>>>> 3ad2498e8695755bdddf5bca85f40de523d40c56
        ),
        body: ListView(
          key: _formKey,
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              const SizedBox(width: 35),
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
                      color: Colors.blueGrey),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                    rl = dropdownvalue;
                    userRole = newValue;
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
                  child: Center(
                      child: Text("Search " + dropdownvalue.toLowerCase(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
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
                      imagePath:
                          'https://img.icons8.com/ios-filled/50/000000/user-male-circle.png',
                      role: userRole,
                      admin_id: AllUsers[i]['admin_id'].toString(),
                      news:
                          'He is often considered a "goofy" boss by the employees of Dunder Mifflin. He is often the butt of everybodies jokes. Michael constantly tries to intermix his work life with his social life by inviting employees of Dunder Mifflin to come over house or get coffee',
                      pwd: AllUsers[i]['pwd'],
                      opr_id: AllUsers[i]['opr_id'].toString(),
                      color: Color.fromARGB(255, 99, 181, 221),
                    );
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ModifyUserPage(user: user)));
                  }),
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
