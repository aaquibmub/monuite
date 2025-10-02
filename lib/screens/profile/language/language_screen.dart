import 'package:flutter/material.dart';
import 'package:monuite/helpers/common/constants.dart';
import 'package:monuite/helpers/common/custom_icons.dart';
import 'package:monuite/helpers/common/routes.dart';
import 'package:monuite/l10n/app_localizations.dart';
import 'package:monuite/providers/auth.dart';
import 'package:provider/provider.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    Widget _buildLanguageOption(
      String imageUrl,
      String title,
      Function onTap,
    ) {
      return InkWell(
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: 10,
          ),
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Constants.colorGrey,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 80,
                      margin: EdgeInsets.only(
                        right: 10,
                      ),
                      child: Image.asset(imageUrl),
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_right),
            ],
          ),
        ),
        onTap: () => {onTap()},
      );
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: 32,
              horizontal: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop(Routes.profileScreen);
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Constants.colorGrey,
                      ),
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.language,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(''),
              ],
            ),
          ),
          // Body
          Expanded(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              child: Column(
                children: [
                  _buildLanguageOption(
                    CustomIcons.languageIcon,
                    'English',
                    () {
                      Provider.of<Auth>(context, listen: false).setLocale(
                        Locale('en'),
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                  _buildLanguageOption(
                    CustomIcons.languageIcon,
                    'German',
                    () {
                      Provider.of<Auth>(context, listen: false).setLocale(
                        Locale('de'),
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
