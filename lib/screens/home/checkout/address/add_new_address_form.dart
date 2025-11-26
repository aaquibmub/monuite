import 'package:flutter/material.dart';
import 'package:monuite/helpers/common/utility.dart';
import 'package:monuite/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/models/common/dropdown_item.dart';
import '../../../../providers/common_provider.dart';
import '../../../../widgets/form/form_text_field.dart';

class AddNewAddressForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  final void Function(
    String country,
  ) setCountryFn;

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
    String phone,
  ) setPhoneFn;

  final void Function(
    String address1,
  ) setAddress1Fn;

  final void Function(
    String address2,
  ) setAddress2Fn;

  final void Function(
    String city,
  ) setCityFn;

  final void Function(
    String state,
  ) setStateFn;

  final void Function(
    String zipCode,
  ) setZipCodeFn;

  final void Function(
    String email,
  ) setEmailFn;

  final void Function(
    BuildContext context,
  ) submitFormFn;
  final BuildContext parentContext;

  AddNewAddressForm(
    this.formKey,
    this.setCountryFn,
    this.setFirstNameFn,
    this.setLastNameFn,
    this.setCompanyNameFn,
    this.setPhoneFn,
    this.setAddress1Fn,
    this.setAddress2Fn,
    this.setCityFn,
    this.setStateFn,
    this.setZipCodeFn,
    this.setEmailFn,
    this.submitFormFn,
    this.parentContext,
  );

  @override
  State<AddNewAddressForm> createState() => _AddNewAddressFormState();
}

class _AddNewAddressFormState extends State<AddNewAddressForm> {
  // final _passwordFocusNode = FocusNode();
  DropdownItem<String>? _selectedCountry;

  final _firstNameController = TextEditingController();
  // final _firstNameFocusNode = FocusNode();

  final _lastNameController = TextEditingController();
  final _lastNameFocusNode = FocusNode();

  final _companyNameController = TextEditingController();
  final _companyNameFocusNode = FocusNode();

  final _phoneController = TextEditingController();
  final _phoneFocusNode = FocusNode();

  final _address1Controller = TextEditingController();
  final _address1FocusNode = FocusNode();

  final _address2Controller = TextEditingController();
  final _address2FocusNode = FocusNode();

  final _cityController = TextEditingController();
  final _cityFocusNode = FocusNode();

  final _stateController = TextEditingController();
  final _stateFocusNode = FocusNode();

  final _zipCodeController = TextEditingController();
  final _zipCodeFocusNode = FocusNode();

