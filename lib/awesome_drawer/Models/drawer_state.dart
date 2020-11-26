import 'dart:async';

class DrawerState{
  // ignore: close_sinks
  final StreamController<bool> isOpended = StreamController<bool>.broadcast();
}

enum DrawerType{
  Slide,
  Scale
}