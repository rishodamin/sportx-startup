import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportx/constants/error_handling.dart';
import 'package:sportx/constants/global_variables.dart';
import 'package:sportx/constants/utils.dart';
import 'package:sportx/features/auth/screens/auth_screen.dart';
import 'package:sportx/models/order_models/order.dart';
import 'package:sportx/providers/user_provider.dart';

class AccountServices {
  Future<List<Order>> fetchMyOrders({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> order = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/my-orders'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          var data = jsonDecode(res.body);
          if (data.isNotEmpty) {
            for (int i = 0; i < data.length; i++) {
              order.add(Order.fromJson(data[i]));
            }
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return order;
  }

  void logout(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('x-auth-token', '');
      Navigator.pushNamedAndRemoveUntil(
        context,
        AuthScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
