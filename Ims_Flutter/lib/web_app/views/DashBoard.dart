import 'package:flutter/material.dart';
import './components/FeedDashBoard.dart';
import './components/UserDashboard.dart';
import './components/App_bar.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width_screen = MediaQuery.of(context).size.width;
    double height_screen = MediaQuery.of(context).size.height;
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
              child: Row(children: <Widget>[
                SizedBox(
                    height: double.infinity,
                    width: width_screen*0.3,
                    child: const UserDashBoard()),
                const Expanded(
                    // ignore: prefer_const_constructors
                    child: FeedDashBoard(),
                  ),
              ])),
        )
      ]),
    );
  }
}
