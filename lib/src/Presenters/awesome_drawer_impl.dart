import 'package:awesome_drawer/src/Models/drawer_properties.dart';
import 'package:awesome_drawer/src/Models/drawer_state.dart';
import 'package:awesome_drawer/src/Models/drawer_type.dart';
import 'package:awesome_drawer/src/Presenters/awesome_drawer_contract.dart';
import 'package:flutter/cupertino.dart';

class AwesomeDrawerPresenter implements AwesomeDrawerPresenterImpl {
  AwesomeDrawerView view;
  BuildContext context;

  DrawerProperties drawerProperties;
  DrawerState drawerState;

  DrawerType drawerType;

  double dragWidth = 0;

  int drawerPercent;

  void _determineDrawerProperties() {
    this.drawerProperties = DrawerProperties(
        opendedWidth: MediaQuery.of(context).size.width * (drawerPercent / 100),
        opendedHeight: MediaQuery.of(context).size.height,
        closedWidth: 0,
        closedHeight: MediaQuery.of(context).size.height,
        shrinkChildHeightFactor: 0.8,
        shrinkChildHeight: MediaQuery.of(context).size.height * 0.8);
  }

  double get fullWidth => MediaQuery.of(context).size.width;
  double get fullHeight => MediaQuery.of(context).size.height;

  Matrix4 childTransform(bool isOpended) {
    if (drawerType == DrawerType.Slide) {
      return Matrix4.identity()
        ..translate(
          dragWidth,
        );
    } else if (drawerType == DrawerType.Scale) {
      return Matrix4.translationValues(
          dragWidth,
          isOpended
              ? (MediaQuery.of(context).size.height +
                      24 -
                      MediaQuery.of(context).size.height * 0.8) /
                  2
              : 0.0,
          0)
        ..scale(isOpended ? 0.8 : 1.0);
    }
    return null;
  }

  Matrix4 drawerTransform(bool isOpended) {
    if (drawerType == DrawerType.Slide) {
      return null;
    } else if (drawerType == DrawerType.Scale) {
      return null;
    }
    return null;
  }

  double drawerWidth(bool isOpended) {
    if (drawerType == DrawerType.Slide) {
      return double.infinity;
    } else if (drawerType == DrawerType.Scale) {
      return double.infinity;
    }
    return 0;
  }

  double drawerActualWidth(bool isOpended) {
    if (drawerType == DrawerType.Slide) {
      return drawerProperties.opendedWidth;
    } else if (drawerType == DrawerType.Scale) {
      return drawerProperties.opendedWidth;
    }
    return 0;
  }

  double drawerHeight(bool isOpended) {
    if (drawerType == DrawerType.Slide) {
      return double.infinity;
    } else if (drawerType == DrawerType.Scale) {
      return double.infinity;
    }
    return 0;
  }

  double childWidth(bool isOpended) {
    if (drawerType == DrawerType.Slide) {
      return double.infinity;
    } else if (drawerType == DrawerType.Scale) {
      return double.infinity;
    }
    return 0;
  }

  double childHeight(bool isOpended) {
    if (drawerType == DrawerType.Slide) {
      return double.infinity;
    } else if (drawerType == DrawerType.Scale) {
      return double.infinity;
    }
    return 0;
  }

  BorderRadius childBorderRadius(bool isOpended, double childRadius) {
    if (drawerType == DrawerType.Slide) return BorderRadius.zero;
    return BorderRadius.circular(isOpended ? childRadius ?? 20 : 0);
  }

  Duration get animDuration => Duration(milliseconds: 200);

  toggleDrawer(bool isOpended) {
    dragWidth = isOpended
        ? drawerProperties.closedWidth
        : drawerProperties.opendedWidth;
    drawerState.isOpended.add(!isOpended);
  }

  @override
  void registerView(AwesomeDrawerView view, BuildContext context) {
    this.view = view;
    this.context = context;
    _determineDrawerProperties();
    this.drawerState = DrawerState();
  }

  @override
  void unRegisterView() {
    this.view = null;
  }

  @override
  void handleChildEndGesture(DragEndDetails details) {
    if (details.velocity.pixelsPerSecond.dx >= 1000) {
      dragWidth = drawerProperties.opendedWidth;
      drawerState.isOpended.add(true);
    }

    if (dragWidth < drawerProperties.opendedWidth &&
        details.velocity.pixelsPerSecond.dx < 1000) {
      dragWidth = drawerProperties.closedWidth;
      drawerState.isOpended.add(false);
    }
    view.updateDrawerByGesture();
  }

  @override
  void handleChildUpdateGesture(DragUpdateDetails details) {
    double dx = details.globalPosition.dx;
    if (dx > drawerProperties.opendedWidth) {
      dragWidth = drawerProperties.opendedWidth;
      drawerState.isOpended.add(true);
    } else {
      dragWidth = dx;
      drawerState.isOpended.add(false);
    }

    view.updateDrawerByGesture();
  }
}
