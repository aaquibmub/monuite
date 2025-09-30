import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:monuite/helpers/common/utility.dart';
import 'package:monuite/helpers/models/addresses/address_book_nodel.dart';
import 'package:monuite/helpers/models/cart/cart_item_model.dart';
import 'package:monuite/helpers/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/models/addresses/address_model.dart';
import '../helpers/models/cart/cart_model.dart';

class CartProvider with ChangeNotifier {
  final String? authToken;
  final User? user;

  CartProvider(this.authToken, this.user);

  CartModel? _cartModel = null;

  CartModel? get cartModel {
    return _cartModel;
  }

  Future<void> update(CartModel model) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(model.toJson());
      prefs.setString('cartModel', userData);
      _cartModel = model;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> get() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartModelStr = prefs.getString('cartModel');
      if (cartModelStr == null || cartModelStr.isEmpty) {
        final List<AddressBookModel> addressBook =
            Utility.getAddressBook(prefs);
        final address =
            addressBook.where((element) => element.isDefault).first.address;
        _cartModel = CartModel(address, [], 0, 0);
        return;
      }
      // if (cartModelStr.isEmpty) {
      //   _cartModel = CartModel(user!.shipping, [], 0, 0);
      //   return;
      // }
      _cartModel = CartModel.fromJson(json.decode(cartModelStr));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addItem(CartItemModel item) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartModelStr = prefs.getString('cartModel');
      if (cartModelStr == null || cartModelStr.isEmpty) {
        final List<AddressBookModel> addressBook =
            Utility.getAddressBook(prefs);
        _cartModel = CartModel(
            addressBook.where((element) => element.isDefault).first.address,
            [],
            0,
            0);
      } else {
        _cartModel = CartModel.fromJson(json.decode(cartModelStr));
      }
      var cartItem = _cartModel!.items
          .firstWhereOrNull((element) => element!.id == item.id);
      if (cartItem != null) {
        _cartModel!.items.forEach((element) {
          if (element!.id == item.id && element.variantId == item.variantId) {
            element.quantity = cartItem.quantity + 1;
            item.quantity = element.quantity;
          }
        });
      } else {
        item.quantity = 1;
        _cartModel!.items.add(item);
      }
      _cartModel!.total = 0;
      _cartModel!.items.forEach((element) {
        if (element != null)
          _cartModel!.total =
              (_cartModel!.total ?? 0) + element.price * element.quantity;
      });
      final cartModelJson = _cartModel!.toJson();
      final userData = json.encode(cartModelJson);
      prefs.setString('cartModel', userData);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> decreaseItemQuantity(CartItemModel item) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartModelStr = prefs.getString('cartModel');
      if (cartModelStr == null || cartModelStr.isEmpty) {
        _cartModel = CartModel(null, [], 0, 0);
      }
      var cartItem = _cartModel!.items.firstWhereOrNull((element) =>
          element!.id == item.id && element.variantId == item.variantId);
      if (cartItem != null) {
        if (cartItem.quantity <= 1) {
          _cartModel!.items.removeWhere(
            (element) =>
                element!.id == item.id && element.variantId == item.variantId,
          );
        } else {
          _cartModel!.items.forEach((element) {
            if (element!.id == item.id && element.variantId == item.variantId) {
              element.quantity = cartItem.quantity - 1;
            }
          });
        }
      }
      _cartModel!.total = 0;
      _cartModel!.items.forEach((element) {
        _cartModel!.total =
            (_cartModel!.total ?? 0) + element!.price * element.quantity;
      });
      final cartModelJson = _cartModel!.toJson();
      final userData = json.encode(cartModelJson);
      prefs.setString('cartModel', userData);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> increaseItemQuantity(CartItemModel item) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartModelStr = prefs.getString('cartModel');
      if (cartModelStr == null || cartModelStr.isEmpty) {
        _cartModel = CartModel(null, [], 0, 0);
      }
      var cartItem = _cartModel!.items.firstWhereOrNull((element) =>
          element!.id == item.id && element.variantId == item.variantId);
      if (cartItem != null) {
        _cartModel!.items.forEach((element) {
          if (element!.id == item.id && element.variantId == item.variantId) {
            element.quantity = cartItem.quantity + 1;
          }
        });
      }
      _cartModel!.total = 0;
      _cartModel!.items.forEach((element) {
        _cartModel!.total =
            (_cartModel!.total ?? 0) + element!.price * element.quantity;
      });
      final cartModelJson = _cartModel!.toJson();
      final userData = json.encode(cartModelJson);
      prefs.setString('cartModel', userData);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addAddress(AddressModel address) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartModelStr = prefs.getString('cartModel');
      if (cartModelStr == null || cartModelStr.isEmpty) {
        final List<AddressBookModel> addressBook =
            Utility.getAddressBook(prefs);
        _cartModel = CartModel(
            addressBook.where((element) => element.isDefault).first.address,
            [],
            0,
            0);
      }
      _cartModel!.address = address;
      final cartModelJson = _cartModel!.toJson();
      final userData = json.encode(cartModelJson);
      prefs.setString('cartModel', userData);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> clear() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<AddressBookModel> addressBook = Utility.getAddressBook(prefs);
      final defaultAddress =
          addressBook.where((element) => element.isDefault).first.address;
      _cartModel = CartModel(defaultAddress, [], 0, 0);
      final userData = json.encode(_cartModel!.toJson());
      prefs.setString('cartModel', userData);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
