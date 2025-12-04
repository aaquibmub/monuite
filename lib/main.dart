import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:monuite/helpers/common/utility.dart';
import 'package:monuite/l10n/app_localizations.dart';
import 'package:monuite/providers/auth.dart';
import 'package:monuite/providers/cart_provider.dart';
import 'package:monuite/providers/common_provider.dart';
import 'package:monuite/providers/order_provider.dart';
import 'package:monuite/providers/product_provider.dart';
import 'package:monuite/screens/home/cart/cart_screen.dart';
import 'package:monuite/screens/home/home_screen.dart';
import 'package:monuite/screens/home/profile_screen.dart';
import 'package:monuite/screens/home/tabs_screen.dart';
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

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  if (message.notification != null) {
    print('Message also contained a notification: ${message.notification}');
  }

  //showDialog(context: context, builder: builder);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = Constants.stripePublishableKey;
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.requestPermission();
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    FirebaseMessaging.instance.subscribeToTopic('admin-notifications');
    print('subscription id: ' + 'admin-notifications');
  });
  await Utility.refreshCart();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  // This widget is the root of your application.
  Future<void> setupInteractedMessage(BuildContext context) async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage, context);
    }

    // Also handle any interaction when the app is in the background using a
    // Stream listener
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleMessage(message, context);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleMessage(message, context);
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  void _handleMessage(RemoteMessage message, BuildContext context) {
    final title = message.notification?.title;
    final body = message.notification?.body;
    // final payload = jsonDecode(data.value['payload'] as String);
    // NotificationPayloadModel payloadModel =
    //     NotificationPayloadModel.fromJson(payload);
    // if (payloadModel.EventId == Constants.notifyDriverDeallocatedVehicalID) {
    //   final payload = jsonDecode(payloadModel.Data);
    //   VehicalDeallocationPayloadModel vdPayload =
    //       VehicalDeallocationPayloadModel.fromJson(payload);
    //   Utility.showVehicalDeallocationDialogue(
    //     context,
    //     vdPayload.DeallocationId,
    //     vdPayload.Vehical,
    //   ).then((value) {
    //     Utility.showMeterReadingDialogue(
    //       context,
    //       vdPayload.DeallocationId,
    //       vdPayload.Vehical,
    //     ).then((value) {
    //       var route = ModalRoute.of(context);
    //       if (route != null) {
    //         if ((route.settings.name == "/" ||
    //             route.settings.name == Routes.homeScreen)) {
    //           Navigator.pushReplacement(
    //             context,
    //             MaterialPageRoute(
    //               builder: (ctx) => TabsScreen(0), // Dashboard
    //             ),
    //           );
    //         }
    //         if (route.settings.name == Routes.vehicalsScreen) {
    //           Navigator.pushReplacement(
    //             context,
    //             MaterialPageRoute(
    //               builder: (ctx) => TabsScreen(2), // Vehicles
    //             ),
    //           );
    //         }
    //       }
    //     });
    //   });
    //   return Future.value();
    // }
    Utility.notificationAlert(
      navigatorKey.currentState!.context,
      title,
      body,
    ).then((value) {
      var route = ModalRoute.of(navigatorKey.currentState!.context);
      if (route != null) {
        if ((route.settings.name == "/" ||
            route.settings.name == Routes.homeScreen)) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (ctx) => TabsScreen(0), // Dashboard
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupInteractedMessage(context);
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
            return ProductProvider(auth.token, auth.currentUser, auth.locale);
          },
          create: (ctx) {
            return ProductProvider(null, null, null);
          },
        ),
      ],
      child: Consumer<Auth>(builder: (ctx, authData, child) {
        // authData.refreshAddressBook();
        return MaterialApp(
          navigatorKey: navigatorKey,
          title: 'monuite',
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
          home: LoginScreen(),
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
            Routes.tabsScreen: (ctx) =>
                TabsScreen(ModalRoute.of(ctx)!.settings.arguments as int? ?? 0),
            Routes.homeScreen: (ctx) => HomeScreen(),
            Routes.cartScreen: (ctx) => CartScreen(),
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
