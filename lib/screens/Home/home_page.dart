import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:majisoft/screens/Home/mainItem.dart';
import 'package:majisoft/screens/auth/signin_page.dart';
import 'package:majisoft/screens/auth/signup_page.dart';
import 'package:majisoft/screens/cart/cart_history.dart';

import '../account/account_page.dart';
//import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedIndex = 0;

  //late PersistentTabController _controller;

  List pages=[
    const MainItem(),
    Container(
      width: double.maxFinite,
      child: Center(child: Text("Order history page"),
      ),
    ),
    const CartHistory(),
    const AccountPage()
  ];

  void onTapNav(int index){
    setState(() {
      _selectedIndex=index;
    });
  }

  /*@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }*/

  /*List<Widget> _buildScreens() {
    return [
      const MainItem(),
      Container(
        child: const Center(
          child: Text("Next page"),
        ),
      ),
      const CartHistory(),
      Container(
        child: const Center(
          child: Text("Next next next page"),
        ),
      ),
    ];
  }*/

  /*List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("home"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.archivebox_fill),
        title: ("archive"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.shopping_cart),
        title: ("cart"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person),
        title: ("me"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }*/

  // Simple bottom nav bar
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapNav,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.amber,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        unselectedItemColor: Colors.green,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive),
            label: "history",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "profile",
          ),
        ],
      ),
    );
  }
  /*@override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style5, // Choose the nav bar style with this property.
    );
  }*/
}
