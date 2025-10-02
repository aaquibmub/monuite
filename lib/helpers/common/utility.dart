import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monuite/helpers/common/constants.dart';
import 'package:monuite/helpers/common/routes.dart';
import 'package:monuite/helpers/models/addresses/address_book_nodel.dart';
import 'package:monuite/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/auth.dart';
import '../models/user.dart';
import 'shared_types.dart';

class Utility {
  static dynamic getValuebyDeviceSize(
      Size deviceSize, dynamic phone, dynamic tablet, dynamic monitor) {
    return deviceSize.width < Constants.deviceTypePhoneMaxWidth
        ? phone
        : deviceSize.width < Constants.deviceTypeTabletMaxWidth
            ? tablet
            : monitor;
  }

  static DeviceType getDeviceType(Size deviceSize) {
    return deviceSize.width < Constants.deviceTypePhoneMaxWidth
        ? DeviceType.Phone
        : deviceSize.width < Constants.deviceTypeTabletMaxWidth
            ? DeviceType.Tablet
            : DeviceType.Monitor;
  }

  static bool isPhone(Size deviceSize) {
    return Utility.getDeviceType(deviceSize) == DeviceType.Phone;
  }

  static bool isTablet(Size deviceSize) {
    return Utility.getDeviceType(deviceSize) == DeviceType.Tablet;
  }

  static bool isMonitor(Size deviceSize) {
    return Utility.getDeviceType(deviceSize) == DeviceType.Monitor;
  }

  static double getPercentageValue(double maxValue, double percentage) {
    return ((percentage / 100) * maxValue);
  }

  static String convertBase64StringToJsonString(String base64String) {
    return utf8.decode(base64.decode(base64String));
  }

  static String convertStringToBase64String(String str) {
    return base64.encode(utf8.encode(str));
  }

