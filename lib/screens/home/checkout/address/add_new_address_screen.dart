import 'package:flutter/material.dart';
import 'package:monuite/helpers/models/addresses/address_model.dart';
import 'package:monuite/screens/home/checkout/checkout_screen.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/models/common/dropdown_item.dart';
import '../../../../providers/cart_provider.dart';
import '../../../loading_screen.dart';
import '../../cart/cart_screen.dart';
import 'add_new_address_form.dart';

class AddNewAddressScreen extends StatefulWidget {
  final int _returnToScreen;
  const AddNewAddressScreen(this._returnToScreen, {Key key}) : super(key: key);

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  bool _isLoading = false;

  String _country;
  String _firstName;
  String _lastName;
  String _companyName;
  String _phone;
  String _address1;
  String _address2;
  String _city;
  String _state;
  String _zipCode;
  String _email;

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
            title: Text('An error occured'),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text('Okay'))
            ],
          );
        });
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
      var response = await Provider.of<CartProvider>(
        context,
        listen: false,
      ).addAddress(
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
      if (widget._returnToScreen == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CartScreen()),
        );
      } else if (widget._returnToScreen == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CheckoutScreen()),
        );
      } else {
        Navigator.pop(context, response);
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      const errorMessage = 'Unable to add';
      _showErrorDialogue(context, errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    Widget buildAddButton() {
      return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).primaryColor)),
        onPressed: () => _submit(context),
        child: Text(
          'ADD ADDRESS',
          style: Theme.of(context).primaryTextTheme.labelLarge,
        ),
        // elevation: 0,
        // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Address'),
      ),
      body: _isLoading
          ? LoadingScreen()
          : Container(
              height: deviceSize.height,
              width: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Add Address',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          AddNewAddressForm(
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
                    child: buildAddButton(),
                  ),
                ],
              ),
            ),
    );
  }
}
