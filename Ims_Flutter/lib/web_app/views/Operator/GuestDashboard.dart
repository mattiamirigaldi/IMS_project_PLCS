import 'package:flutter/material.dart';
import 'package:ims/web_app/DataLists.dart';
import 'package:ims/web_app/views/components/App_bar.dart';
import 'package:ims/web_app/views/components/FeedDashBoard.dart';

class GuestDashBoard extends StatelessWidget {
  const GuestDashBoard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width_screen = MediaQuery.of(context).size.width;
    double height_screen = MediaQuery.of(context).size.height;
    // HERE MISSING THE : TheWebUser[0]['role'] == "guest"
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
              padding: const EdgeInsets.all(40),
              child: FeedDashBoard(),
          )
        ),
      ]),
    );
  }
}
