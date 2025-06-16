import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import '../helpers/common/constants.dart';
import '../helpers/models/common/dropdown_item.dart';

class CommonProvider extends ChangeNotifier {
  List<DropdownItem<String>> _countryList = [];

  List<DropdownItem<String>> get countryList {
    return _countryList;
  }

  Future<void> getCountryDropDownList() async {
    var url = Uri.parse('${Constants.baseUrl}common/get-country-dropdown-list');
    try {
      final response = await http.get(
        url,
      );

      switch (response.statusCode) {
        case HttpStatus.ok:
          final List<dynamic>? extractedData =
              json.decode(response.body) as List<dynamic>;
          final List<DropdownItem<String>> loadedProducts = [];
          if (extractedData != null) {
            extractedData.forEach((value) {
              DropdownItem<String> prod =
                  DropdownItem<String>.fromJson((value));
              loadedProducts.add(prod);
            });
            _countryList = loadedProducts;
          }
          notifyListeners();
          break;
        case HttpStatus.forbidden:
          break;
      }
    } catch (error) {
      throw error;
    }
  }
}
