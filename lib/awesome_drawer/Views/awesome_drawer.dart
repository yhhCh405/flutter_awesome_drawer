import 'package:awesome_drawer/awesome_drawer/Models/drawer_items.dart';
import 'package:awesome_drawer/awesome_drawer/Models/drawer_state.dart';
import 'package:awesome_drawer/awesome_drawer/Presenters/awesome_drawer_contract.dart';
import 'package:awesome_drawer/awesome_drawer/Presenters/awesome_drawer_impl.dart';

///Copyright 2020 by Ye Htet Hein. All rights reserved.

import 'package:flutter/material.dart';

class AwesomeDrawer extends StatefulWidget {
  final Widget child;

  /// The children of drawer. Use with `drawerHeader`
  final List<AwesomeDrawerItems> drawerItems;

  /// The header part of drawer. Use with `drawerItems`
  final Widget drawerHeader;

  /// The whole drawer widget. If use this widget, you don't need to use `drawerItems` and `drawerHeader`
  final Widget drawer;
  final double childRadius;
  final AppBar appBar;

  DrawerType type;

  AwesomeDrawer({
    this.child,
    this.drawerHeader,
    this.drawerItems,
    this.type = DrawerType.Slide,
    this.drawer,
    this.childRadius,
    this.appBar,
  });

  AwesomeDrawer.slide({
    this.child,
    this.drawerHeader,
    this.drawerItems,
    this.drawer,
    this.childRadius,
    this.appBar,
  }) {
    this.type = DrawerType.Slide;
  }

  AwesomeDrawer.scale({
    this.child,
    this.drawerHeader,
    this.drawerItems,
    this.drawer,
    this.childRadius,
    this.appBar,
  }) {
    this.type = DrawerType.Scale;
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
          transform: presenter.drawerTransform(isopended.data, widget.type),
          width: presenter.drawerWidth(isopended.data, widget.type),
          height: presenter.drawerHeight(isopended.data, widget.type),
          color: Colors.blueGrey[800],
          child: Container(
            color: Colors.red,
            width: presenter.drawerActualWidth(isopended.data, widget.type),
            height: presenter.drawerHeight(isopended.data, widget.type),
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
        );
      },
    );
  }

  Widget _child() {
    AppBar userAppBar;
    Widget _leading(bool isopended) => IconButton(
          icon: Icon(
            isopended ? Icons.close : Icons.menu,
          ),
          onPressed: () {
            presenter.drawerState.isOpended.add(!isopended);
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
        }
        return AnimatedContainer(
          transform: Matrix4.identity(),
          duration: Duration(milliseconds: 100),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: presenter
                    .childBorderRadius(
                        isopended.data, widget.childRadius, widget.type)
                    .topLeft,
                topRight: presenter
                    .childBorderRadius(
                        isopended.data, widget.childRadius, widget.type)
                    .topRight),
            child: userAppBar ??
                AppBar(
                  backgroundColor: Colors.white,
                  iconTheme: IconThemeData(color: Colors.black),
                  leading: _leading(isopended.data),
                ),
          ),
        );
      },
    );

    return StreamBuilder<bool>(
      stream: presenter.drawerState.isOpended.stream,
      initialData: false,
      builder: (context, isopended) {
        return AnimatedContainer(
          duration: presenter.animDuration,
          width: presenter.childWidth(isopended.data, widget.type),
          height: presenter.childHeight(isopended.data, widget.type),
          transform: presenter.childTransform(isopended.data, widget.type),
          decoration: BoxDecoration(
              borderRadius: presenter.childBorderRadius(
                  isopended.data, widget.childRadius, widget.type),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(-1.0, 0),
                    blurRadius: 5,
                    spreadRadius: 3),
              ]),
          child: SingleChildScrollView(
            child: Column(
              children: [_appbar, widget.child ?? Container()],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          return presenter.drawerState.isOpended.stream.last;
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
      ),
    );
  }
}
