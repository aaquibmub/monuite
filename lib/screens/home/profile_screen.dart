import 'package:flutter/material.dart';
import 'package:monuite/helpers/common/constants.dart';
import 'package:monuite/helpers/common/custom_icons.dart';
import 'package:monuite/helpers/common/routes.dart';
import 'package:monuite/helpers/common/utility.dart';
import 'package:monuite/helpers/models/user.dart';
import 'package:monuite/l10n/app_localizations.dart';
import 'package:monuite/providers/auth.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Widget buildItem(String icon, String label, Function()? onTap,
      {Widget? trailing}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
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
            ),
            if (trailing != null) Expanded(child: trailing),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final User? _currentuser = Provider.of<Auth>(context).currentUser;

    // String getLanguageIcon() {
    //   final langcode = Provider.of<Auth>(context).locale!.languageCode;
    //   if (langcode == 'fr') {
    //     return CustomIcons.franceFlagIcon;
    //   } else if (langcode == 'it') {
    //     return CustomIcons.italyFlagIcon;
    //   } else if (langcode == 'de') {
    //     return CustomIcons.germanyFlagIcon;
    //   } else {
    //     return CustomIcons.englishFlagIcon;
    //   }
    // }

    // String getLanguageTitle() {
    //   final langcode = Provider.of<Auth>(context).locale!.languageCode;
    //   if (langcode == 'de') {
    //     return 'Deutsch';
    //   } else if (langcode == 'fr') {
    //     return 'Français';
    //   } else if (langcode == 'it') {
    //     return 'Italiano';
    //   } else {
    //     return 'English';
    //   }
    // }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 32),
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
            buildItem(CustomIcons.myOrdersIcon,
                AppLocalizations.of(context)!.myOrders, () {
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
            buildItem(
                CustomIcons.cardsIcon, AppLocalizations.of(context)!.cards, () {
              Navigator.of(context).pushNamed(Routes.cardsScreen);
            }),
            // SETTINGS - Language
            buildItem(CustomIcons.languageIcon,
                AppLocalizations.of(context)!.language, () {
              Navigator.of(context).pushNamed(Routes.languageScreen);
            },
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Image.asset(
                        Utility.getLanguageIcon(context),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        Utility.getLanguageTitle(context),
                        style: TextStyle(
                          fontSize: 16,
                          color: Constants.textColorLight,
                        ),
                      ),
                    )
                  ],
                )),
            // SETTINGS - Push Notifications
            buildItem(CustomIcons.pushNotificationsIcon,
                AppLocalizations.of(context)!.notifications, () {
              Navigator.of(context).pushNamed(Routes.pushNotificationScreen);
            }),
            // SETTINGS - Privacy Policy
            buildItem(CustomIcons.privacyPlicyIcon,
                AppLocalizations.of(context)!.privacyPolicy, () {
              Navigator.of(context).pushNamed(Routes.privacyPolicyScreen);
            }),
            // SETTINGS - About
            buildItem(
                CustomIcons.aboutIcon, AppLocalizations.of(context)!.about, () {
              Navigator.of(context).pushNamed(Routes.aboutScreen);
            }),
            // // SETTINGS - Version
            // buildItem(
            //     CustomIcons.VersionIcon, AppLocalizations.of(context)!.version,
            //     () {
            //   Navigator.of(context).pushNamed(Routes.versionScreen);
            // }),
            // SETTINGS - Sign out
            buildItem(
                CustomIcons.signOutIcon, AppLocalizations.of(context)!.signOut,
                () {
              Provider.of<Auth>(context, listen: false).logout();
              Navigator.of(context).pushReplacementNamed(Routes.loginScreen);
            }),
          ],
        ),
      ),
      bottomNavigationBar: Utility.buildBottomNavigationBar(context, 0),
    );
  }
}
