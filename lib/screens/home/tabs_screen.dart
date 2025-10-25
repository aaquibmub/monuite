import 'package:flutter/material.dart';
import 'package:monuite/l10n/app_localizations.dart';
import 'package:monuite/providers/cart_provider.dart';
import 'package:monuite/screens/home/cart/cart_screen.dart';
import 'package:monuite/screens/home/categories/categories_screen.dart';
import 'package:monuite/screens/home/landing/landing_screen.dart';
import 'package:monuite/screens/home/profile_screen.dart';
import 'package:monuite/screens/home/wishlist_screen.dart';
import 'package:provider/provider.dart';

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
  List<Map<String, Object>>? _pages;

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
      body: _pages![_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        selectedItemColor: Constants.primaryColor,
        unselectedItemColor: Constants.textColorLight,
        showUnselectedLabels: true,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            // backgroundColor: Theme.of(context).backgroundColor,
            icon: ImageIcon(
              AssetImage(CustomIcons.homeIconDisabled),
            ),
            activeIcon: ImageIcon(
              AssetImage(CustomIcons.homeIconActive),
            ),
            label: AppLocalizations.of(context)!.home,
          ),
          BottomNavigationBarItem(
            // backgroundColor: Theme.of(context).backgroundColor,
            icon: ImageIcon(
              AssetImage(CustomIcons.catgIconDisabled),
            ),
            activeIcon: ImageIcon(
              AssetImage(CustomIcons.catgIconActive),
            ),
            label: AppLocalizations.of(context)!.categories,
          ),
          BottomNavigationBarItem(
            // backgroundColor: Theme.of(context).backgroundColor,
            icon: Consumer<CartProvider>(builder: (ctx, provider, _) {
              return Badge.count(
                // Using Badge.count for a numerical badge
                count: provider.cartModel != null
                    ? provider.cartModel!.items.length
                    : 0,
                child: ImageIcon(
                  AssetImage(CustomIcons.cartIconDisabled),
                ),
              );
            }),
            activeIcon: ImageIcon(
              AssetImage(CustomIcons.cartIconActive),
            ),
            label: AppLocalizations.of(context)!.cart,
          ),
          BottomNavigationBarItem(
            // backgroundColor: Theme.of(context).backgroundColor,
            icon: ImageIcon(
              AssetImage(CustomIcons.wishlistIconDisabled),
            ),
            activeIcon: ImageIcon(
              AssetImage(CustomIcons.wishlistIconActive),
            ),
            label: AppLocalizations.of(context)!.wishlist,
          ),
          BottomNavigationBarItem(
            // backgroundColor: Theme.of(context).backgroundColor,
            icon: ImageIcon(
              AssetImage(CustomIcons.profileIconDisabled),
            ),
            activeIcon: ImageIcon(
              AssetImage(CustomIcons.profileIconActive),
            ),
            label: AppLocalizations.of(context)!.profile,
          ),
        ],
      ),
    );
  }
}
