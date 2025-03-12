import 'package:flutter/material.dart';
import 'package:monuite/screens/home/tabs_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Future<dynamic> onMessage(message) async {
  //   // print('onMessage: ' + message);
  //   await Provider.of<Auth>(context, listen: false).refreshUserData();
  //   final notificationStr = message.entries.toList();
  //   final notification = notificationStr.first;
  //   // final data = notificationStr[1];
  //   if (notification != null) {
  //     final title = notification.value['title'];
  //     final body = notification.value['body'];
  //     // final payload = jsonDecode(data.value['payload'] as String);
  //     // NotificationPayloadModel payloadModel =
  //     //     NotificationPayloadModel.fromJson(payload);
  //     // if (payloadModel.EventId == Constants.notifyDriverDeallocatedVehicalID) {
  //     //   final payload = jsonDecode(payloadModel.Data);
  //     //   VehicalDeallocationPayloadModel vdPayload =
  //     //       VehicalDeallocationPayloadModel.fromJson(payload);
  //     //   Utility.showVehicalDeallocationDialogue(
  //     //     context,
  //     //     vdPayload.DeallocationId,
  //     //     vdPayload.Vehical,
  //     //   ).then((value) {
  //     //     Utility.showMeterReadingDialogue(
  //     //       context,
  //     //       vdPayload.DeallocationId,
  //     //       vdPayload.Vehical,
  //     //     ).then((value) {
  //     //       var route = ModalRoute.of(context);
  //     //       if (route != null) {
  //     //         if ((route.settings.name == "/" ||
  //     //             route.settings.name == Routes.homeScreen)) {
  //     //           Navigator.pushReplacement(
  //     //             context,
  //     //             MaterialPageRoute(
  //     //               builder: (ctx) => TabsScreen(0), // Dashboard
  //     //             ),
  //     //           );
  //     //         }
  //     //         if (route.settings.name == Routes.vehicalsScreen) {
  //     //           Navigator.pushReplacement(
  //     //             context,
  //     //             MaterialPageRoute(
  //     //               builder: (ctx) => TabsScreen(2), // Vehicles
  //     //             ),
  //     //           );
  //     //         }
  //     //       }
  //     //     });
  //     //   });
  //     //   return Future.value();
  //     // }
  //     Utility.notificationAlert(
  //       context,
  //       title,
  //       body,
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
  //       }
  //     });
  //   }
  //   return Future.value();
  // }

  // @override
  // void initState() {
  //   print('before firebase messaging');
  //   final fbm = FirebaseMessaging();
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     User currentUser = Provider.of<Auth>(context, listen: false).currentUser;
  //     fbm.subscribeToTopic(currentUser?.id);
  //     print('subscription id: ' + currentUser?.id);
  //   });
  //   fbm.requestNotificationPermissions();
  //   print('before firebase configuration');
  //   fbm.configure(
  //       onMessage: onMessage, onResume: onMessage, onLaunch: onMessage);
  //   print('after firebase configuration');
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabsScreen(0),
      // body: Container(
      //   padding: !Utility.isPhone(deviceSize)
      //       ? EdgeInsets.all(50)
      //       : EdgeInsets.symmetric(vertical: 50),
      //   child: SingleChildScrollView(
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Container(
      //               margin: EdgeInsets.only(left: 8),
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Text(
      //                     'Welcome back!',
      //                     style: TextStyle(
      //                       fontSize: (Utility.getValuebyDeviceSize(
      //                           deviceSize, 24.0, 40.0, 62.0) as double),
      //                       fontWeight: FontWeight.w300,
      //                       color: Constants.primaryColor,
      //                     ),
      //                   ),
      //                   Consumer<Auth>(
      //                     builder: (ctx, authData, _) => Text(
      //                       authData.userName ?? "",
      //                       style: TextStyle(
      //                         fontSize: (Utility.getValuebyDeviceSize(
      //                             deviceSize, 16.0, 32.0, 48.0) as double),
      //                         fontWeight: FontWeight.w300,
      //                         color: Constants.primaryColor,
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             if (!Utility.isPhone(deviceSize))
      //               Container(
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.end,
      //                   children: [
      //                     Text(
      //                       'Tuesday, November 20, 2020',
      //                       style: TextStyle(
      //                         fontSize: (Utility.getValuebyDeviceSize(
      //                             deviceSize, 24.0, 24.0, 41.0) as double),
      //                         color: Constants.textColor,
      //                       ),
      //                     ),
      //                     Text(
      //                       '3:10 AM',
      //                       style: TextStyle(
      //                         fontSize: (Utility.getValuebyDeviceSize(
      //                             deviceSize, 24.0, 24.0, 41.0) as double),
      //                         color: Constants.textColor,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //           ],
      //         ),
      //         SizedBox(
      //           height: 20,
      //         ),
      //         GridView(
      //           padding: EdgeInsets.symmetric(
      //             horizontal: 8,
      //           ),
      //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //             crossAxisCount:
      //                 (Utility.getValuebyDeviceSize(deviceSize, 2, 4, 8)
      //                     as int),
      //             // childAspectRatio: 3 / 2,
      //             crossAxisSpacing: (Utility.getValuebyDeviceSize(
      //                 deviceSize, 15.0, 20.0, 40.0) as double),
      //             mainAxisSpacing: (Utility.getValuebyDeviceSize(
      //                 deviceSize, 20.0, 40.0, 80.0) as double),
      //           ),
      //           physics: ScrollPhysics(),
      //           scrollDirection: Axis.vertical,
      //           shrinkWrap: true,
      //           children: gridActions
      //               .map((e) => InkWell(
      //                     onTap: e['action'] as Function,
      //                     child: FittedBox(
      //                       child: Column(
      //                         children: [
      //                           Container(
      //                             height: (Utility.getValuebyDeviceSize(
      //                                     deviceSize, 160.0, 180.0, 200.0)
      //                                 as double),
      //                             width: (Utility.getValuebyDeviceSize(
      //                                     deviceSize, 180.0, 180.0, 200.0)
      //                                 as double),
      //                             decoration: BoxDecoration(
      //                               color: Constants.primaryColor,
      //                             ),
      //                             child: Center(
      //                               child: Icon(
      //                                 e['icon'] as IconData,
      //                                 size: (Utility.getValuebyDeviceSize(
      //                                         deviceSize, 70.0, 90.0, 100.0)
      //                                     as double),
      //                                 color: Colors.white,
      //                               ),
      //                             ),
      //                           ),
      //                           SizedBox(
      //                             height: (Utility.getValuebyDeviceSize(
      //                                 deviceSize, 15.0, 20.0, 30.0) as double),
      //                           ),
      //                           Text(
      //                             e['title'].toString(),
      //                             style: TextStyle(
      //                               fontSize: (Utility.getValuebyDeviceSize(
      //                                       deviceSize, 20.0, 20.0, 24.0)
      //                                   as double),
      //                               fontWeight: FontWeight.w600,
      //                               color: Constants.primaryColor,
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   ))
      //               .toList(),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
