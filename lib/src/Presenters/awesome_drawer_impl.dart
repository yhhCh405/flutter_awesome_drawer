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

  void _determineDrawerProperties() {
    this.drawerProperties = DrawerProperties(
        opendedWidth: MediaQuery.of(context).size.width * 0.7,
        opendedHeight: MediaQuery.of(context).size.height,
        closedWidth: 0,
        closedHeight: MediaQuery.of(context).size.height,
        shrinkChildHeightFactor: 0.8,
        shrinkChildHeight: MediaQuery.of(context).size.height * 0.8);
  }

  double get fullWidth => MediaQuery.of(context).size.width;
  double get fullHeight => MediaQuery.of(context).size.height;

  Matrix4 childTransform(bool isOpended, DrawerType type) {
    if (type == DrawerType.Slide) {
      return Matrix4.identity()
        ..translate(
          isOpended
              ? drawerProperties.opendedWidth
              : drawerProperties.closedWidth,
        );
    } else if (type == DrawerType.Scale) {
      if (isOpended) {
        return Matrix4.translationValues(
            200,
            (MediaQuery.of(context).size.height +
                    24 -
                    MediaQuery.of(context).size.height * 0.8) /
                2,
            0)
          ..scale(0.8);
      } else {
        return Matrix4.translationValues(0.0, 0.0, 0.0)..scale(1.0);
      }
    }
    return null;
  }

  Matrix4 drawerTransform(bool isOpended, DrawerType type) {
    if (type == DrawerType.Slide) {
      return null;
    } else if (type == DrawerType.Scale) {
      return null;
    }
    return null;
  }

  double drawerWidth(bool isOpended, DrawerType type) {
    if (type == DrawerType.Slide) {
      return double.infinity;
    } else if (type == DrawerType.Scale) {
      return double.infinity;
    }
    return 0;
  }

  double drawerActualWidth(bool isOpended, DrawerType type) {
    if (type == DrawerType.Slide) {
      return drawerProperties.opendedWidth;
    } else if (type == DrawerType.Scale) {
      return 200; // drawerProperties.opendedWidth;
    }
    return 0;
  }

  double drawerHeight(bool isOpended, DrawerType type) {
    if (type == DrawerType.Slide) {
      return double.infinity;
    } else if (type == DrawerType.Scale) {
      return double.infinity;
    }
    return 0;
  }

  double childWidth(bool isOpended, DrawerType type) {
    if (type == DrawerType.Slide) {
      return double.infinity;
    } else if (type == DrawerType.Scale) {
      return double.infinity;
    }
    return 0;
  }

  double childHeight(bool isOpended, DrawerType type) {
    if (type == DrawerType.Slide) {
      return double.infinity;
    } else if (type == DrawerType.Scale) {
      return double.infinity;
    }
    return 0;
  }

  BorderRadius childBorderRadius(
      bool isOpended, double childRadius, DrawerType type) {
    if (type == DrawerType.Slide) return null;
    return BorderRadius.circular(isOpended ? childRadius ?? 20 : 0);
  }

  Duration get animDuration => Duration(milliseconds: 200);

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
}
