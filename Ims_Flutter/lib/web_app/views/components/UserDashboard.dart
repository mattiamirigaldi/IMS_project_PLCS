// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:ims/web_app/views/components/profile_widget.dart';
import '../../services/http_services.dart';
import '../UserSettings.dart';

var UserData = Httpservices.user_buffer;

class UserDashBoard extends StatelessWidget {
  const UserDashBoard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String name = UserData.firstname;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(
            height: 40,
          ),
          Center(
              child: Text("Welcome dear $name",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textScaleFactor: 2)),
          // Icon pic
          ProfileWidget(
            imagePath: UserData.imagePath,
            onClicked: () async {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SettingPage()));
            },
          ),
          const SizedBox(height: 40),
          //
          buildName(),
          const SizedBox(height: 40),
          buildNews(),
        ]);
  }

  Widget buildName() => Center(
        child: Column(
          children: [
            Text(
              UserData.firstname,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Text(
              UserData.mail,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );

  Widget buildNews() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'News',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber),
            ),
            Text(
              UserData.news,
              style: const TextStyle(fontSize: 16, height: 1.4),
            )
          ],
        ),
      );
}
