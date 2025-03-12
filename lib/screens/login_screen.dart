import 'package:flutter/material.dart';
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

  String _userName;
  String _password;

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
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
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

      if (error != '') {
        Utility.showErrorDialogue(context, error);
      } else {
        Navigator.of(context).pushReplacementNamed(Routes.homeScreen);
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      const errorMessage = 'Could not authenticate';
      Utility.showErrorDialogue(context, errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    Widget buildSignupButton() {
      return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).primaryColor)),
        onPressed: () => _submit(context),
        child: Text(
          'SIGN IN',
          style: Theme.of(context).primaryTextTheme.labelLarge,
        ),
        // elevation: 0,
        // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? LoadingScreen()
          : SingleChildScrollView(
              child: Center(
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 40,
                                ),
                                Text(
                                  'Sign In',
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Text(
                                  'Welcome back!',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                                SizedBox(
                                  height: 70,
                                ),
                                LoginForm(
                                  _formKey,
                                  _setUserName,
                                  _setPassword,
                                  _submit,
                                  context,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      !Utility.isPhone(deviceSize)
                                          ? MainAxisAlignment.spaceBetween
                                          : MainAxisAlignment.end,
                                  children: [
                                    if (!Utility.isPhone(deviceSize))
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        alignment: Alignment.topRight,
                                        child: buildSignupButton(),
                                      ),
                                    Container(
                                      alignment: Alignment.topRight,
                                      child: TextButton(
                                        onPressed: () {},
                                        child: Text('Forgot Password?'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (Utility.isPhone(deviceSize))
                        Container(
                          width: double.infinity,
                          height: 60,
                          child: buildSignupButton(),
                        ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
