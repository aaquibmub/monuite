import 'package:flutter/material.dart';
import 'package:monuite/helpers/models/user.dart';
import 'package:monuite/l10n/app_localizations.dart';
import 'package:monuite/providers/auth.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  Widget buildItem(String label, String value) {
    return Container(
      width: double.infinity,
      height: 64,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(value),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final User? _currentuser = Provider.of<Auth>(context).currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.userProfile,
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
              child: Column(
                children: [
                  buildItem(
                      AppLocalizations.of(context)!.name,
                      _currentuser != null
                          ? _currentuser.firstName! +
                              ' ' +
                              _currentuser.lastName!
                          : AppLocalizations.of(context)!.guest),
                  buildItem(
                      AppLocalizations.of(context)!.email,
                      _currentuser?.email ??
                          AppLocalizations.of(context)!.guest),
                  buildItem(
                      AppLocalizations.of(context)!.country,
                      _currentuser?.shipping.country ??
                          AppLocalizations.of(context)!.guest)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
