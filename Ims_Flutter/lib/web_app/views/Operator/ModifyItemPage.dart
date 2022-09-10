import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ims/web_app/model/item.dart';
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
   late String newLocation = item.location;
   late String newCategory = item.category;
   late String newUrlImage = item.urlImage;
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
                                labelText : "Description",
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
                              initialValue : item.description,
                              onChanged: (value) {
                                newDescription = value;
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
                  width: size.width*0.9,
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

  Container itemPicture(Size size) {
    return Container(
      width: size.width*0.25,
      child: Hero(
        tag: "${item.id}",
        child: Stack(
          //alignment: Alignment.bottomCenter,
          children: [
            Material(
              color: Colors.transparent,
              child: Ink.image(
                image: NetworkImage(item.urlImage),
                width: 230,
                height: 230,
                // to create a splash effect when image clicked
                child: InkWell(onTap: () {}), //Neded the rerout for change image
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
                    size: 30,),
                ),
              ),
            )
        ],)
      )
    );
  }


Container itemInfoLogistics(Size size) {
    return Container(
              height: 800,
              width: size.width * 0.2,
              margin: const EdgeInsets.only(left: 40, right: 40),
              child : Form(
                child: Column (
                  children: <Widget>[
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        labelText: "LOCATION",
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
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        labelText: "PRICE",
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
                    initialValue: item.price.toString(),
                    onChanged: (value) {
                      newPrice =  value as double;
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
                  ]
                ),
              ),
            );
  }
 


  Container itemInfo(Size size) {
    return Container(
              height: 800,
              width: size.width * 0.2,
              margin: const EdgeInsets.only(left: 40, right: 40),
              child : Form(
                child: Column (
                  children: <Widget>[
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        labelText: "TITLE",
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
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        labelText: "AUTHOR",
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
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        labelText: "CATEGORY",
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
