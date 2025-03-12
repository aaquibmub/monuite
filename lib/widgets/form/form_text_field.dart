import 'package:flutter/material.dart';

import '../../helpers/common/constants.dart';

class FormTextField extends StatelessWidget {
  final String fieldLabel;
  final String hintLabel;
  final TextInputType keyboardType;
  final String Function(String value) validatorFn;
  final void Function(String value) onSaveFn;
  final void Function(String value) onFieldSubmittedFn;
  final bool obscureText;
  final bool readonly;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final TextEditingController controller;

  FormTextField({
    @required this.fieldLabel,
    @required this.validatorFn,
    @required this.onSaveFn,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.readonly = false,
    this.controller,
    this.hintLabel,
    this.textInputAction,
    this.onFieldSubmittedFn,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fieldLabel,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: TextFormField(
              keyboardType: keyboardType,
              readOnly: readonly,
              controller: controller,
              obscureText: obscureText,
              decoration: InputDecoration(
                hintText: hintLabel,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 10,
                ),
                filled: true,
                fillColor: Constants.textFieldFillColor,
                focusColor: Constants.textFieldFillColor,
                focusedBorder: InputBorder.none,
              ),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              validator: validatorFn,
              onSaved: onSaveFn,
              onFieldSubmitted: onFieldSubmittedFn,
              textInputAction: textInputAction,
              focusNode: focusNode,
            ),
          ),
        ],
      ),
    );
  }
}
