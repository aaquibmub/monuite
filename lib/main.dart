import 'package:flutter/material.dart';
import 'package:monuite/providers/auth.dart';
import 'package:monuite/screens/home/home_screen.dart';
import 'package:monuite/screens/loading_screen.dart';
import 'package:monuite/screens/login_screen.dart';
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
      ],
      child: Consumer<Auth>(
        builder: (ctx, authData, child) => MaterialApp(
          title: 'motorpool',
          theme: ThemeData(
              primaryColor: Constants.primaryColor,
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
                      fontSize: 62,
                      fontWeight: FontWeight.w300,
                      color: Constants.primaryColor,
                    ),
                    displayMedium: TextStyle(
                      fontSize: 62,
                      fontWeight: FontWeight.bold,
                      color: Constants.textColor,
                    ),
                    displaySmall: TextStyle(
                      fontSize: 40,
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
                backgroundColor: Constants.primaryColor,
              )),
          home: authData.isAuth
              ? HomeScreen()
              : FutureBuilder(
                  future: authData.tryAutoLogin(),
                  builder: (ctx, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? LoadingScreen()
                          : ((snapshot.data != null
                                  ? (snapshot.data as bool)
                                  : false)
                              ? HomeScreen()
                              : LoginScreen()),
                ),
          routes: {
            Routes.loginScreen: (ctx) => LoginScreen(),
            Routes.homeScreen: (ctx) => HomeScreen(),
            // Routes.tripsScreen: (ctx) => TripScreen(),
            // Routes.vehicalsScreen: (ctx) => VehicalsScreen(),
            // Routes.newIncidentScreen: (ctx) => NewIncidentScreen(),
            // Routes.cartDesktopScreen: (ctx) => CartDesktopScreen(),
            // Routes.supportScreen: (ctx) => SupportScreen(),
          },
        ),
      ),
    );
  }
}
