// ignore_for_file: non_constant_identifier_names, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:ims/web_app/services/http_services.dart';
import 'package:ims/web_app/views/CategoriesList.dart';
import 'package:ims/web_app/views/MyLoansPage.dart';
import 'package:ims/web_app/views/MyFavoriteItemsPage.dart';
import 'package:ims/web_app/views/Operator/ManageUsersPage.dart';
import 'package:ims/web_app/views/Operator/ManageItemsPage.dart';
import 'package:ims/web_app/views/UserSettings.dart';
import 'package:ims/web_app/views/WelcomPage.dart';

class MenuItems extends StatefulWidget {
  final String title;
  final IconData icon;
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
  final List<String> DropDownItems;
  _MenuItemsState({
    required this.title,
    required this.icon,
    required this.DropDownItems,
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
        onSelected: (choice) => choiceAction(choice, context),
        itemBuilder: (BuildContext context) => DropDownItems.map((choice) =>
                PopupMenuItem<String>(value: choice, child: Text(choice)))
            .toList());
  }
}

void choiceAction(String choice, BuildContext context) async {
  if (choice == "My profile") {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SettingPage()));
  } else if (choice == "Categories") {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const CategoriesListPage()));
  } else if (choice == "Manage users") {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const manageCustomer()));
  } else if (choice == "Manage items") {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const manageItems()));
  } else if (choice == "Logout") {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const WelcomeHome()));
  } else if (choice == "My loans") {
    await Httpservices.List_User_Items(context);
  } else if (choice == "Favorites") {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const FavoriteItemsPage()));
  } else if (choice == "Login") {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const WelcomeHome()));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(choice)));
  }
}
