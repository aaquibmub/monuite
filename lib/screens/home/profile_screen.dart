import 'package:flutter/material.dart';
import 'package:monuite/helpers/common/constants.dart';
import 'package:monuite/helpers/common/custom_icons.dart';
import 'package:monuite/helpers/models/user.dart';
import 'package:monuite/providers/auth.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Widget buildItem(String icon, String label) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            child: ImageIcon(
              AssetImage(icon),
              color: Constants.primaryColor,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final User? _currentuser = Provider.of<Auth>(context).currentUser;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              _currentuser != null
                  ? '${_currentuser.firstName} ${_currentuser.lastName}'
                  : 'Guest',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          // ORDERS
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
            ),
            child: Text(
              'ORDERS',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          // ORDERS - My Orders
          buildItem(CustomIcons.myOrdersIcon, 'My Orders'),
          // SETTINGS
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
            ),
            child: Text(
              'SETTINGS',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          // SETTINGS - Profile
          buildItem(CustomIcons.profileIcon, 'Profile'),
          // SETTINGS - Address Book
          buildItem(CustomIcons.addressBookIcon, 'Address Book'),
          // SETTINGS - Cards
          buildItem(CustomIcons.cardsIcon, 'Cards'),
          // SETTINGS - Language
          buildItem(CustomIcons.languageIcon, 'Language'),
          // SETTINGS - Push Notifications
          buildItem(CustomIcons.pushNotificationsIcon, 'Push Notifications'),
          // SETTINGS - Privacy Policy
          buildItem(CustomIcons.privacyPlicyIcon, 'Privacy Policy'),
          // SETTINGS - About
          buildItem(CustomIcons.aboutIcon, 'About'),
          // SETTINGS - Version
          buildItem(CustomIcons.VersionIcon, 'Version'),
          // SETTINGS - Sign out
          buildItem(CustomIcons.signOutIcon, 'Sign out'),
        ],
      ),
    );
  }
}
