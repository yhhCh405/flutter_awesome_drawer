import 'package:flutter/cupertino.dart';

abstract class AwesomeDrawerPresenterImpl {
  void registerView(AwesomeDrawerView view, BuildContext context);
  void unRegisterView();
}

abstract class AwesomeDrawerView {}
