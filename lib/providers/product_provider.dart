import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:monuite/helpers/models/user.dart';

import '../helpers/common/constants.dart';
import '../helpers/models/categories/category-list-model.dart';

class ProductProvider with ChangeNotifier {
  final String authToken;
  final User user;

  ProductProvider(this.authToken, this.user);

  List<CategoryListModel> _categories = [];

  List<CategoryListModel> get categories {
    return [..._categories];
  }

  Future<void> populateCategoryList() async {
    var url = '${Constants.baseUrl}product/get-categories-list';
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $authToken',
          // 'Content-Type': 'application/json'
        },
      );

      switch (response.statusCode) {
        case HttpStatus.ok:
          final extractedData = json.decode(response.body) as List<dynamic>;
          final List<CategoryListModel> loadedProducts = [];
          if (extractedData != null) {
            extractedData.forEach((value) {
              CategoryListModel prod = CategoryListModel.fromJson((value));
              loadedProducts.add(prod);
            });
          }
          _categories = loadedProducts;
          break;
        case HttpStatus.forbidden:
          break;
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
