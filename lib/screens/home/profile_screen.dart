import 'package:flutter/material.dart';
import 'package:monuite/helpers/common/constants.dart';
import 'package:monuite/helpers/common/custom_icons.dart';
import 'package:monuite/helpers/common/routes.dart';
import 'package:monuite/helpers/models/user.dart';
import 'package:monuite/l10n/app_localizations.dart';
import 'package:monuite/providers/auth.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Widget buildItem(String icon, String label, Function()? onTap) {
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
      child: InkWell(
        onTap: onTap,
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
                  : AppLocalizations.of(context)!.guest,
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
              AppLocalizations.of(context)!.orders,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          // ORDERS - My Orders
          buildItem(
              CustomIcons.myOrdersIcon, AppLocalizations.of(context)!.myOrders,
              () {
            Navigator.of(context).pushNamed(Routes.ordersScreen);
          }),
          // SETTINGS
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
            ),
            child: Text(
              AppLocalizations.of(context)!.settings,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          // SETTINGS - Profile
          buildItem(
              CustomIcons.profileIcon, AppLocalizations.of(context)!.profile,
              () {
            Navigator.of(context).pushNamed(Routes.userProfileScreen);
          }),
          // SETTINGS - Address Book
          buildItem(CustomIcons.addressBookIcon,
              AppLocalizations.of(context)!.addressBook, () {
            Navigator.of(context).pushNamed(Routes.addressBookScreen);
          }),
          // SETTINGS - Cards
          buildItem(CustomIcons.cardsIcon, AppLocalizations.of(context)!.cards,
              () {
            Navigator.of(context).pushNamed(Routes.cardsScreen);
          }),
          // SETTINGS - Language
          buildItem(
              CustomIcons.languageIcon, AppLocalizations.of(context)!.language,
              () {
            Navigator.of(context).pushNamed(Routes.languageScreen);
          }),
          // SETTINGS - Push Notifications
          buildItem(CustomIcons.pushNotificationsIcon,
              AppLocalizations.of(context)!.pushNotifications, () {
            Navigator.of(context).pushNamed(Routes.pushNotificationScreen);
          }),
          // SETTINGS - Privacy Policy
          buildItem(CustomIcons.privacyPlicyIcon,
              AppLocalizations.of(context)!.privacyPolicy, () {
            Navigator.of(context).pushNamed(Routes.privacyPolicyScreen);
          }),
          // SETTINGS - About
          buildItem(CustomIcons.aboutIcon, AppLocalizations.of(context)!.about,
              () {
            Navigator.of(context).pushNamed(Routes.aboutScreen);
          }),
          // SETTINGS - Version
          buildItem(
              CustomIcons.VersionIcon, AppLocalizations.of(context)!.version,
              () {
            Navigator.of(context).pushNamed(Routes.versionScreen);
          }),
          // SETTINGS - Sign out
          buildItem(
              CustomIcons.signOutIcon, AppLocalizations.of(context)!.signOut,
              () {
            Provider.of<Auth>(context, listen: false).logout();
            Navigator.of(context).pushReplacementNamed(Routes.loginScreen);
          }),
        ],
      ),
    );
  }
}
