import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sportx/constants/error_handling.dart';
import 'package:sportx/constants/global_variables.dart';
import 'package:sportx/constants/utils.dart';
import 'package:sportx/models/product_models/cart.dart';
import 'package:sportx/models/product_models/product.dart';
import 'package:sportx/providers/user_provider.dart';

class CartServices {
  void removeFromCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/remove-from-cart/${product.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'x-auth-token': userProvider.user.token,
        },
      );
      //  print(res.body);
      //   return;
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          List<Cart> cart = (jsonDecode(res.body)['cart'] as List<dynamic>)
              .map((e) => Cart.fromJson(e as Map<String, dynamic>))
              .toList();
          userProvider.updateCart(cart);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
