import 'package:flutter/material.dart';

import './form/form_text_field.dart';

class RegisterPrivateForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final void Function(
    String email,
  ) setEmailFn;
  final void Function(
    String password,
  ) setPasswordFn;
  final void Function(
    String telephone,
  ) setTelephoneFn;
  final void Function(
    BuildContext context,
  ) submitFormFn;
  final BuildContext parentContext;
  RegisterPrivateForm(
    this.formKey,
    this.setEmailFn,
    this.setPasswordFn,
    this.setTelephoneFn,
    this.submitFormFn,
    this.parentContext,
  );

  @override
  _RegisterPrivateFormState createState() => _RegisterPrivateFormState();
}

class _RegisterPrivateFormState extends State<RegisterPrivateForm> {
  final _passwordFocusNode = FocusNode();
  final _passwordController = TextEditingController();

  final _telephoneFocusNode = FocusNode();
  final _telephoneController = TextEditingController();

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
                fieldLabel: 'Email',
                hintLabel: 'Type email',
                validatorFn: (value) {
                  if (value!.isEmpty) {
                    return 'Email is required';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                onFieldSubmittedFn: (_) {
                  FocusScope.of(context).requestFocus(_passwordFocusNode);
                },
                onSaveFn: (value) {
                  widget.setEmailFn(value!);
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
                focusNode: _passwordFocusNode,
                textInputAction: TextInputAction.next,
                onFieldSubmittedFn: (_) {
                  FocusScope.of(context).requestFocus(_telephoneFocusNode);
                },
                validatorFn: (value) {
                  if (value!.isEmpty || value.length < 5) {
                    return 'Password is too short!';
                  }
                  return null;
                },
                onSaveFn: (value) {
                  widget.setPasswordFn(value!);
                },
              ),
              SizedBox(
                height: 30,
              ),
              FormTextField(
                fieldLabel: 'Telephone',
                hintLabel: 'Type telephone',
                controller: _telephoneController,
                focusNode: _telephoneFocusNode,
                validatorFn: (value) {
                  if (value!.isEmpty) {
                    return 'Telephone is required';
                  }
                  return null;
                },
                textInputAction: TextInputAction.done,
                onFieldSubmittedFn: (_) {
                  widget.submitFormFn(widget.parentContext);
                },
                onSaveFn: (value) {
                  widget.setTelephoneFn(value!);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
