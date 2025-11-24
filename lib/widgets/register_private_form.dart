import 'package:flutter/material.dart';
import 'package:monuite/l10n/app_localizations.dart';

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
                fieldLabel: AppLocalizations.of(context)!.email,
                hintLabel: AppLocalizations.of(context)!.typeYourEmail,
                validatorFn: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!.emailIsRequired;
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
                fieldLabel: AppLocalizations.of(context)!.password,
                hintLabel: AppLocalizations.of(context)!.typeYourPassword,
                obscureText: true,
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                textInputAction: TextInputAction.next,
                onFieldSubmittedFn: (_) {
                  FocusScope.of(context).requestFocus(_telephoneFocusNode);
                },
                validatorFn: (value) {
                  if (value!.isEmpty || value.length < 6) {
                    return AppLocalizations.of(context)!
                        .passwordMustBeAtLeast6Characters;
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
                fieldLabel: AppLocalizations.of(context)!.telephone,
                hintLabel: AppLocalizations.of(context)!.typeYourTelephone,
                controller: _telephoneController,
                focusNode: _telephoneFocusNode,
                validatorFn: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!.telephoneIsRequired;
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
