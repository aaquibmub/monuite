import 'package:flutter/material.dart';
import 'package:monuite/l10n/app_localizations.dart';

class PushNotificationScreen extends StatelessWidget {
  const PushNotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.notifications,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Body
          Expanded(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              child: Center(
                child: Text('Notifications Screen'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
