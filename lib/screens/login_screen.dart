import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:monuite/helpers/common/constants.dart';
import 'package:monuite/helpers/common/custom_icons.dart';
import 'package:monuite/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../helpers/common/routes.dart';
import '../helpers/common/utility.dart';
import '../providers/auth.dart';
import '../screens/loading_screen.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;

  String _userName = '';
  String _password = '';

  void _setUserName(
    String userName,
  ) {
    _userName = userName;
  }

  void _setPassword(
    String password,
  ) {
    _password = password;
  }

  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      var error = await Provider.of<Auth>(
        context,
        listen: false,
      ).login(_userName, _password);

      setState(() {
        _isLoading = false;
      });
      debugger();
      if (error != '') {
        Utility.showErrorDialogue(context, error);
      } else {
        Navigator.of(context).pushReplacementNamed(Routes.homeScreen);
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      final errorMessage =
          AppLocalizations.of(context)!.couldNotAuthenticateYou;
      Utility.showErrorDialogue(context, errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    Widget buildSigninButton() {
      return ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all<Color>(Theme.of(context).primaryColor)),
        onPressed: () => _submit(context),
        child: Text(
          AppLocalizations.of(context)!.signIn,
          style: Theme.of(context).primaryTextTheme.labelLarge,
        ),
        // elevation: 0,
        // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      );
    }

    Widget buildSignupPrivateButton() {
      return ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all<Color>(Theme.of(context).primaryColor)),
        onPressed: () => {
          Navigator.of(context).pushNamed(
            Routes.registerPrivateScreen,
          )
        },
        child: Text(
          AppLocalizations.of(context)!.registerAsPrivateCustomer,
          style: Theme.of(context).primaryTextTheme.labelLarge,
        ),
        // elevation: 0,
        // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      );
    }

    Widget buildSignupCorporateButton() {
      return ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all<Color>(Theme.of(context).primaryColor)),
        onPressed: () => {
          Navigator.of(context).pushNamed(
            Routes.registerCorporateScreen,
          )
        },
        child: Text(
          AppLocalizations.of(context)!.registerAsCorporateCustomer,
          style: Theme.of(context).primaryTextTheme.labelLarge,
        ),
        // elevation: 0,
        // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      );
    }

    Widget buildSignupGuestButton() {
      return ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all<Color>(Theme.of(context).primaryColor)),
        onPressed: () => {
          Navigator.of(context).pushReplacementNamed(
            Routes.homeScreen,
          )
        },
        child: Text(
          AppLocalizations.of(context)!.continueAsGuest,
          style: Theme.of(context).primaryTextTheme.labelLarge,
        ),
        // elevation: 0,
        // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.topRight,
          child: InkWell(
            onTap: () => {
              Navigator.of(context).pushNamed(
                Routes.languageScreen,
              )
            },
            child: Container(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: Image.asset(
                      Utility.getLanguageIcon(context),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      Utility.getLanguageTitle(context),
                      style: TextStyle(
                        fontSize: 16,
                        color: Constants.textColorLight,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: _isLoading
          ? LoadingScreen()
          : SingleChildScrollView(
              child: Center(
                child: Container(
                  height: deviceSize.height,
                  width: deviceSize.width < Constants.deviceTypeTabletMaxWidth
                      ? deviceSize.width
                      : Constants.deviceTypeTabletMaxWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 60,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .signInToYourAccount,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                LoginForm(
                                  _formKey,
                                  _setUserName,
                                  _setPassword,
                                  _submit,
                                  context,
                                ),
                                Container(
                                  alignment: Alignment.topRight,
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text(AppLocalizations.of(context)!
                                        .forgotPassword),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  width: double.infinity,
                                  height: 60,
                                  child: buildSigninButton(),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 40,
                                  child: Center(
                                    child: Text('or'),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  width: double.infinity,
                                  height: 60,
                                  child: buildSignupPrivateButton(),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 10,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  width: double.infinity,
                                  height: 60,
                                  child: buildSignupCorporateButton(),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 10,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  width: double.infinity,
                                  height: 60,
                                  child: buildSignupGuestButton(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (Utility.isPhone(deviceSize))
                        Column(
                          children: [],
                        ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
