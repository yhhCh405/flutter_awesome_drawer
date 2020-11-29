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

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  TabController tabCtrl;
  @override
  void initState() {
    super.initState();
    tabCtrl = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AwesomeDrawer.slide(
        // appBar: AppBar(
        //   primary: true,
        //   bottom: TabBar(
        //     controller: tabCtrl,
        //     tabs: [
        //       Tab(
        //         text: "Orange",
        //       ),
        //       Tab(
        //         text: "Apple",
        //       ),
        //       Tab(
        //         text: "Mango",
        //       )
        //     ],
        //   ),
        // ),
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
        builder: (AwesomeDrawerCallback callback) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text("Hello"),
                leading: IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    callback.toggleDrawer(callback.isOpended);
                  },
                ),
                 bottom: TabBar(
            controller: tabCtrl,
            tabs: [
              Tab(
                text: "Orange",
              ),
              Tab(
                text: "Apple",
              ),
              Tab(
                text: "Mango",
              )
            ],
          ),
              ),
              SliverToBoxAdapter()
            ],
          );
        },
      ),
    );
  }
}
