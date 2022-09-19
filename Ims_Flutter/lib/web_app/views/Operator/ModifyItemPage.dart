import 'package:flutter/material.dart';
import 'package:ims/web_app/model/item.dart';
import 'package:ims/web_app/services/http_services.dart';
//import 'package:ims/web_app/views/components/App_bar.dart';

class ModifyItemPage extends StatefulWidget {
  final Item item;
  const ModifyItemPage({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<ModifyItemPage> createState() => _ModifyItemPageState(item: item);
}

class _ModifyItemPageState extends State<ModifyItemPage> {
  final _formKey = GlobalKey<FormState>();
  final Item item;
  late String newTitle = item.title;
  late String newAuthor = item.author;
  late double newPrice = item.price;
  late String newDescription = item.description;
  late String newId = item.id;
  late String newRfid = item.rfid;
  late String newLocation = item.location;
  late String newCategory = item.category;
  late String newUrlImage = item.urlImage;
  late String username;
  _ModifyItemPageState({required this.item});
  @override
  Widget build(BuildContext context) {
    // To get total height and width
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: item.color,
      appBar: AppBar(
        backgroundColor: item.color,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
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
          const Text("Modify item page")
        ])),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          const Divider(),
          const SizedBox(height: 40),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: size.height / 5,
                        child: Padding(
                            padding: const EdgeInsets.only(top: 1),
                            child: TextFormField(
                                expands: true,
                                maxLines: null,
                                decoration: const InputDecoration(
                                    labelText: "Description",
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
                                initialValue: item.description,
                                onChanged: (value) {
                                  newDescription = value;
                                })),
                      ),
                      editOrRemove()
                    ]),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: size.width * 0.9,
                  height: 800,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        itemInfo(size),
                        itemInfoLogistics(size),
                        const SizedBox(width: 100),
                        itemPicture(size)
                      ]),
                ),
              )
            ]),
          )
        ]),
      ),
    );
  }

  SizedBox itemPicture(Size size) {
    return SizedBox(
        width: size.width * 0.25,
        child: Hero(
            tag: item.id,
            child: Stack(
              //alignment: Alignment.bottomCenter,
              children: [
                Material(
                  color: Colors.transparent,
                  child: Ink.image(
                    image: NetworkImage(item.urlImage),
                    width: 230,
                    height: 230,
                    child: InkWell(
                        onTap: () => showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Enter url of new image"),
                                content: TextFormField(
                                  decoration: const InputDecoration(
                                      hintText: 'url image'),
                                  onChanged: (value) {
                                    newUrlImage = value;
                                  },
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("SUBMIT"))
                                ],
                              ),
                            )),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  left: 185,
                  child: ClipOval(
                    child: Container(
                      color: Colors.grey,
                      padding: const EdgeInsets.all(2),
                      child: const Icon(
                        Icons.add_a_photo_outlined,
                        size: 30,
                      ),
                    ),
                  ),
                )
              ],
            )));
  }

  Container itemInfoLogistics(Size size) {
    return Container(
      height: 800,
      width: size.width * 0.2,
      margin: const EdgeInsets.only(left: 40, right: 40),
      child: Form(
        child: Column(children: <Widget>[
          const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                labelText: "LOCATION",
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
            initialValue: item.location,
            onChanged: (value) {
              newLocation = value;
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
                labelText: "PRICE",
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
            initialValue: item.price.toString(),
            onChanged: (value) {
              newPrice = value as double;
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
                labelText: " Book ID ",
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
            initialValue: item.id,
            onChanged: (value) {
              newId = value;
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
            initialValue: item.rfid,
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

  Container itemInfo(Size size) {
    return Container(
      height: 800,
      width: size.width * 0.2,
      margin: const EdgeInsets.only(left: 40, right: 40),
      child: Form(
        child: Column(children: <Widget>[
          const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                labelText: "TITLE",
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
            initialValue: item.title,
            onChanged: (value) {
              newTitle = value;
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
                labelText: "AUTHOR",
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
            initialValue: item.author,
            onChanged: (value) {
              newAuthor = value;
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
                labelText: "CATEGORY",
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
            initialValue: item.category,
            onChanged: (value) {
              newCategory = value;
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
        const SizedBox(width: 80),
        rentReturn(),
        const SizedBox(width: 80),
        deleteButton(),
      ]),
    );
  }

  ClipRRect rentReturn() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
              child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Color.fromARGB(255, 0, 94, 172),
                  Color.fromARGB(255, 0, 101, 216),
                  Color.fromARGB(255, 0, 119, 255),
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
              child: const Text("RENT / RETURN"),
              onPressed: () async {
                if (item.available) {
                  //EasyLoading.showSuccess("Item Available");
                  return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Enter Username of the Customer'),
                          content: TextField(
                            onChanged: (value) {
                              setState(() {
                                username = value;
                              });
                            },
                            //controller: _textFieldController,
                            decoration: const InputDecoration(
                                hintText: "ex: c1, c2, ..."),
                          ),
                          actions: <Widget>[
                            TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white)),
                              child: const Text('CANCEL'),
                              onPressed: () {
                                setState(() {
                                  Navigator.pop(context);
                                });
                              },
                            ),
                            TextButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<
                                          Color>(
                                      const Color.fromARGB(255, 68, 156, 71)),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white)),
                              child: const Text('OK'),
                              onPressed: () {
                                setState(() async {
                                  await Httpservices.item_rent(
                                      item.id, username, context);
                                  //codeDialog = valueText;
                                  Navigator.pop(context);
                                });
                              },
                            ),
                          ],
                        );
                      });
                } else {
                  return showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Return the Item'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              const Text(
                                  'Are You sure that you want to return the Item?'),
                              Text('The Item will be removed from user ' +
                                  item.avaflag +
                                  ' Loan list'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Confirm'),
                            onPressed: () async {
                              await Httpservices.item_return(item.id, context);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
                //await Httpservices.item_edit(item.id, newTitle, newAuthor,
                //    newDescription, newLocation, newCategory, newId, context);
              })
        ],
      ),
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
                await Httpservices.item_edit(
                    item.id,
                    newTitle,
                    newAuthor,
                    newDescription,
                    newLocation,
                    newCategory,
                    newId,
                    newUrlImage,
                    context);
                //if (_formKey.currentState != null) {
                //  if (_formKey.currentState!.validate()) {
                //    ScaffoldMessenger.of(context).showSnackBar(
                //        const SnackBar(content: Text("Register Success")));
                //  }
                //} else {
                //  EasyLoading.showSuccess("NEEDED SAVE HTTP METHOD");
                //}
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
              child: const Text("DELETE IT"),
              onPressed: () async {
                await Httpservices.item_remove(item.id, context);
                //setState(() {
                //  EasyLoading.showSuccess("NEEDED DELETE HTTP METHOD");
                //});
              })
        ],
      ),
    );
  }
}
