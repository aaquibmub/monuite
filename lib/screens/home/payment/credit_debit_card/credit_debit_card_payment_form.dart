import 'package:flutter/material.dart';
import 'package:monuite/l10n/app_localizations.dart';

import '../../../../widgets/form/form_text_field.dart';

class CreditDebitCardPaymentForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  final void Function(
    String number,
  ) setNumberFn;

  final void Function(
    String expYear,
  ) setExpYearFn;

  final void Function(
    String expMonth,
  ) setExpMonthFn;

  final void Function(
    String cvc,
  ) setCvcFn;

  final void Function(
    BuildContext context,
  ) submitFormFn;
  final BuildContext parentContext;

  CreditDebitCardPaymentForm(
    this.formKey,
    this.setNumberFn,
    this.setExpYearFn,
    this.setExpMonthFn,
    this.setCvcFn,
    this.submitFormFn,
    this.parentContext,
  );

  @override
  State<CreditDebitCardPaymentForm> createState() =>
      _CreditDebitCardPaymentFormState();
}

class _CreditDebitCardPaymentFormState
    extends State<CreditDebitCardPaymentForm> {
  final _numberController = TextEditingController();
  // final _firstNameFocusNode = FocusNode();

  final _expYearController = TextEditingController();
  final _expYearFocusNode = FocusNode();

  final _expMonthController = TextEditingController();
  final _expMonthFocusNode = FocusNode();

  final _cvcController = TextEditingController();
  final _cvcFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Form(
        key: widget.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            // Card Number
            FormTextField(
              fieldLabel: AppLocalizations.of(context)!.number,
              hintLabel: AppLocalizations.of(context)!.numberHint,
              controller: _numberController,
              validatorFn: (value) {
                if (value!.isEmpty) {
                  return AppLocalizations.of(context)!.numberRequired;
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              onFieldSubmittedFn: (_) {
                FocusScope.of(context).requestFocus(_expYearFocusNode);
              },
              onSaveFn: (value) {
                widget.setNumberFn(value!);
              },
            ),
            SizedBox(
              height: 30,
            ),
            // exp Year
            FormTextField(
              fieldLabel: AppLocalizations.of(context)!.expYear,
              hintLabel: AppLocalizations.of(context)!.expYearHint,
              controller: _expYearController,
              validatorFn: (value) {
                if (value!.isEmpty) {
                  return AppLocalizations.of(context)!.expYearRequired;
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              onFieldSubmittedFn: (_) {
                FocusScope.of(context).requestFocus(_expMonthFocusNode);
              },
              onSaveFn: (value) {
                widget.setExpYearFn(value!);
              },
            ),
            SizedBox(
              height: 30,
            ),
            // Exp Month
            FormTextField(
              fieldLabel: AppLocalizations.of(context)!.expMonth,
              hintLabel: AppLocalizations.of(context)!.expMonthHint,
              controller: _expMonthController,
              validatorFn: (value) {
                if (value!.isEmpty) {
                  return AppLocalizations.of(context)!.expMonthRequired;
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              onFieldSubmittedFn: (_) {
                FocusScope.of(context).requestFocus(_cvcFocusNode);
              },
              onSaveFn: (value) {
                widget.setExpMonthFn(value!);
              },
            ),
            SizedBox(
              height: 30,
            ),
            // CVC
            FormTextField(
              fieldLabel: AppLocalizations.of(context)!.cvc,
              hintLabel: AppLocalizations.of(context)!.cvcHint,
              controller: _cvcController,
              validatorFn: (value) {
                if (value!.isEmpty) {
                  return AppLocalizations.of(context)!.cvcRequired;
                }
                return null;
              },
              textInputAction: TextInputAction.done,
              onFieldSubmittedFn: (_) {
                widget.submitFormFn(widget.parentContext);
              },
              onSaveFn: (value) {
                widget.setCvcFn(value!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