  static void toBeImplemented(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text('Work in progress'),
            content: Text('To be implemented'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text('Okay'))
            ],
          );
        });
  }

  static void errorAlert(BuildContext context, String? title, String msg) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(title ?? "ERROR!"),
            content: Text(msg),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text('Okay'))
            ],
          );
        });
  }

  static Future notificationAlert(
      BuildContext context, String? title, String msg) {
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(title ?? "Notification!"),
            content: Text(msg),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text('Okay'))
            ],
          );
        });
  }

  static String formatHHMMSS(int seconds) {
    int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String hoursStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    // if (hours == 0) {
    //   return "$minutesStr:$secondsStr";
    // }

    return "$hoursStr:$minutesStr:$secondsStr";
  }

  static Map<T, List<S>> myGroupBy<S, T>(
      Iterable<S> values, T Function(S) key) {
    var map = <T, List<S>>{};
    for (var element in values) {
      (map[key(element)] ??= []).add(element);
    }
    return map;
  }

  static Drawer buildDrawer(BuildContext context) {
    final User? _currentuser = Provider.of<Auth>(context).currentUser;

    Widget buildMenuItem(
      BuildContext context,
      String title,
      Function onTap,
    ) {
      return InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          child: Text(
            title,
            style: TextStyle(
              color: Constants.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        onTap: () {
          onTap();
        },
      );
    }

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Constants.primaryColor,
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Hello
                  Container(
                    child: Text(
                      'Hello!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // Name
                  Container(
                    child: Text(
                      (_currentuser != null ? _currentuser.email : ''),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Home
                      buildMenuItem(
                        context,
                        AppLocalizations.of(context)!.home,
                        () {
                          Navigator.of(context).pushReplacementNamed(
                            Routes.homeScreen,
                          );
                        },
                      ),
                      // My Orders
                      buildMenuItem(
                        context,
                        AppLocalizations.of(context)!.myOrders,
                        () {
                          Navigator.of(context).pushNamed(
                            Routes.ordersScreen,
                          );
                        },
                      ),
                      // Address Book
                      buildMenuItem(
                        context,
                        AppLocalizations.of(context)!.addressBook,
                        () {
                          Navigator.of(context).pushNamed(
                            Routes.addressBookScreen,
                          );
                        },
                      ),
                      // Cards
                      buildMenuItem(
                        context,
                        AppLocalizations.of(context)!.cards,
                        () {
                          Navigator.of(context).pushNamed(
                            Routes.cardsScreen,
                          );
                        },
                      ),
                      // Language
                      buildMenuItem(
                        context,
                        AppLocalizations.of(context)!.language,
                        () {
                          Navigator.of(context).pushNamed(
                            Routes.languageScreen,
                          );
                        },
                      ),
                      // Push Notifications
                      buildMenuItem(
                        context,
                        AppLocalizations.of(context)!.pushNotifications,
                        () {
                          Navigator.of(context).pushNamed(
                            Routes.pushNotificationScreen,
                          );
                        },
                      ),
                      // Privacy Policy
                      buildMenuItem(
                        context,
                        AppLocalizations.of(context)!.privacyPolicy,
                        () {
                          Navigator.of(context).pushNamed(
                            Routes.privacyPolicyScreen,
                          );
                        },
                      ),
                      // About
                      buildMenuItem(
                        context,
                        AppLocalizations.of(context)!.about,
                        () {
                          Navigator.of(context).pushNamed(
                            Routes.aboutScreen,
                          );
                        },
                      ),
                      // Version
                      buildMenuItem(
                        context,
                        AppLocalizations.of(context)!.version,
                        () {
                          Navigator.of(context).pushNamed(
                            Routes.versionScreen,
                          );
                        },
                      ),
                      // // Categories
                      // Container(
                      //   height: 507,
                      //   child: FutureBuilder(
                      //       future: Provider.of<ProductProvider>(context,
                      //               listen: false)
                      //           .populateCategoryList(),
                      //       builder: (ctx, data) {
                      //         if (data.connectionState ==
                      //             ConnectionState.waiting) {
                      //           return LoadingScreen();
                      //         }
                      //         return Container(
                      //           child: Consumer<ProductProvider>(
                      //             builder: (ctx, provider, _) {
                      //               return provider.allCategories.length > 0
                      //                   ? SingleChildScrollView(
                      //                       scrollDirection: Axis.horizontal,
                      //                       child: Column(
                      //                           crossAxisAlignment:
                      //                               CrossAxisAlignment.start,
                      //                           mainAxisAlignment:
                      //                               MainAxisAlignment.start,
                      //                           children: <Widget>[
                      //                             ...provider.allCategories.map(
                      //                               (e) => buildMenuItem(
                      //                                   context, e.name, () {
                      //                                 Navigator.push(
                      //                                   context,
                      //                                   MaterialPageRoute(
                      //                                       builder: (context) =>
                      //                                           CategoryDetailScreen(
                      //                                             e.id,
                      //                                             e.name,
                      //                                           )),
                      //                                 );
                      //                                 ;
                      //                               }),
                      //                             ),
                      //                           ]),
                      //                     )
                      //                   : Center(
                      //                       child: Text("no categories found"),
                      //                     );
                      //             },
                      //           ),
                      //         );
                      //       }),
                      // ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 16,
                  ),
                  child: buildMenuItem(
                    context,
                    AppLocalizations.of(context)!.logout,
                    () {
                      Navigator.of(context)
                          .pushReplacementNamed(Routes.loginScreen);
                      Provider.of<Auth>(
                        context,
                        listen: false,
                      ).logout();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ), // Populate the Drawer in the next step.
    );
  }

  static void showErrorDialogue(BuildContext context, String message,
      [String? title]) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(title ?? AppLocalizations.of(context)!.anErrorOccurred),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text(AppLocalizations.of(context)!.okay))
            ],
          );
        });
  }

  // static Future<void> makePhoneCall(String phoneNumber) async {
  //   await launch("tel://$phoneNumber");
  // }

  static String formatNumber(double? number) {
    final formatter = NumberFormat('#,##0.00', 'en_US');
    return formatter.format(number);
  }

  static Color getColorFromHex(String? hexColor) {
    return hexColor != null
        ? Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0x80000000)
        : Colors.black;
  }

  static Future<List<AddressBookModel>> getAddressBook() async {
    final prefs = await SharedPreferences.getInstance();
    List<AddressBookModel> addressBook = [];
    final addressBookStr = prefs.getString('addressBook');
    if (addressBookStr == null || addressBookStr.isEmpty) {
      addressBook = [];
    } else {
      final List<dynamic> addressList = json.decode(addressBookStr);
      addressBook = addressList
          .map((address) => AddressBookModel.fromJson(address))
          .toList();
    }
    return addressBook;
  }
}
