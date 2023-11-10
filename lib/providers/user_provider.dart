import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sportx/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    password: '',
    address: '',
    type: '',
    token: '',
    email: '',
  );

  User get user => _user;

  void setUser(String user) {
    Map<String, dynamic> userMap = jsonDecode(user);
    _user = User.fromJson(userMap);
  }
}
