import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../components/custom_block/custom_navbar_widget.dart';
import '../../config/globals.dart' as globals;

class HomePage extends StatefulWidget {
  int selectedIndex;
  HomePage({this.selectedIndex = 0, Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isNotify = true;
  int _selectedIndex = 0;
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _selectedIndex = widget.selectedIndex;
    _controller.index = _selectedIndex;
    // _onItemTapped(_selectedIndex);
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      // PersistentBottomNavBarItem(
      //   textStyle: Theme.of(context).textTheme.bodyText2,
      //   icon: SvgPicture.asset(
      //     "assets/img/home_selected.svg",
      //   ),
      //   inactiveIcon: SvgPicture.asset(
      //     "assets/img/home_icon.svg",
      //   ),
      //   title: ("Главная"),
      //   activeColorPrimary: Theme.of(context).bottomAppBarColor,
      //   inactiveColorPrimary: Theme.of(context).hintColor,
      // ),
      // PersistentBottomNavBarItem(
      //   textStyle: Theme.of(context).textTheme.bodyText2,
      //   icon: SvgPicture.asset(
      //     "assets/img/fire_selected.svg",
      //   ),
      //   inactiveIcon: SvgPicture.asset(
      //     "assets/img/fire_icon.svg",
      //   ),
      //   title: ("Возможности"),
      //   activeColorPrimary: Theme.of(context).bottomAppBarColor,
      //   inactiveColorPrimary: Theme.of(context).hintColor,
      // ),
      // PersistentBottomNavBarItem(
      //   textStyle: Theme.of(context).textTheme.bodyText2,
      //   icon: SvgPicture.asset(
      //     "assets/img/clipboard_selected.svg",
      //   ),
      //   inactiveIcon: SvgPicture.asset(
      //     "assets/img/clipboard_icon.svg",
      //   ),
      //   title: ("Обращения"),
      //   activeColorPrimary: Theme.of(context).bottomAppBarColor,
      //   inactiveColorPrimary: Theme.of(context).hintColor,
      // ),
      // PersistentBottomNavBarItem(
      //   textStyle: Theme.of(context).textTheme.bodyText2,
      //   icon: SvgPicture.asset(
      //     "assets/img/profile_selected.svg",
      //   ),
      //   inactiveIcon: SvgPicture.asset(
      //     "assets/img/profile_icon.svg",
      //   ),
      //   title: ("Профиль"),
      //   activeColorPrimary: Theme.of(context).bottomAppBarColor,
      //   inactiveColorPrimary: Theme.of(context).hintColor,
      // ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView.custom(
      context,
      routeAndNavigatorSettings: CutsomWidgetRouteAndNavigatorSettings(),
      itemCount: 0,
      controller: _controller,
      screens: [
        // Container(),
        // Container(),
        // Container(),
        // Container(),
      ],

      customWidget: CustomNavBarWidget(
        // Your custom widget goes here
        items: _navBarsItems(),
        selectedIndex: _controller.index,
        onItemSelected: (index) {
          setState(() {
            _controller.index = index;
            _selectedIndex = index; // NOTE: THIS IS CRITICAL!! Don't miss it!
          });
        },
      ),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: false, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: false, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      // decoration: NavBarDecoration(
      //   borderRadius: BorderRadius.circular(10.0),
      //   colorBehindNavBar: Colors.white,
      // ),
      // popAllScreensOnTapOfSelectedTab: true,
      // popActionScreens: PopActionScreensType.all,
      // itemAnimationProperties: ItemAnimationProperties(
      //   // Navigation Bar's items animation properties.
      //   duration: Duration(milliseconds: 200),
      //   curve: Curves.ease,
      // ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      // navBarStyle:
      //     NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }
}
