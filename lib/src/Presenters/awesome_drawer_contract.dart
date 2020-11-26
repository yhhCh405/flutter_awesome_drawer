import 'package:flutter/cupertino.dart';

abstract class AwesomeDrawerPresenterImpl {
  void registerView(AwesomeDrawerView view, BuildContext context);
  void unRegisterView();
  void handleChildUpdateGesture(DragUpdateDetails details);
  void handleChildEndGesture(DragEndDetails details);
}

abstract class AwesomeDrawerView {
  void updateDrawerByGesture();
}
