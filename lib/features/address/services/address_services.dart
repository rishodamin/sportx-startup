import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportx/constants/error_handling.dart';
import 'package:sportx/constants/global_variables.dart';
import 'package:sportx/constants/utils.dart';
import 'package:http/http.dart' as http;
import 'package:sportx/providers/user_provider.dart';

class AddressServices {
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/save-user-address'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'address': address}),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          userProvider.updateAddress(address);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void placeOrder({
    required BuildContext context,
    required String address,
    required double totalSum,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/order'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonEncode({
            'cart': userProvider.user.cart,
            'address': address,
            'totalPrice': totalSum
          }));

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          userProvider.updateCart([]);
          showSnackBar(context, 'Your order has been placed!');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
