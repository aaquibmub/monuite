import 'package:flutter/material.dart';
import 'package:monuite/l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionScreen extends StatelessWidget {
  const VersionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.version,
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
                child: FutureBuilder<PackageInfo>(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final packageInfo = snapshot.data!;
                      return Text(
                        'Version: ${packageInfo.version}',
                        style: const TextStyle(fontSize: 18),
                      );
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
