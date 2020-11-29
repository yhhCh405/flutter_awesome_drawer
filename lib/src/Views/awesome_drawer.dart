import 'package:awesome_drawer/awesome_drawer.dart';
import 'package:awesome_drawer/src/Models/drawer_items.dart';
import 'package:awesome_drawer/src/Models/drawer_type.dart';
import 'package:awesome_drawer/src/Presenters/awesome_drawer_contract.dart';
import 'package:awesome_drawer/src/Presenters/awesome_drawer_impl.dart';

///Copyright 2020 by Ye Htet Hein. All rights reserved.
import 'package:flutter/material.dart';

typedef ChildBuilder = Widget Function(AwesomeDrawerCallback callback);

// ignore: must_be_immutable
class AwesomeDrawer extends StatefulWidget {
  final Widget child;

  /// Use this instead of child when need to trace drawer state. Bool in the parameter is refer to drawer state.
  final ChildBuilder builder;

  /// The children of drawer. Use with `drawerHeader`
  final List<AwesomeDrawerItems> drawerItems;

  /// The header part of drawer. Use with `drawerItems`
  final Widget drawerHeader;

  /// The whole drawer widget. If use this widget, you don't need to use `drawerItems` and `drawerHeader`
  final Widget drawer;

  /// Percentage (%) of drawer width to be open
  final int drawerPercent;

  final double childRadius;
  final AppBar appBar;

  final Color backgroundColor;
  final Color drawerHeaderSpaceColor;
  final Color drawerBodySpaceColor;

  DrawerType _drawerType;

  AwesomeDrawer({
    this.child,
    this.drawerHeader,
    this.drawerItems,
    final DrawerType drawerType,
    this.drawer,
    this.childRadius,
    this.appBar,
    this.drawerPercent,
    this.backgroundColor,
    this.drawerHeaderSpaceColor,
    this.drawerBodySpaceColor,
    this.builder,
  }) {
    this._drawerType = drawerType ?? DrawerType.Slide;
  }

  AwesomeDrawer.builder(
      {this.child,
      this.drawerHeader,
      this.drawerItems,
      final DrawerType drawerType,
      this.drawer,
      this.childRadius,
      this.appBar,
      this.drawerPercent,
      this.backgroundColor,
      this.drawerHeaderSpaceColor,
      this.builder,
      this.drawerBodySpaceColor}) {
    this._drawerType = drawerType ?? DrawerType.Slide;
  }

  AwesomeDrawer.slide(
      {this.child,
      this.drawerHeader,
      this.drawerItems,
      this.drawer,
      this.childRadius,
      this.appBar,
      this.drawerPercent,
      this.backgroundColor,
      this.drawerHeaderSpaceColor,
      this.builder,
      this.drawerBodySpaceColor}) {
    this._drawerType = DrawerType.Slide;
  }

  AwesomeDrawer.scale(
      {this.child,
      this.drawerHeader,
      this.drawerItems,
      this.drawer,
      this.childRadius,
      this.appBar,
      this.drawerPercent,
      this.backgroundColor,
      this.drawerHeaderSpaceColor,
      this.builder,
      this.drawerBodySpaceColor}) {
    this._drawerType = DrawerType.Scale;
  }

  @override
  _AwesomeDrawerState createState() => _AwesomeDrawerState();
}

