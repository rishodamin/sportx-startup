import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportx/providers/user_provider.dart';

class CartSubtotal extends StatelessWidget {
  const CartSubtotal({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    ///
    ///
    double subtotal = 0;
    for (int i = 0; i < user.cart.length; i++) {
      subtotal += user.cart[i].quantity * user.cart[i].product.finalPrice;
    }

    ///
    ///
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Text(
            'Subtotal ',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Text(
            '₹$subtotal',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
