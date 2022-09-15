import 'package:flutter/material.dart';
import 'package:ims/web_app/model/user.dart';
import 'package:ims/web_app/services/http_services.dart';
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
  late String newAdminId = user.admin_id;
  late String newOprId = user.opr_id;
  late String newImagePath = user.imagePath;
  late String newNews = user.news;
  late String newPwd = user.pwd;
  late String userRole = user.role;
  late String oldUsername = user.username;
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
              const Text("Modify item page")
            ])
          ),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          const Divider(),
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
                height: 400,
                width: size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: size.height / 5,
                        child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: TextFormField(
                                expands: true,
                                maxLines: null,
                                decoration: const InputDecoration(
                                    labelText: "News",
                                    labelStyle: TextStyle(
                                      fontSize: 28,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    border: OutlineInputBorder(),
                                    hintText: "Please insert some text",
                                    hintStyle: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal,
                                    )),
                                initialValue: user.news,
                                onChanged: (value) {
                                  newNews = value;
                                })),
                      ),
                      editOrRemove()
                    ]),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: size.width * 0.8,
                  height: 800,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      userData(size),
                      const SizedBox(width: 120),
                      userIcon(size)
                    ]),
                ),
              )
            ]),
          )
        ]),
      ),
    );
  }

  SizedBox userIcon(Size size) {
    return SizedBox(
        width: size.width * 0.25,
        child: Hero(
            tag: user.username,
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
                      child: InkWell(
                          onTap: () {}), //Neded the rerout for change image
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 50,
                  child: ClipOval(
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(2),
                      child: const Icon(
                        Icons.edit,
                        size: 20,
                      ),
                    ),
                  ),
                )
              ],
            )));
  }

  Container userData(Size size) {
    return Container(
      height: 800,
      width: size.width * 0.2,
      margin: const EdgeInsets.only(left: 100, right: 100),
      child: Form(
        child: Column(children: <Widget>[
          const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                labelText: "First name",
                labelStyle: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(),
                hintText: "Please insert some text",
                hintStyle: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                )),
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
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                labelText: " Last name",
                labelStyle: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(),
                hintText: "Please insert some text",
                hintStyle: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                )),
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
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                labelText: "Username",
                labelStyle: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(),
                hintText: "Please insert some text",
                hintStyle: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                )),
            initialValue: user.username,
            onChanged: (value) {
              newUsername = value;
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
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                labelText: "Email",
                labelStyle: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(),
                hintText: "Please insert some text",
                hintStyle: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                )),
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
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                labelText: " RFID ",
                labelStyle: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(),
                hintText: "Please insert some text",
                hintStyle: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                )),
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
        ]),
      ),
    );
  }

  SizedBox editOrRemove() {
    return SizedBox(
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
          )),
          TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                primary: Colors.white,
                textStyle: const TextStyle(fontSize: 20),
              ),
              child: const Text("SAVE CHANGES"),
              onPressed: () async {
                await Httpservices.user_edit(
                    newFirstName,
                    newLastname,
                    newUsername,
                    oldUsername,
                    newMail,
                    newPwd,
                    newRfid,
                    userRole,
                    context);
              })
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
          )),
          TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                primary: Colors.white,
                textStyle: const TextStyle(fontSize: 20),
              ),
              child: const Text("DELETE  USER"),
              onPressed: () async {
                await Httpservices.webRemoveUser(
                    oldUsername, userRole, context);
              })
        ],
      ),
    );
  }
}
