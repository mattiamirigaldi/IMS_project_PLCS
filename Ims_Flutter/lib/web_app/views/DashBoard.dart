// ignore_for_file: file_names

import 'package:flutter/material.dart';
import './components/FeedDashBoard.dart';
import './components/UserDashboard.dart';
import './components/App_bar.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10),
          child: CustomAppBar(),
          //alignment: Alignment.topCenter,
          width: double.infinity,
          height: 150,
        ),
        Expanded(
          child: Container(
              padding: const EdgeInsets.all(10),
              child: Row(children: const <Widget>[
                SizedBox(
                    height: double.infinity,
                    width: 500,
                    child: UserDashBoard()),
                SizedBox(
                  height: double.infinity,
                  width: 1000,
                  child: FeedDashBoard(),
                ),
              ])),
        )
      ]),
    );
  }
}
