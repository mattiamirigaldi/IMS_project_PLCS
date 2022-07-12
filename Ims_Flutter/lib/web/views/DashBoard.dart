import 'package:flutter/material.dart';
import 'package:ims/web/views/components/FeedDashBoard.dart';
import 'package:ims/web/views/components/UserDashboard.dart';
import './components/App_bar.dart';

class DashBoard extends StatelessWidget {
  final String userName;
  final String myname;
  final String myemail;
  const DashBoard(
      {Key? key,
      required this.userName,
      required this.myname,
      required this.myemail})
      : super(key: key);
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      body : Column(
        children: <Widget>[
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
                Container(
                  height: double.infinity,
                  width: 300,
                  child: UserDashBoard(userName: userName,myname: myname, myemail: myemail,)
                ),
                Container(
                  height: double.infinity,
                  width: 700,
                  child: FeedDashBoard(),
                ),
                ]
              )
            ),
          )
        ]
        ),
      );
  } 
}