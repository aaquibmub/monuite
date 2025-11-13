import 'package:flutter/material.dart';
import 'package:monuite/helpers/common/constants.dart';
import 'package:monuite/helpers/models/cart/cart_model.dart';
import 'package:monuite/l10n/app_localizations.dart';
import 'package:monuite/providers/order_provider.dart';
import 'package:monuite/screens/home/payment/credit_debit_card/credit_debit_card_payment_form.dart';
import 'package:monuite/screens/orders/order_confirmed_screen.dart';
import 'package:provider/provider.dart';

import '../../../../providers/cart_provider.dart';
import '../../../loading_screen.dart';

class CreditCardPaymentScreen extends StatefulWidget {
  final CartModel? cartModel;

  const CreditCardPaymentScreen(this.cartModel, {Key? key}) : super(key: key);

  @override
  State<CreditCardPaymentScreen> createState() =>
      _CreditCardPaymentScreenState();
}

class _CreditCardPaymentScreenState extends State<CreditCardPaymentScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  bool _isLoading = false;

  String _number = '';
  String _expYear = '';
  String _expMonth = '';
  String _cvc = '';

  void _setNumber(
    String number,
  ) {
    _number = number;
  }

  void _setExpYear(
    String expYear,
  ) {
    _expYear = expYear;
  }

  void _setExpMonth(
    String expMonth,
  ) {
    _expMonth = expMonth;
  }

  void _setCvc(
    String cvc,
  ) {
    _cvc = cvc;
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
      Provider.of<OrderProvider>(context, listen: false)
          .createOrder(
        widget.cartModel!,
        Constants.paymentMethodCreditCard,
      )
          .then((value) {
        setState(() {
          _isLoading = false;
        });
        if (value.hasError) {
          _showErrorDialogue(context, value.msg ?? '');
        } else {
          Provider.of<CartProvider>(context, listen: false).clear().then((_) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => OrderConfirmedScreen(
                        value.result?.orderId ?? '',
                      )),
            );
          });
        }
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      final errorMessage = AppLocalizations.of(context)!.couldNotAddAddress;
      _showErrorDialogue(context, errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    Widget buildPayButton() {
      return ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all<Color>(Theme.of(context).primaryColor)),
        onPressed: () => _submit(context),
        child: Text(
          AppLocalizations.of(context)!.pay,
          style: Theme.of(context).primaryTextTheme.labelLarge,
        ),
        // elevation: 0,
        // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.creditDebitCardPayment),
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
                          CreditDebitCardPaymentForm(
                            _formKey,
                            _setNumber,
                            _setExpYear,
                            _setExpMonth,
                            _setCvc,
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
                    child: buildPayButton(),
                  ),
                ],
              ),
            ),
    );
  }
}
