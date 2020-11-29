import 'package:flutter/material.dart';

class AwesomeDrawerItems {
  Icon icon;
  String name;
  void Function() onTap;
  Widget child;

  AwesomeDrawerItems({this.icon, this.name, this.onTap, this.child});
}

class LeadingButton {
  Widget child;
  void Function(void Function(bool opened) toggleDrawer) onTap;
}

class AwesomeDrawerCallback {
  bool isOpended;
  void Function(bool isOpended) toggleDrawer;

  AwesomeDrawerCallback({this.isOpended, this.toggleDrawer});
}
