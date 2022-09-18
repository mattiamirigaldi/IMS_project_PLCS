// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:ims/web_app/DataLists.dart';
import 'package:ims/web_app/services/http_services.dart';
import 'package:ims/web_app/views/AddTotemPage.dart';
import 'package:ims/web_app/views/ListTotemsPage.dart';
//import 'package:ims/Totem/Operator/TAddBook.dart';
//import 'package:ims/Totem/Operator/TRemoveBook.dart';
import 'package:ims/web_app/views/Operator/AddItemPage.dart';
import 'package:ims/web_app/views/Operator/ListItemsOperator.dart';
import 'package:ims/web_app/views/Operator/RemoveItemPage.dart';
import 'package:ims/web_app/views/ListItemsAdmin.dart';
import 'package:ims/web_app/views/RemoveTotemPage.dart';
import 'package:ims/web_app/views/components/App_bar.dart';

class manageTotems extends StatelessWidget {
  const manageTotems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            child: CustomAppBar(),
            //alignment: Alignment.topCenter,
            width: double.infinity,
            height: 150,
          ),
          const SizedBox(height: 10),
          const Center(
              child: Text(
            "Please select a service :",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          )),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddTotemPage()));
            },
            child: Center(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                child: const Center(
                    child: Text("Add new Totem",
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.black))),
                height: heightScreen / 6,
                width: widthScreen * 0.8,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.15),
                  border: Border.all(color: Colors.black87),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RemoveTotemPage()));
            },
            child: Center(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                child: const Center(
                    child: Text("Remove a Totem",
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.black))),
                height: heightScreen / 6,
                width: widthScreen * 0.8,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.15),
                  border: Border.all(color: Colors.black87),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              await Httpservices.webListTotems('ALL', context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ListTotemsPage()));
            },
            child: Center(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                child: const Center(
                    child: Text("List all Totems",
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.black))),
                height: heightScreen / 6,
                width: widthScreen * 0.8,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.15),
                  border: Border.all(color: Colors.black87),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ]));
  }
}
