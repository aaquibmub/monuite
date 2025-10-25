import 'package:flutter/material.dart';
import 'package:monuite/l10n/app_localizations.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.cards,
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
                child: Text('Cards Screen'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
