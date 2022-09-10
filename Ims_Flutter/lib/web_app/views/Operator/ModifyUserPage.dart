import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ims/Mobile/User/UserSettings.dart';
import 'package:ims/web_app/model/user.dart';
import 'package:ims/web_app/views/components/profile_widget.dart';
//import 'package:ims/web_app/views/components/App_bar.dart';

class ModifyUserPage extends StatefulWidget {
  final User user;

  const ModifyUserPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ModifyUserPage> createState() => _ModifyUserPageState(user: user);
}

class _ModifyUserPageState extends State<ModifyUserPage> {
  final _formKey = GlobalKey<FormState>();
  final User user;
   late String newFirstName = user.firstName;
   late String newLastname = user.lastname;
   late String newUsername = user.username;
   late String newMail = user.mail;
   late String newRfid = user.rfid;
   late String newAdmin_id = user.admin_id;
   late String newOpr_id = user.opr_id;
   late String newImagePath = user.imagePath;
   late String newNews =  user.news;
   late String newPwd = user.pwd;
   late String newRole = user.role; 
  _ModifyUserPageState({required this.user});
  @override
  Widget build(BuildContext context) {
    // To get total height and width
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: user.color,
      appBar: AppBar(
        backgroundColor: user.color,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          // Container(
          //   padding: const EdgeInsets.all(10),
          //   child: CustomAppBar(userName: customer),
          //   //alignment: Alignment.topCenter,
          //   width: double.infinity,
          //   height: 150,
          // ),
          SizedBox(
            height: size.height,
            child: Stack(children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: size.height * 0.4),
                padding: EdgeInsets.only(
                    top: size.height * 0.12, left: 40, right: 40),
                height: 500,
                width: size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: size.height/5,
                        child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: TextFormField(
                              expands: true,
                              maxLines: null,
                              decoration: const InputDecoration(
                                labelText : "News",
                                labelStyle: TextStyle(
                                  fontSize: 28,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                border: OutlineInputBorder( ),
                                hintText: "Please insert some text",
                                hintStyle : TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal,
                                )
                              ),
                              initialValue : user.news,
                              onChanged: (value) {
                                newNews = value;
                             }
                          )
                        ),
                      ),
                      EditOrRemove()
                    ]),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: size.width*0.8,
                  height: 800,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      userData(size),
                      const SizedBox(width: 100),
                      UserIcon(size)
                    ]),
                ),
              )
            ]),
          )
        ]),
      ),
    );
  }

  Container UserIcon(Size size) {
    return Container(
      width: size.width*0.25,
      child: Hero(
        tag: "${user.username}",
        child: Stack(
          //alignment: Alignment.bottomCenter,
          children: [
            ClipOval(
              child: Material(
                color: Colors.transparent,
                child: Ink.image(
                  image: NetworkImage(user.imagePath),
                  width: 100,
                  height: 100,
                  // to create a splash effect when image clicked
                  child: InkWell(onTap: () {}), //Neded the rerout for change image
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 50,
              child: ClipOval(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(2),
                  child: Icon( 
                    Icons.edit,
                    size: 20,),
                ),
              ),
            )
        ],)
      )
    );
  }


  Container userData(Size size) {
    return Container(
              height: 800,
              width: size.width * 0.2,
              margin: const EdgeInsets.only(left: 100, right: 100),
              child : Form(
                child: Column (
                  children: <Widget>[
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        labelText: "First name",
                        labelStyle: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        ),
                        border: OutlineInputBorder( ),
                        hintText: "Please insert some text",
                        hintStyle : TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                    )
                    ),
                    initialValue: user.firstName,
                    onChanged: (value) {
                      newFirstName = value;
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        labelText: " Last name",
                        labelStyle: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        ),
                        border: OutlineInputBorder( ),
                        hintText: "Please insert some text",
                        hintStyle : TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                    )
                    ),
                    initialValue: user.lastname,
                    onChanged: (value) {
                      newLastname = value;
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        labelText: "Email",
                        labelStyle: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        ),
                        border: OutlineInputBorder( ),
                        hintText: "Please insert some text",
                        hintStyle : TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                    )
                    ),
                    initialValue: user.mail,
                    onChanged: (value) {
                      newMail = value;
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        labelText: " RFID ",
                        labelStyle: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        ),
                        border: OutlineInputBorder( ),
                        hintText: "Please insert some text",
                        hintStyle : TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                    )
                    ),
                    initialValue: user.rfid,
                    onChanged: (value) {
                      newRfid = value;
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    ),
                  ]
                ),
              ),
            );
  }
 
  Container EditOrRemove() {
    return Container(
      height: 140,
      child:
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        saveButton(),
        const SizedBox(width: 150),
        deleteButton(),
      ]),
    );
  }

   ClipRRect saveButton() {
    return ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
               decoration: const BoxDecoration(
                 gradient: LinearGradient(
                          colors: <Color>[
                            Color.fromARGB(255, 13, 161, 50),
                            Color.fromARGB(255, 18, 143, 70),
                            Color.fromARGB(255, 26, 165, 26),
                          ],
                  ),
              ),
              )
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                primary: Colors.white,
                textStyle: const TextStyle(fontSize: 20),
              ),
              child: Text("SAVE CHANGES"),
              onPressed: () async {
                setState(() {
                  if (_formKey.currentState != null) {
                        if (_formKey.currentState!.validate()) {
                          // await Httpservices.register(firstName, lastName,
                          //     username, email, password, context);
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //     const SnackBar(
                          //         content: Text("Register Success")));
                      }
                  } else {}
                    EasyLoading.showSuccess("NEEDED SAVE HTTP METHOD");
                });
              }
            )
          ],
        ),
      );
  }


  ClipRRect deleteButton() {
    return ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
               decoration: const BoxDecoration(
                 gradient: LinearGradient(
                          colors: <Color>[
                            Color.fromARGB(255, 161, 18, 13),
                            Color.fromARGB(255, 210, 65, 25),
                            Color.fromARGB(255, 245, 117, 66),
                          ],
                  ),
              ),
              )
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                primary: Colors.white,
                textStyle: const TextStyle(fontSize: 20),
              ),
              child: Text("DELETE IT"),
              onPressed: () {
                setState(() {
                    EasyLoading.showSuccess("NEEDED DELETE HTTP METHOD");
                });
              }
            )
          ],
        ),
      );
  }
}
