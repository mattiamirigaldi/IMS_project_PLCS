// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:ims/web_app/DataLists.dart';
import 'package:ims/web_app/views/components/App_bar.dart';
import 'AddUserPage.dart';
import './RemoveCustomerPage.dart';
import '../../services/http_services.dart';

class manageCustomer extends StatelessWidget {
  const manageCustomer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width_screen = MediaQuery.of(context).size.width;
    double height_screen = MediaQuery.of(context).size.height;
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
          const Center(
              child: Text(
            "Please select a service : ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          )),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddCustomer()));
            },
            child: Center(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                child: const Center(
                    child: Text("Add user",
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.black))),
                height: height_screen / 6,
                width: width_screen * 0.8,
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
                      builder: (context) => const RemoveCustomer()));
            },
            child: Center(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                child: const Center(
                    child: Text("Remove user",
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.black))),
                height: height_screen / 6,
                width: width_screen * 0.8,
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
              //await EasyLoading.showSuccess(TheWebUser.length.toString());
              if (TheWebUser[0]['role'] == 'admins') {
                await Httpservices.WebListUsers("customers", 'ALL', context);
              } else {
                await Httpservices.WebListUsers(TheWebUser[0]['admin_id'],
                    TheWebUser[0]['branch'], context);
              }

              //Navigator.push(
              //    context,
              //    MaterialPageRoute(
              //        builder: (context) => const RemoveCustomer()));
            },
            child: Center(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                child: const Center(
                    child: Text("List all users",
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.black))),
                height: height_screen / 6,
                width: width_screen * 0.8,
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
