import 'package:flutter/material.dart';

import './form/form_text_field.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final void Function(
    String userName,
  ) setUserNameFn;
  final void Function(
    String password,
  ) setPasswordFn;
  final void Function(
    BuildContext context,
  ) submitFormFn;
  final BuildContext parentContext;
  LoginForm(
    this.formKey,
    this.setUserNameFn,
    this.setPasswordFn,
    this.submitFormFn,
    this.parentContext,
  );

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _passwordFocusNode = FocusNode();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Form(
        key: widget.formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FormTextField(
                fieldLabel: 'User',
                hintLabel: 'Type user name',
                validatorFn: (value) {
                  if (value.isEmpty) {
                    return 'User name is required';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                onFieldSubmittedFn: (_) {
                  FocusScope.of(context).requestFocus(_passwordFocusNode);
                },
                onSaveFn: (value) {
                  widget.setUserNameFn(value);
                },
              ),
              SizedBox(
                height: 30,
              ),
              FormTextField(
                fieldLabel: 'Password',
                hintLabel: 'Type password',
                obscureText: true,
                controller: _passwordController,
                textInputAction: TextInputAction.done,
                focusNode: _passwordFocusNode,
                onFieldSubmittedFn: (_) {
                  widget.submitFormFn(widget.parentContext);
                },
                validatorFn: (value) {
                  if (value.isEmpty || value.length < 5) {
                    return 'Password is too short!';
                  }
                  return null;
                },
                onSaveFn: (value) {
                  widget.setPasswordFn(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
