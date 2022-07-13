// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'Searchbar.dart';
import 'menu_item.dart';
import 'dart:developer' as devlog;

class CustomAppBar extends StatelessWidget {
  static const _BrowseItems = [
    "Subjects",
    "Trending",
    "Collections",
    "Random book"
  ];
  static const _MoreItems = ["Request book", "Help & support"];
  static const _UserItems = ["My profile", "My loans", "Favorites", "Logout"];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(46),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, -2),
                blurRadius: 30,
                color: Colors.black.withOpacity(0.15))
          ]),
      child: Row(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Image.asset("images/ims.jpg",
                  height: 75,
                  //width: 50,
                  alignment: Alignment.topCenter)),
          const SizedBox(width: 5),
          Text("Welcome".toUpperCase(),
              style:
                  const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const Spacer(),
          SearchBar(),
          const MenuItems(
            title: "Browse",
            icon: Icons.arrow_drop_down_rounded,
            DropDownItems: _BrowseItems,
          ),
          const MenuItems(
            title: "More",
            icon: Icons.arrow_drop_down_rounded,
            DropDownItems: _MoreItems,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 70),
            child: MenuItems(
                title: "",
                icon: Icons.manage_accounts,
                DropDownItems: _UserItems),
          )
        ],
      ),
    );
  }
}
