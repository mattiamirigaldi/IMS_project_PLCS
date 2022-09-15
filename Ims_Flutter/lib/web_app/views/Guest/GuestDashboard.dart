import 'package:flutter/material.dart';
import 'package:ims/web_app/DataLists.dart';
import 'package:ims/web_app/views/WelcomPage.dart';
import 'package:ims/web_app/views/components/App_bar.dart';
import 'package:ims/web_app/views/components/FeedDashBoard.dart';

class GuestDashBoard extends StatelessWidget {
  const GuestDashBoard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    TheWebUser.clear();
    var guest = {"username": "guest", "role": "guest", "firstname": "guest"};
    TheWebUser.add(guest);
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
                loginGuestButton(widthScreen, context),
                const Expanded(
                  child: FeedDashBoard(),
                ),
              ])),
        )
      ]),
    );
  }

  SizedBox loginGuestButton(double widthScreen, BuildContext context) {
    return SizedBox(
        height: double.infinity,
        width: widthScreen * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text("Login to access incredible functionalites",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ),
            const SizedBox(
              height: 50,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Stack(children: <Widget>[
                Positioned.fill(
                  child: Container(
                    width: 300,
                    height: 80,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFF0D47A1),
                          Color(0xFF1976D2),
                          Color(0xFF42A5F5),
                        ],
                      ),
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(20.0),
                    textStyle: const TextStyle(fontSize: 24),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WelcomeHome()));
                  },
                  child: const Text(
                    ' LOGIN ',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ]),
            ),
          ],
        ));
  }
}
