import 'package:flutter/material.dart';
import 'package:monuite/l10n/app_localizations.dart';

import './form/form_text_field.dart';

class RegisterCorporateForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final void Function(
    String firstName,
  ) setFirstNameFn;
  final void Function(
    String lastName,
  ) setLastNameFn;
  final void Function(
    String companyName,
  ) setCompanyNameFn;
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
    String message,
  ) setMessageFn;
  final void Function(
    BuildContext context,
  ) submitFormFn;
  final BuildContext parentContext;
  RegisterCorporateForm(
    this.formKey,
    this.setFirstNameFn,
    this.setLastNameFn,
    this.setCompanyNameFn,
    this.setEmailFn,
    this.setPasswordFn,
    this.setTelephoneFn,
    this.setMessageFn,
    this.submitFormFn,
    this.parentContext,
  );

  @override
  _RegisterCorporateFormState createState() => _RegisterCorporateFormState();
}

class _RegisterCorporateFormState extends State<RegisterCorporateForm> {
  final _lastNameFocusNode = FocusNode();
  final _lastNameController = TextEditingController();

  final _companyNameFocusNode = FocusNode();
  final _companyNameController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _emailController = TextEditingController();

  final _passwordFocusNode = FocusNode();
  final _passwordController = TextEditingController();

  final _telephoneFocusNode = FocusNode();
  final _telephoneController = TextEditingController();

  final _messageFocusNode = FocusNode();
  final _messageController = TextEditingController();

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
                fieldLabel: AppLocalizations.of(context)!.firstName,
                hintLabel: AppLocalizations.of(context)!.firstNameHint,
                validatorFn: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!.firstNameRequired;
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                onFieldSubmittedFn: (_) {
                  FocusScope.of(context).requestFocus(_lastNameFocusNode);
                },
                onSaveFn: (value) {
                  widget.setFirstNameFn(value!);
                },
              ),
              SizedBox(
                height: 30,
              ),
              FormTextField(
                fieldLabel: AppLocalizations.of(context)!.lastName,
                hintLabel: AppLocalizations.of(context)!.lastNameHint,
                validatorFn: (value) {
                  return null;
                },
                controller: _lastNameController,
                focusNode: _lastNameFocusNode,
                textInputAction: TextInputAction.next,
                onFieldSubmittedFn: (_) {
                  FocusScope.of(context).requestFocus(_companyNameFocusNode);
                },
                onSaveFn: (value) {
                  widget.setLastNameFn(value!);
                },
              ),
              SizedBox(
                height: 30,
              ),
              FormTextField(
                fieldLabel: AppLocalizations.of(context)!.companyName,
                hintLabel: AppLocalizations.of(context)!.companyNameHint,
                validatorFn: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!.companyNameRequired;
                  }
                  return null;
                },
                controller: _companyNameController,
                focusNode: _companyNameFocusNode,
                textInputAction: TextInputAction.next,
                onFieldSubmittedFn: (_) {
                  FocusScope.of(context).requestFocus(_emailFocusNode);
                },
                onSaveFn: (value) {
                  widget.setCompanyNameFn(value!);
                },
              ),
              SizedBox(
                height: 30,
              ),
              FormTextField(
                fieldLabel: AppLocalizations.of(context)!.email,
                hintLabel: AppLocalizations.of(context)!.emailHint,
                validatorFn: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!.emailRequired;
                  }
                  return null;
                },
                controller: _emailController,
                focusNode: _emailFocusNode,
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
                hintLabel: AppLocalizations.of(context)!.typePassword,
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
                validatorFn: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!.telephoneIsRequired;
                  }
                  return null;
                },
                controller: _telephoneController,
                focusNode: _telephoneFocusNode,
                textInputAction: TextInputAction.next,
                onFieldSubmittedFn: (_) {
                  FocusScope.of(context).requestFocus(_messageFocusNode);
                },
                onSaveFn: (value) {
                  widget.setTelephoneFn(value!);
                },
              ),
              SizedBox(
                height: 30,
              ),
              FormTextField(
                fieldLabel: AppLocalizations.of(context)!.message,
                hintLabel: AppLocalizations.of(context)!.typeYourMessageHere,
                validatorFn: (value) {
                  return null;
                },
                controller: _messageController,
                focusNode: _messageFocusNode,
                textInputAction: TextInputAction.done,
                onFieldSubmittedFn: (_) {
                  widget.submitFormFn(widget.parentContext);
                },
                onSaveFn: (value) {
                  widget.setMessageFn(value!);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
