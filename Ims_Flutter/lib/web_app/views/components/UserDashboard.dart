// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:ims/Web_app/views/components/profile_widget.dart';
import 'package:ims/Web_app/model/user.dart';
import '../UserSettings.dart';

class UserDashBoard extends StatelessWidget {
  final User user;
  const UserDashBoard(
      {Key? key,
      required this.user})
      : super(key: key);
  @override 
  Widget build(BuildContext context){
    String name = user.firstName;
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
                imagePath : user.imagePath,
                onClicked: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SettingPage(myCustomer:user))
                  );
                },
              ),
              const SizedBox(height: 40),
              // 
              buildName(user),
              const SizedBox(height: 40),
              buildNews(user),
            ]);
  }
  
 Widget buildName(User user) => Center(
   child: Column( 
    children: [
      Text(
      user.firstName,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24 ),
      ),
      Text(
        user.email,
        style: const TextStyle(color: Colors.grey),
      ),
    ],
   ),
 );


 Widget buildNews(User user) => Container(
  padding: const EdgeInsets.symmetric(horizontal: 48),
   child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('News',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.amber),
      ),
      Text(
        user.news,
        style: const TextStyle(fontSize: 16, height: 1.4),)
    ],
   ),
 );
}

