import 'package:flutter/material.dart';
import 'package:monuite/l10n/app_localizations.dart';
import 'package:monuite/providers/auth.dart';
import 'package:monuite/providers/cart_provider.dart';
import 'package:monuite/providers/common_provider.dart';
import 'package:monuite/providers/order_provider.dart';
import 'package:monuite/providers/product_provider.dart';
import 'package:monuite/screens/home/home_screen.dart';
import 'package:monuite/screens/home/profile_screen.dart';
import 'package:monuite/screens/login_screen.dart';
import 'package:monuite/screens/orders/order_list_screen.dart';
import 'package:monuite/screens/products/product_list_screen.dart';
import 'package:monuite/screens/profile/about/about_screen.dart';
import 'package:monuite/screens/profile/address-book/address-book-screen.dart';
import 'package:monuite/screens/profile/cards/cards_screen.dart';
import 'package:monuite/screens/profile/language/language_screen.dart';
import 'package:monuite/screens/profile/privacy_policy/privacy_policy_screen.dart';
import 'package:monuite/screens/profile/push_notifications/push_notification_screen.dart';
import 'package:monuite/screens/profile/version/version_screen.dart';
import 'package:monuite/screens/register_corporate_screen.dart';
import 'package:monuite/screens/regsiter_private_screen.dart';
import 'package:monuite/screens/profile/user-profile/user-profile-screen.dart';
import 'package:provider/provider.dart';

import 'helpers/common/constants.dart';
import 'helpers/common/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) {
            return Auth();
          },
        ),
        ChangeNotifierProvider(
          create: (ctx) {
            return CommonProvider();
          },
        ),
        ChangeNotifierProxyProvider<Auth, CartProvider>(
          update: (ctx, auth, _) {
            return CartProvider(auth.token, auth.currentUser);
          },
          create: (ctx) {
            return CartProvider(null, null);
          },
        ),
        ChangeNotifierProxyProvider<Auth, OrderProvider>(
          update: (ctx, auth, _) {
            return OrderProvider(auth.token, auth.currentUser);
          },
          create: (ctx) {
            return OrderProvider(null, null);
          },
        ),
        ChangeNotifierProxyProvider<Auth, ProductProvider>(
          update: (ctx, auth, _) {
            return ProductProvider(auth.token, auth.currentUser);
          },
          create: (ctx) {
            return ProductProvider(null, null);
          },
        ),
      ],
      child: Consumer<Auth>(builder: (ctx, authData, child) {
        // authData.refreshAddressBook();
        return MaterialApp(
          title: 'motorpool',
          locale: authData.locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          theme: ThemeData(
              primaryColor: Constants.primaryColor,
              // backgroundColor: Constants.backgroundColor,
              fontFamily: Constants.fontFamilyMontserrat,
              primaryTextTheme: Theme.of(context).primaryTextTheme.copyWith(
                    labelLarge: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
              inputDecorationTheme:
                  Theme.of(context).inputDecorationTheme.copyWith(
                        hintStyle: TextStyle(
                          color: Constants.textFieldHintColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
              textTheme: Theme.of(context).textTheme.copyWith(
                    displayLarge: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w300,
                      color: Constants.primaryColor,
                    ),
                    displayMedium: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Constants.textColor,
                    ),
                    displaySmall: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Constants.textColor,
                    ),
                    headlineMedium: TextStyle(
                      fontSize: 32,
                      color: Constants.textColor,
                    ),
                    bodyLarge: TextStyle(
                      fontSize: 18,
                      color: Constants.textColor,
                    ),
                  ),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              scaffoldBackgroundColor: Constants.backgroundColor,
              appBarTheme: AppBarTheme.of(context).copyWith(
                backgroundColor: Constants.backgroundColor,
                iconTheme: IconThemeData(
                  color: Constants.primaryColor,
                ),
              )),
          home: HomeScreen(),
          // authData.isAuth
          //     ? HomeScreen()
          //     : FutureBuilder(
          //         future: authData.tryAutoLogin(),
          //         builder: (ctx, snapshot) =>
          //             snapshot.connectionState == ConnectionState.waiting
          //                 ? LoadingScreen()
          //                 : ((snapshot.data != null
          //                         ? (snapshot.data as bool)
          //                         : false)
          //                     ? HomeScreen()
          //                     : LoginScreen()),
          //       ),
          routes: {
            Routes.loginScreen: (ctx) => LoginScreen(),
            Routes.registerPrivateScreen: (ctx) => RegisterPrivateScreen(),
            Routes.registerCorporateScreen: (ctx) => RegisterCorporateScreen(),
            Routes.homeScreen: (ctx) => HomeScreen(),
            Routes.ordersScreen: (ctx) => OrderListScreen(''),
            Routes.productsScreen: (ctx) => ProductListScreen(''),
            Routes.profileScreen: (ctx) => ProfileScreen(),
            Routes.userProfileScreen: (ctx) => UserProfileScreen(),
            Routes.addressBookScreen: (ctx) => AddressBookScreen(),
            Routes.cardsScreen: (ctx) => CardsScreen(),
            Routes.languageScreen: (ctx) => LanguageScreen(),
            Routes.pushNotificationScreen: (ctx) => PushNotificationScreen(),
            Routes.aboutScreen: (ctx) => AboutScreen(),
            Routes.privacyPolicyScreen: (ctx) => PrivacyPolicyScreen(),
            Routes.versionScreen: (ctx) => VersionScreen(),
          },
        );
      }),
    );
  }
}
