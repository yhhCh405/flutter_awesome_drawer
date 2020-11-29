import 'package:awesome_drawer/awesome_drawer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AwesomeDrawer.slide(
        drawerHeader: DrawerHeader(
          child: Center(
            child: Text("Hello"),
          ),
        ),
        drawerItems: [
          AwesomeDrawerItems(
              icon: Icon(Icons.wallet_giftcard),
              child: Text("Gift card"),
              onTap: () {}),
          AwesomeDrawerItems(
              icon: Icon(Icons.wallet_giftcard), child: Text("Gift card")),
          AwesomeDrawerItems(
              icon: Icon(Icons.wallet_giftcard), child: Text("Gift card")),
          AwesomeDrawerItems(
              icon: Icon(Icons.wallet_giftcard), child: Text("Gift card")),
        ],
        child: Center(
          child: Text("Hello"),
        ),
      ),
    );
  }
}
