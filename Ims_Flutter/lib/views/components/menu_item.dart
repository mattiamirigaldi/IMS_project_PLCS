import 'package:flutter/material.dart';

class MenuItems extends StatefulWidget {
  final String title;
  final IconData icon;
  //final void Function() press;
  final List<String> DropDownItems;
  const MenuItems({
    Key? key,
    required this.title,
    required this.icon,
    required this.DropDownItems,
  }) : super(key: key);

  @override
  State<MenuItems> createState() =>
      _MenuItemsState(title: title, icon: icon, DropDownItems: DropDownItems);
}

class _MenuItemsState extends State<MenuItems> {
  final String title;
  final IconData icon;
  // final void Function() press;
  final List<String> DropDownItems;
  _MenuItemsState({
    required this.title,
    required this.icon,
    required this.DropDownItems,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
        offset: Offset(10, 50),
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
        onSelected: (value) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('selected ' + value)));
        },
        itemBuilder: (BuildContext context) => DropDownItems.map(
            (e) => PopupMenuItem<String>(
              value: e, 
              child: Text(e))
              ).toList()
    );
  }
}
    