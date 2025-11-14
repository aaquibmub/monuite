import 'package:flutter/material.dart';
import 'package:monuite/helpers/common/utility.dart';
import 'package:monuite/l10n/app_localizations.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.about,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 32,
          horizontal: 8,
        ),
        child: Column(
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
                  child: Text('About Screen'),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Utility.buildBottomNavigationBar(context, 0),
    );
  }
}
