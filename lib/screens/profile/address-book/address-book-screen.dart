import 'package:flutter/material.dart';
import 'package:monuite/helpers/common/constants.dart';
import 'package:monuite/helpers/common/utility.dart';
import 'package:monuite/helpers/models/addresses/address_book_nodel.dart';
import 'package:monuite/helpers/models/addresses/address_model.dart';
import 'package:monuite/l10n/app_localizations.dart';
import 'package:monuite/screens/home/checkout/address/add_new_address_screen.dart';
import 'package:monuite/screens/loading_screen.dart';
import 'package:monuite/screens/profile/address-book/edit_address_book_entry_screen.dart';

class AddressBookScreen extends StatelessWidget {
  const AddressBookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buildItem(String id, AddressModel address,
        {bool isDefault = false}) {
      return Container(
        width: double.infinity,
        height: 140,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Color.fromRGBO(0, 0, 0, 0.2),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        margin: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Default Badge
            if (isDefault)
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 64,
                      padding: EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Constants.primaryColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.defaultLabel,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            Container(
              padding: EdgeInsets.symmetric(
                vertical: isDefault ? 16 : 42,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Address
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: Text(
                            address.city +
                                ', ' +
                                address.state +
                                ', ' +
                                address.country,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // Address 1 + Address 2
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: Text(
                            address.address_1 + ' ' + address.address_2,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Edit Button
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: InkWell(
                      onTap: () {
                        // Navigate to Edit Address Screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditAddressBookEntryScreen(AddressBookModel(
                              id: id,
                              address: address,
                              isDefault: isDefault,
                            )),
                          ),
                        );
                      },
                      child: Icon(Icons.edit),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget buildAddButton() {
      return ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all<Color>(Theme.of(context).primaryColor)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNewAddressScreen(3)),
          );
        },
        child: Text(
          AppLocalizations.of(context)!.addAddressInCapital,
          style: Theme.of(context).primaryTextTheme.labelLarge,
        ),
        // elevation: 0,
        // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.addressBook),
        ),
        body: FutureBuilder<List<AddressBookModel>>(
            future: Utility.getAddressBook(),
            builder: (ctx, data) {
              if (data.connectionState == ConnectionState.waiting) {
                return LoadingScreen();
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Body
                  Expanded(
                    child: data.data != null && data.data!.isNotEmpty
                        ? Column(
                            children: [
                              ...data.data!.map((e) => buildItem(
                                    e.id,
                                    e.address,
                                    isDefault: e.isDefault,
                                  )),
                            ],
                          )
                        : Center(
                            child: Text(
                                AppLocalizations.of(context)!.noAddressFound),
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
              );
            }));
  }
}
