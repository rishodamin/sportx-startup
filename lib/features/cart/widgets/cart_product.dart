import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportx/features/cart/services/cart_services.dart';
import 'package:sportx/features/product_details/services/product_details_services.dart';
import 'package:sportx/models/product_models/product.dart';
import 'package:sportx/providers/user_provider.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({
    super.key,
    required this.index,
  });

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  final CartServices cartServices = CartServices();

  Future<void> incrementQuantity(Product product) async {
    await productDetailsServices.addToCart(
      context: context,
      product: product,
      showMessage: false,
      size: '',
    );
  }

  Future<void> decrementQuantity(Product product) async {
    await cartServices.removeFromCart(
      context: context,
      product: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final cartItem = userProvider.user.cart[widget.index];
    final Product product = cartItem.product;
    final int quantity = cartItem.quantity;

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.contain,
                height: 115,
                width: 115,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '₹${product.finalPrice}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Elgible for FREE Shipping',
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'In Stock',
                      style: TextStyle(
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black12,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        userProvider.setBusy(true);
                        decrementQuantity(product)
                            .then((_) => userProvider.setBusy(false));
                      },
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.remove,
                          size: 18,
                        ),
                      ),
                    ),
                    Container(
                        color: Colors.white,
                        width: 35,
                        height: 31,
                        alignment: Alignment.center,
                        child: Text(quantity.toString())),
                    InkWell(
                      onTap: () {
                        userProvider.setBusy(true);
                        incrementQuantity(product)
                            .then((_) => userProvider.setBusy(false));
                      },
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.add,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
