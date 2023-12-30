import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sportx/models/product_models/cart.dart';
import 'package:sportx/models/user_models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    password: '',
    address: [],
    type: '',
    token: '',
    email: '',
    cart: [],
  );

  bool _isBusy = false;

  bool _hasStarted = false;

  User get user => _user;

  bool get isBusy => _isBusy;

  bool get hasStarted => _hasStarted;

  void setBusy(bool busy) {
    _isBusy = busy;
    notifyListeners();
  }

  void setStartedStatus(bool hasStarted) {
    _hasStarted = hasStarted;
    notifyListeners();
  }

  void setUser(String user) {
    Map<String, dynamic> userMap = jsonDecode(user);
    _user = User.fromJson(userMap);
    notifyListeners();
  }

  void updateCart(List<Cart> cart) {
    _user.cart = cart;
    notifyListeners();
  }

  void updateAddress(List<String> address) {
    _user.address = address;
    notifyListeners();
  }
}
