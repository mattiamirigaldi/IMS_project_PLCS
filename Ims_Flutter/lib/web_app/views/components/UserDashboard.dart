// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:ims/Web_app/views/components/profile_widget.dart';
import 'package:ims/Web_app/model/customer.dart';
import '../UserSettings.dart';

class UserDashBoard extends StatelessWidget {
  final Customer customer;
  const UserDashBoard(
      {Key? key,
      required this.customer})
      : super(key: key);
  @override 
  Widget build(BuildContext context){
    String name = customer.firstName;
    return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                  child: Text(
                      "Welcome dear $name",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textScaleFactor: 2)),
              // Icon pic
              ProfileWidget(
                imagePath : customer.imagePath,
                onClicked: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SettingPage(myCustomer:customer))
                  );
                },
              ),
              const SizedBox(height: 40),
              // 
              buildName(customer),
              const SizedBox(height: 40),
              buildNews(customer),
            ]);
  }
  
 Widget buildName(Customer customer) => Center(
   child: Column( 
    children: [
      Text(
      customer.firstName,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24 ),
      ),
      Text(
        customer.email,
        style: const TextStyle(color: Colors.grey),
      ),
    ],
   ),
 );


 Widget buildNews(Customer customer) => Container(
  padding: const EdgeInsets.symmetric(horizontal: 48),
   child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('News',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.amber),
      ),
      Text(
        customer.news,
        style: const TextStyle(fontSize: 16, height: 1.4),)
    ],
   ),
 );
}

