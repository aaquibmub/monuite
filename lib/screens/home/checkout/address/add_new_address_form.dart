import 'package:flutter/material.dart';
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
              'Country/Region',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Container(
              width: double.infinity,
              child: Consumer<CommonProvider>(builder: (ctx, provider, _) {
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
              fieldLabel: 'First Name',
              hintLabel: 'Type first name',
              controller: _firstNameController,
              validatorFn: (value) {
                if (value!.isEmpty) {
                  return 'First name is required';
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
              fieldLabel: 'Last Name',
              hintLabel: 'Type last name',
              controller: _lastNameController,
              validatorFn: (value) {
                if (value!.isEmpty) {
                  return 'Last name is required';
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
              fieldLabel: 'Company Name',
              hintLabel: 'Type company name',
              controller: _companyNameController,
              validatorFn: (value) {
                if (value!.isEmpty) {
                  return 'Company name is required';
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
              fieldLabel: 'Phone',
              hintLabel: 'Type phone number',
              controller: _phoneController,
              validatorFn: (value) {
                if (value!.isEmpty) {
                  return 'Phone number is required';
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
              fieldLabel: 'Address 1',
              hintLabel: 'Type address 1',
              controller: _address1Controller,
              validatorFn: (value) {
                if (value!.isEmpty) {
                  return 'Address 1 is required';
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
              fieldLabel: 'Address 2',
              hintLabel: 'Type address 2',
              controller: _address2Controller,
              validatorFn: (value) {
                if (value!.isEmpty) {
                  return 'Address 2 is required';
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
              fieldLabel: 'City',
              hintLabel: 'Type city',
              controller: _cityController,
              validatorFn: (value) {
                if (value!.isEmpty) {
                  return 'City is required';
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
              fieldLabel: 'State',
              hintLabel: 'Type state',
              controller: _stateController,
              validatorFn: (value) {
                if (value!.isEmpty) {
                  return 'State is required';
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
              fieldLabel: 'Zip Code',
              hintLabel: 'Type zip code',
              controller: _zipCodeController,
              validatorFn: (value) {
                if (value!.isEmpty) {
                  return 'Zip code is required';
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
              fieldLabel: 'Email',
              hintLabel: 'Type email',
              controller: _emailController,
              validatorFn: (value) {
                if (value!.isEmpty) {
                  return 'Email is required';
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
