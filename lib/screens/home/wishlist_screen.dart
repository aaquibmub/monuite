import 'package:flutter/material.dart';
import 'package:monuite/l10n/app_localizations.dart';

class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(AppLocalizations.of(context)!.wishlistScreenTitle),
    );
  }
}
