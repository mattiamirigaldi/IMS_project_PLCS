// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'Searchbar.dart';
import 'menu_item.dart';
import 'dart:developer' as devlog;
import 'package:ims/Web_app/views/DashBoard.dart';
import 'package:ims/Web_app/data/user_data.dart';

class CustomAppBar extends StatelessWidget {
  static const _BrowseItems = [
    "Subjects",
    "Trending",
    "Collections",
    "Random book"
  ];
  static const _MoreItems = ["Request book", "Help & support"];
  static const _UserItems = ["My profile", "My loans", "Favorites", "Logout"];
  final String userName;

  const CustomAppBar({Key? key, required this.userName}) : super(key: key);
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
          InkWell(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                decoration:
                 BoxDecoration (
                  image: DecorationImage(
                    image: AssetImage( "images/ims.jpg"),
                    //fit : BoxFit.fill,
                    alignment: Alignment.center
                 ),
                 borderRadius: BorderRadius.circular(25),
                )
                ),
            onTap: () =>
              Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DashBoard(customer: UserData.myCustomer))
              )
          ),
          const SizedBox(width: 20),
          Text("Welcome ".toUpperCase()+userName,
              style:
                  const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const Spacer(),
          SearchBar(),
          MenuItems(
            title: "Browse",
            icon: Icons.arrow_drop_down_rounded,
            DropDownItems: _BrowseItems, 
            userName: userName,
          ),
          MenuItems(
            title: "More",
            icon: Icons.arrow_drop_down_rounded,
            DropDownItems: _MoreItems,
            userName: userName,
          ),
          Padding(
            padding: EdgeInsets.only(right: 70),
            child: MenuItems(
                title: "",
                icon: Icons.manage_accounts,
                DropDownItems: _UserItems,
                userName: userName,),
          )
        ],
      ),
    );
  }
}
