import 'package:flutter/material.dart';
import 'package:monuite/screens/home/cart_screen.dart';
import 'package:monuite/screens/home/categories_screen.dart';
import 'package:monuite/screens/home/landing_screen.dart';
import 'package:monuite/screens/home/profile_screen.dart';
import 'package:monuite/screens/home/wishlist_screen.dart';

import '../../helpers/common/custom_icons.dart';

class TabsScreen extends StatefulWidget {
  final int index;

  TabsScreen(
    this.index,
  );

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;

  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [
      {'page': LandingScreen()},
      {'page': CategoriesScreen()},
      {'page': CartScreen()},
      {'page': WishlistScreen()},
      {'page': ProfileScreen()},
    ];

    _selectedPageIndex = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(
              MyFlutterApp.ico_home,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(
              MyFlutterApp.ico_trip,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(
              MyFlutterApp.ico_vehicle,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(
              MyFlutterApp.ico_vehicle_inspection,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(
              MyFlutterApp.ico_vehicle_inspection,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
