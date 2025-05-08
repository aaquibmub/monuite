import 'package:flutter/material.dart';
import 'package:monuite/screens/home/cart/cart_screen.dart';
import 'package:monuite/screens/home/categories/categories_screen.dart';
import 'package:monuite/screens/home/landing/landing_screen.dart';
import 'package:monuite/screens/home/profile_screen.dart';
import 'package:monuite/screens/home/wishlist_screen.dart';

import '../../helpers/common/constants.dart';
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
        selectedItemColor: Constants.primaryColor,
        unselectedItemColor: Constants.textColorLight,
        showUnselectedLabels: true,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).backgroundColor,
            icon: ImageIcon(
              AssetImage(CustomIcons.homeIconDisabled),
            ),
            activeIcon: ImageIcon(
              AssetImage(CustomIcons.homeIconActive),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).backgroundColor,
            icon: ImageIcon(
              AssetImage(CustomIcons.catgIconDisabled),
            ),
            activeIcon: ImageIcon(
              AssetImage(CustomIcons.catgIconActive),
            ),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).backgroundColor,
            icon: ImageIcon(
              AssetImage(CustomIcons.cartIconDisabled),
            ),
            activeIcon: ImageIcon(
              AssetImage(CustomIcons.cartIconActive),
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).backgroundColor,
            icon: ImageIcon(
              AssetImage(CustomIcons.wishlistIconDisabled),
            ),
            activeIcon: ImageIcon(
              AssetImage(CustomIcons.wishlistIconActive),
            ),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).backgroundColor,
            icon: ImageIcon(
              AssetImage(CustomIcons.profileIconDisabled),
            ),
            activeIcon: ImageIcon(
              AssetImage(CustomIcons.profileIconActive),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
