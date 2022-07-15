// ignore_for_file: non_constant_identifier_names, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:ims/Web_app/services/http_services.dart';
import 'package:ims/Web_app/views/GenreList.dart';

class MenuItems extends StatefulWidget {
  final String title;
  final IconData icon;
  final String userName;
  //final void Function() press;
  final List<String> DropDownItems;
  const MenuItems({
    Key? key,
    required this.title,
    required this.icon,
    required this.DropDownItems,
    required this.userName,
    //required this.press,
  }) : super(key: key);

  @override
  State<MenuItems> createState() => _MenuItemsState(
      title: title,
      icon: icon,
      DropDownItems: DropDownItems,
      userName: userName);
}

class _MenuItemsState extends State<MenuItems> {
  final String title;
  final IconData icon;
  final String userName;
  //final void Function() press;
  final List<String> DropDownItems;
  _MenuItemsState(
      {required this.title,
      required this.icon,
      required this.DropDownItems,
      required this.userName
      //required this.press,
      });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
        offset: const Offset(10, 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Text(
                title.toUpperCase(),
                style: (TextStyle(
                    color: Colors.black.withOpacity(0.3),
                    fontWeight: FontWeight.bold)),
              ),
            ),
            Icon(icon, color: Colors.black, size: 20),
          ],
        ),
        onSelected: (choice) => choiceAction(choice, userName, context),
        itemBuilder: (BuildContext context) => DropDownItems.map((choice) =>
                PopupMenuItem<String>(value: choice, child: Text(choice)))
            .toList());
  }
}

void choiceAction(String choice, String userName, BuildContext context) async {
  if (choice == "My profile") {
    await Httpservices.settings(userName, context);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Settings")));
  } else if (choice == "Subjects") {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(choice)));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const GenreList()));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(choice)));
  }
}
