import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:monuite/helpers/models/user.dart';

import '../helpers/common/constants.dart';
import '../helpers/models/categories/category-list-model.dart';
import '../helpers/models/products/product_detail_model.dart';
import '../helpers/models/products/product_list_model.dart';

class ProductProvider with ChangeNotifier {
  final String? authToken;
  final User? user;

  ProductProvider(this.authToken, this.user);

  List<CategoryListModel> _categories = [];

  List<CategoryListModel> get categories {
    return [..._categories];
  }

  Future<void> populateCategoryList({int take = 0}) async {
    var url = Uri.parse(
        '${Constants.baseUrl}product/get-categories-list?take=${take}');
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
          final List<dynamic>? extractedData =
              json.decode(response.body) as List<dynamic>;
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

  List<ProductListModel> _popularProducts = [];

  List<ProductListModel> get popularProducts {
    return [..._popularProducts];
  }

  Future<void> populatePopularProductList({int take = 0}) async {
    var url = Uri.parse(
        '${Constants.baseUrl}product/get-popular-product-list?take=${take}');
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
          final List<dynamic>? extractedData =
              json.decode(response.body) as List<dynamic>;
          final List<ProductListModel> loadedProducts = [];
          if (extractedData != null) {
            extractedData.forEach((value) {
              ProductListModel prod = ProductListModel.fromJson((value));
              loadedProducts.add(prod);
            });
          }
          _popularProducts = loadedProducts;
          break;
        case HttpStatus.forbidden:
          break;
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  List<ProductListModel> _productsByCategory = [];

  List<ProductListModel> get productsByCategory {
    return [..._productsByCategory];
  }

  Future<void> populateProductByCategoryList(String categoryId,
      {int take = 0}) async {
    var url = Uri.parse(
        '${Constants.baseUrl}product/get-product-by-category-list?categoryId=$categoryId&take=${take}');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      );

      switch (response.statusCode) {
        case HttpStatus.ok:
          final List<dynamic>? extractedData =
              json.decode(response.body) as List<dynamic>;
          final List<ProductListModel> loadedProducts = [];
          if (extractedData != null) {
            extractedData.forEach((value) {
              ProductListModel prod = ProductListModel.fromJson((value));
              loadedProducts.add(prod);
            });
          }
          _productsByCategory = loadedProducts;
          break;
        case HttpStatus.forbidden:
          break;
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  ProductDetailModel? _productDetailModel = null;

  ProductDetailModel? get productDetail {
    return _productDetailModel;
  }

  Future<void> populateProductDetail(String id) async {
    var url =
        Uri.parse('${Constants.baseUrl}product/get-product-detail-model/${id}');
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
          final value = json.decode(response.body) as dynamic;
          _productDetailModel = ProductDetailModel.fromJson((value));
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
