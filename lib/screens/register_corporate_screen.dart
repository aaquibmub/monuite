import 'package:flutter/material.dart';
import 'package:monuite/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../helpers/common/routes.dart';
import '../helpers/common/utility.dart';
import '../providers/auth.dart';
import '../screens/loading_screen.dart';
import '../widgets/register_corporate_form.dart';

class RegisterCorporateScreen extends StatefulWidget {
  @override
  _RegisterCorporateScreenState createState() =>
      _RegisterCorporateScreenState();
}

class _RegisterCorporateScreenState extends State<RegisterCorporateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;

  String _firstName = '';
  String _lastName = '';
  String _companyName = '';
  String _email = '';
  String _password = '';
  String _telephone = '';
  String _message = '';

  void _setFistName(
    String firstName,
  ) {
    _firstName = firstName;
  }

  void _setLastName(
    String lastName,
  ) {
    _lastName = lastName;
  }

  void _setCompanyName(
    String companyName,
  ) {
    _companyName = companyName;
  }

  void _setEmail(
    String email,
  ) {
    _email = email;
  }

  void _setPassword(
    String password,
  ) {
    _password = password;
  }

  void _setTelephone(
    String telephone,
  ) {
    _telephone = telephone;
  }

  void _setMessage(
    String message,
  ) {
    _message = message;
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
      ).registerCorporate(
        _firstName,
        _lastName,
        _companyName,
        _email,
        _password,
        _telephone,
        _message,
      );

      setState(() {
        _isLoading = false;
      });

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
          AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgainLater;
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
          AppLocalizations.of(context)!.createAnAccount,
          style: Theme.of(context).primaryTextTheme.labelLarge,
        ),
        // elevation: 0,
        // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      );
    }

    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: _isLoading
          ? LoadingScreen()
          : Center(
              child: Container(
                height: deviceSize.height,
                width: 500,
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
                                height: 20,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.createAnAccount,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .registerAsCorporateCustomer,
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              RegisterCorporateForm(
                                _formKey,
                                _setFistName,
                                _setLastName,
                                _setCompanyName,
                                _setEmail,
                                _setPassword,
                                _setTelephone,
                                _setMessage,
                                _submit,
                                context,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                height: 60,
                                child: buildSigninButton(),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
