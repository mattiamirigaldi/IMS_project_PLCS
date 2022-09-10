// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ims/web_app/DataLists.dart';
import 'package:ims/web_app/services/http_services.dart';
//import 'package:ims/web_app/data/user_data.dart';
import 'package:ims/web_app/views/Operator/AddCustomerRFID.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({Key? key}) : super(key: key);
  @override
  _GenreListState createState() => _GenreListState();
}

// _RegisterPageState inherits the state of RegisterPage
class _GenreListState extends State<AddCustomer> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form
  final _formKey = GlobalKey<FormState>();
  // Register form data
  late String email;
  late String firstName;
  late String lastName;
  late String username;
  late String password;
  late String user_chk_flag;
  //late User newUser;
  late String role = "customers";
  static const _rolesOp = [
    "customers",
  ];
  static const _rolesAdm = [
    "operators"
  ];
  late List<String> _roles = [];
  String dropdownvalue = _rolesOp[0];

  @override
  Widget build(BuildContext context) {
    if (TheWebUser[0]['role'] == 'operators') {
      _roles = _rolesOp;
    } else if (TheWebUser[0]['role'] == 'operators') {
      _roles = _rolesOp + _rolesAdm;
    } 
    double width_screen = MediaQuery.of(context).size.width;
    double height_screen = MediaQuery.of(context).size.height;
    return Scaffold(
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
              const Text("Register new user page")
            ])
          ),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Center(
                    child: Text(
                      "User details",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.7)),
                      textAlign: TextAlign.center,
                      textScaleFactor: 3,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Enter first name",
                      labelText: 'First Name',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        firstName = value;
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Enter last name",
                      labelText: 'Last Name',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        lastName = value;
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: "Enter username",
                        labelText: 'Username',
                        border: OutlineInputBorder()),
                    onChanged: (value) async {
                      setState(() {
                        username = value;
                      });
                      user_chk_flag = await Httpservices.webAddCustomerCheck(
                          role, username);
                      //if (user_chk_flag ==
                      //    "the entered username is used before") {
                      //  await EasyLoading.showInfo(user_chk_flag);
                      //}
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please enter some text';
                      } else if (user_chk_flag ==
                          "the entered username is used before") {
                        return user_chk_flag;
                      } else {}
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: "Enter email address",
                        labelText: 'Email',
                        border: OutlineInputBorder()),
                    onChanged: (value) {
                      setState(() {
                        email = value;
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: "Enter password",
                        labelText: 'Password',
                        border: OutlineInputBorder()),
                    onChanged: (value) {
                      setState(() {
                        password = value;
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: "Confirm password",
                        labelText: 'Password validation',
                        border: OutlineInputBorder()),
                    validator: (String? value) {
                      if (value != password) {
                        return 'Password is not correct';
                      }
                      return null;
                    },
                  ),
                ),
                selectRole(),
                const SizedBox(height: 20,),
                InkWell(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: const Center(
                          child: Text("SUBMIT NEW USER",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))),
                      height: 60,
                      width: width_screen*0.6,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                          colors: <Color>[
                            Color.fromARGB(255, 22, 78, 163),
                            Color(0xFF1976D2),
                            Color.fromARGB(255, 36, 121, 190),
                          ],
                        ),
                      )
                    ),
                    onTap: () async {
                      if (_formKey.currentState != null) {
                        if (_formKey.currentState!.validate()) {
                          if (user_chk_flag == "username is valid") {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Register user data")));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TAddCustomerRFID(
                                          firstName: firstName,
                                          lastName: lastName,
                                          username: username,
                                          email: email,
                                          password: password,
                                          role: role,
                                          context: context,
                                        )));
                          } else {
                            await EasyLoading.showError(
                                "please change the entered username");
                          }
                        }
                      } else {}
                    })
              ]),
        ));
  }

  Row selectRole() {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      const SizedBox(width: 25),
      const Text(
        "Select role : ",
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
              color: Colors.lightBlue),
        ),
        onChanged: (String? newValue) {
          setState(() {
            dropdownvalue = newValue!;
            role = dropdownvalue;
          });
        },
        items: _roles.map<DropdownMenuItem<String>>((String value) {
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