  final _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<CommonProvider>(
      context,
      listen: false,
    ).getCountryDropDownList();

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
            // Country/Region
            Text(
              AppLocalizations.of(context)!.countryRegion,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Container(
              width: double.infinity,
              child: Consumer<CommonProvider>(builder: (ctx, provider, _) {
                _selectedCountry = provider.countryList
                    .where((element) => element.text == 'Schweiz')
                    .firstOrNull;
                widget.setCountryFn(
                  _selectedCountry!.text!,
                );
                return DropdownButton<String>(
                  isExpanded: true,
                  value: _selectedCountry?.value,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      final DropdownItem<String>? item = provider.countryList
                          .where((element) => element.value == value)
                          .first;
                      if (item != null) {
                        String? text = item.text;
                        _selectedCountry = DropdownItem(
                          value,
                          text,
                        );
                        widget.setCountryFn(
                          _selectedCountry!.text!,
                        );
                      }
                    });
                  },
                  selectedItemBuilder: (BuildContext context) {
                    return provider.countryList
                        .map<Widget>((DropdownItem<String> item) {
                      return Container(
                        alignment: Alignment.centerLeft,
                        constraints: const BoxConstraints(
                          maxWidth: double.infinity,
                        ),
                        child: Text(
                          item.text!,
                          style: const TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w600),
                        ),
                      );
                    }).toList();
                  },
                  items: provider.countryList.map<DropdownMenuItem<String>>(
                      (DropdownItem<String> value) {
                    return DropdownMenuItem<String>(
                      value: value.value,
                      child: Text(value.text!),
                    );
                  }).toList(),
                );
              }),
            ),
            SizedBox(
              height: 30,
            ),
            // First Name
            FormTextField(
              fieldLabel: AppLocalizations.of(context)!.firstName,
              hintLabel: AppLocalizations.of(context)!.firstNameHint,
              controller: _firstNameController,
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
            // Last Name
            FormTextField(
              fieldLabel: AppLocalizations.of(context)!.lastName,
              hintLabel: AppLocalizations.of(context)!.lastNameHint,
              controller: _lastNameController,
              validatorFn: (value) {
                if (value!.isEmpty) {
                  return AppLocalizations.of(context)!.lastNameRequired;
                }
                return null;
              },
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
            // Company Name
            FormTextField(
              fieldLabel: AppLocalizations.of(context)!.companyName,
              hintLabel: AppLocalizations.of(context)!.companyNameHint,
              controller: _companyNameController,
              validatorFn: (value) {
                if (value!.isEmpty) {
                  return AppLocalizations.of(context)!.companyNameRequired;
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              onFieldSubmittedFn: (_) {
                FocusScope.of(context).requestFocus(_phoneFocusNode);
              },
              onSaveFn: (value) {
                widget.setCompanyNameFn(value!);
              },
            ),
            SizedBox(
              height: 30,
            ),
            // Phone
            FormTextField(
              fieldLabel: AppLocalizations.of(context)!.phone,
              hintLabel: AppLocalizations.of(context)!.phoneHint,
              controller: _phoneController,
              validatorFn: (value) {
                if (value!.isEmpty) {
                  return AppLocalizations.of(context)!.phoneRequired;
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              onFieldSubmittedFn: (_) {
                FocusScope.of(context).requestFocus(_address1FocusNode);
              },
              onSaveFn: (value) {
                widget.setPhoneFn(value!);
              },
            ),
            SizedBox(
              height: 30,
            ),
            // Address 1
            FormTextField(
              fieldLabel: AppLocalizations.of(context)!.address1,
              hintLabel: AppLocalizations.of(context)!.address1Hint,
              controller: _address1Controller,
              validatorFn: (value) {
                if (value!.isEmpty) {
                  return AppLocalizations.of(context)!.address1Required;
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              onFieldSubmittedFn: (_) {
                FocusScope.of(context).requestFocus(_address2FocusNode);
              },
              onSaveFn: (value) {
                widget.setAddress1Fn(value!);
              },
            ),
            SizedBox(
              height: 30,
            ),
            // Address 2
            FormTextField(
              fieldLabel: AppLocalizations.of(context)!.address2,
              hintLabel: AppLocalizations.of(context)!.address2Hint,
              controller: _address2Controller,
              validatorFn: (value) {
                if (value!.isEmpty) {
                  return AppLocalizations.of(context)!.address2Required;
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              onFieldSubmittedFn: (_) {
                FocusScope.of(context).requestFocus(_cityFocusNode);
              },
              onSaveFn: (value) {
                widget.setAddress2Fn(value!);
              },
            ),
            SizedBox(
              height: 30,
            ),
            // City
            FormTextField(
              fieldLabel: AppLocalizations.of(context)!.city,
              hintLabel: AppLocalizations.of(context)!.cityHint,
              controller: _cityController,
              validatorFn: (value) {
                if (value!.isEmpty) {
                  return AppLocalizations.of(context)!.cityRequired;
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              onFieldSubmittedFn: (_) {
                FocusScope.of(context).requestFocus(_stateFocusNode);
              },
              onSaveFn: (value) {
                widget.setCityFn(value!);
              },
            ),
            SizedBox(
              height: 30,
            ),
            // State
            FormTextField(
              fieldLabel: AppLocalizations.of(context)!.state,
              hintLabel: AppLocalizations.of(context)!.stateHint,
              controller: _stateController,
              validatorFn: (value) {
                if (value!.isEmpty) {
                  return AppLocalizations.of(context)!.stateRequired;
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              onFieldSubmittedFn: (_) {
                FocusScope.of(context).requestFocus(_zipCodeFocusNode);
              },
              onSaveFn: (value) {
                widget.setStateFn(value!);
              },
            ),
            SizedBox(
              height: 30,
            ),
            // Zip Code
            FormTextField(
              fieldLabel: AppLocalizations.of(context)!.zipCode,
              hintLabel: AppLocalizations.of(context)!.zipCodeHint,
              controller: _zipCodeController,
              validatorFn: (value) {
                if (value!.isEmpty) {
                  return AppLocalizations.of(context)!.zipCodeRequired;
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              onFieldSubmittedFn: (_) {
                FocusScope.of(context).requestFocus(_emailFocusNode);
              },
              onSaveFn: (value) {
                widget.setZipCodeFn(value!);
              },
            ),
            SizedBox(
              height: 30,
            ),
            // Email
            FormTextField(
              fieldLabel: AppLocalizations.of(context)!.email,
              hintLabel: AppLocalizations.of(context)!.emailHint,
              controller: _emailController,
              validatorFn: (value) {
                if (value!.isEmpty) {
                  return AppLocalizations.of(context)!.emailRequired;
                }
                if (Utility.validateEmail(value) == false) {
                  return AppLocalizations.of(context)!.emailInvalid;
                }
                return null;
              },
              textInputAction: TextInputAction.done,
              onFieldSubmittedFn: (_) {
                widget.submitFormFn(widget.parentContext);
              },
              onSaveFn: (value) {
                widget.setEmailFn(value!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