class _AwesomeDrawerState extends State<AwesomeDrawer>
    implements AwesomeDrawerView {
  AwesomeDrawerPresenter presenter = AwesomeDrawerPresenter();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    presenter.drawerPercent = widget.drawerPercent ?? 60;
    presenter.drawerType = widget._drawerType;
    presenter.registerView(this, context);
  }

  @override
  void dispose() {
    super.dispose();
    presenter.unRegisterView();
  }

  Widget _buildDrawerItems() {
    if (widget.drawerItems == null) {
      return Container();
    }
    return Column(
      children: widget.drawerItems
          .map((e) => ListTile(
              leading: e.icon, title: e.child, onTap: e.onTap ?? () {}))
          .toList(),
    );
  }

  Widget _drawer() {
    return StreamBuilder<bool>(
      stream: presenter.drawerState.isOpended.stream,
      initialData: false,
      builder: (context, isopended) {
        return AnimatedContainer(
          duration: presenter.animDuration,
          transform: presenter.drawerTransform(isopended.data),
          width: presenter.drawerWidth(isopended.data),
          height: presenter.drawerHeight(isopended.data),
          color: widget.backgroundColor ?? Colors.blueGrey[800],
          child: Row(
            children: [
              Container(
                width: presenter.drawerActualWidth(isopended.data),
                height: presenter.drawerHeight(isopended.data),
                child: widget.drawer ??
                    Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: presenter.fullHeight / 3.5,
                          child: widget.drawerHeader ?? Container(),
                        ),
                        SingleChildScrollView(
                          child: _buildDrawerItems(),
                        )
                      ],
                    ),
              ),
              Expanded(
                  child: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: widget.drawerHeaderSpaceColor ??
                          widget.drawerBodySpaceColor ??
                          widget.backgroundColor,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: widget.drawerBodySpaceColor ??
                          widget.drawerHeaderSpaceColor ??
                          widget.backgroundColor,
                    ),
                  ),
                ],
              ))
            ],
          ),
        );
      },
    );
  }

  Widget _child() {
    Widget userAppBar;
    Widget _leading(bool isopended) => IconButton(
          icon: Icon(
            isopended ? Icons.close : Icons.menu,
          ),
          onPressed: () {
            presenter.toggleDrawer(isopended);
          },
        );

    Widget _appbar = StreamBuilder<bool>(
      stream: presenter.drawerState.isOpended.stream,
      initialData: false,
      builder: (context, isopended) {
        if (widget.appBar != null) {
          userAppBar = AppBar(
            leading: _leading(isopended.data),
            key: widget.appBar.key,
            title: widget.appBar.title,
            actions: widget.appBar.actions,
            automaticallyImplyLeading: widget.appBar.automaticallyImplyLeading,
            flexibleSpace: widget.appBar.flexibleSpace,
            bottom: widget.appBar.bottom,
            elevation: widget.appBar.elevation,
            shadowColor: widget.appBar.shadowColor,
            iconTheme: widget.appBar.iconTheme,
            shape: widget.appBar.shape,
            backgroundColor: widget.appBar.backgroundColor,
            brightness: widget.appBar.brightness,
            actionsIconTheme: widget.appBar.actionsIconTheme,
            textTheme: widget.appBar.textTheme,
            centerTitle: widget.appBar.centerTitle,
            primary: widget.appBar.primary,
            excludeHeaderSemantics: widget.appBar.excludeHeaderSemantics,
            titleSpacing: widget.appBar.titleSpacing,
            toolbarHeight: widget.appBar.toolbarHeight,
            toolbarOpacity: widget.appBar.toolbarOpacity,
            leadingWidth: widget.appBar.leadingWidth,
            bottomOpacity: widget.appBar.bottomOpacity,
          );

          final double topPadding =
              widget.appBar.primary ? MediaQuery.of(context).padding.top : 0.0;
          final double _appBarMaxHeight =
              widget.appBar.preferredSize.height + topPadding;

          userAppBar = ConstrainedBox(
            child: userAppBar,
            constraints: BoxConstraints(maxHeight: _appBarMaxHeight),
          );
        }
        return AnimatedContainer(
          transform: Matrix4.identity(),
          duration: Duration(milliseconds: 100),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: presenter
                    .childBorderRadius(isopended.data, widget.childRadius)
                    .topLeft,
                topRight: presenter
                    .childBorderRadius(isopended.data, widget.childRadius)
                    .topRight),
            child: userAppBar ?? Container(),
          ),
        );
      },
    );

    return StreamBuilder<bool>(
      stream: presenter.drawerState.isOpended.stream,
      initialData: false,
      builder: (context, isopended) {
        return AnimatedContainer(
          curve: Curves.easeInOut,
          duration: presenter.animDuration,
          transform: presenter.childTransform(isopended.data),
          decoration: BoxDecoration(
              borderRadius: presenter.childBorderRadius(
                  isopended.data, widget.childRadius),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(-1.0, 0),
                    blurRadius: 5,
                    spreadRadius: 5),
              ]),
          child: Container(
            child: Column(
              children: [
                _appbar,
                Expanded(
                  child: Stack(
                    children: [
                      widget.builder != null
                          ? widget.builder(
                              AwesomeDrawerCallback(
                                  isOpended: isopended.data,
                                  toggleDrawer: presenter.toggleDrawer),
                            )
                          : widget.child ?? Container(),
                      GestureDetector(
                        onHorizontalDragUpdate:
                            presenter.handleChildUpdateGesture,
                        onHorizontalDragEnd: presenter.handleChildEndGesture,
                        child: Container(
                          width: 20,
                          height: presenter.fullHeight,
                          color: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<bool>(
          stream: presenter.drawerState.isOpended.stream,
          builder: (context, snapshot) {
            return WillPopScope(
              onWillPop: () async {
                if (snapshot.data) {
                  presenter.toggleDrawer(snapshot.data);
                  return false;
                }
                return true;
              },
              child: GestureDetector(
                onTap: () {},
                child: Stack(
                  children: [
                    _drawer(),
                    _child(),
                  ],
                ),
              ),
            );
          }),
    );
  }

  @override
  void updateDrawerByGesture() {
    setState(() {});
  }
}
