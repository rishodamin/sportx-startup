import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sportx/models/product_models/cart.dart';
import 'package:sportx/models/user_models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    password: '',
    address: '',
    type: '',
    token: '',
    email: '',
    cart: [],
  );

  User get user => _user;

  void setUser(String user) {
    Map<String, dynamic> userMap = jsonDecode(user);
    _user = User.fromJson(userMap);
    notifyListeners();
  }

  void updateCart(List<Cart> cart) {
    _user.cart = cart;
    notifyListeners();
  }

  void updateAddress(String address) {
    _user.address = address;
    notifyListeners();
  }
}
