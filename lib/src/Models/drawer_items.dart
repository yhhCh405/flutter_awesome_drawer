import 'package:flutter/material.dart';

class AwesomeDrawerItems {
  Icon icon;
  String name;
  void Function() onTap;
  Widget child;

  AwesomeDrawerItems({this.icon, this.name, this.onTap, this.child});

  
}
