import 'package:flutter/material.dart';
import 'package:monuite/helpers/common/utility.dart';
import 'package:monuite/helpers/models/addresses/address_model.dart';
import 'package:monuite/l10n/app_localizations.dart';
import 'package:monuite/providers/cart_provider.dart';
import 'package:monuite/screens/home/checkout/address/edit_address_form.dart';
import 'package:monuite/screens/loading_screen.dart';
import 'package:provider/provider.dart';

class EditAddressScreen extends StatefulWidget {
  final AddressModel address;

  const EditAddressScreen(this.address, {Key? key}) : super(key: key);

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  bool _isLoading = false;

  String _country = 'Switzerland'; // Default country
  String _firstName = '';
  String _lastName = '';
  String _companyName = '';
  String _phone = '';
  String _address1 = '';
  String _address2 = '';
  String _city = '';
  String _state = '';
  String _zipCode = '';
  String _email = '';

  void _setCountry(
    String country,
  ) {
    _country = country;
  }

  void _setFirstName(
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

  void _setPhone(
    String phone,
  ) {
    _phone = phone;
  }

  void _setAddress1(
    String address1,
  ) {
    _address1 = address1;
  }

  void _setAddress2(
    String address2,
  ) {
    _address2 = address2;
  }

  void _setCity(
    String city,
  ) {
    _city = city;
  }

  void _setState(
    String state,
  ) {
    _state = state;
  }

  void _setZipCode(
    String zipCode,
  ) {
    _zipCode = zipCode;
  }

  void _setEmail(
    String email,
  ) {
    _email = email;
  }

  void _showErrorDialogue(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.anErrorOccurred),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text(AppLocalizations.of(context)!.okay))
            ],
          );
        });
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
      await Provider.of<CartProvider>(
        context,
        listen: false,
      ).updateAddress(
        AddressModel(
          _country,
          _firstName,
          _lastName,
          _companyName,
          _address1,
          _address2,
          _city,
          _state,
          _zipCode,
          _phone,
          _email,
        ),
      );

      setState(() {
        _isLoading = false;
      });

      Navigator.pop(context);
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      final errorMessage = AppLocalizations.of(context)!.couldNotUpdateAddress;
      _showErrorDialogue(context, errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    Widget buildUpdateButton() {
      return ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all<Color>(Theme.of(context).primaryColor)),
        onPressed: () => _submit(context),
        child: Text(
          AppLocalizations.of(context)!.updateAddressInCapitalLetters,
          style: Theme.of(context).primaryTextTheme.labelLarge,
        ),
        // elevation: 0,
        // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.updateAddress),
      ),
      body: _isLoading
          ? LoadingScreen()
          : Container(
              height: deviceSize.height,
              width: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          EditAddressForm(
                            _formKey,
                            _setCountry,
                            _setFirstName,
                            _setLastName,
                            _setCompanyName,
                            _setPhone,
                            _setAddress1,
                            _setAddress2,
                            _setCity,
                            _setState,
                            _setZipCode,
                            _setEmail,
                            _submit,
                            widget.address,
                            context,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    margin: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: buildUpdateButton(),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: Utility.buildBottomNavigationBar(context, 2),
    );
  }
}
