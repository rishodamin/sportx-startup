import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportx/common/widgets/custom_button.dart';
import 'package:sportx/constants/global_variables.dart';
import 'package:sportx/features/address/screens/address_screen.dart';
import 'package:sportx/features/cart/widgets/cart_product.dart';
import 'package:sportx/features/cart/widgets/cart_subtotal.dart';
import 'package:sportx/features/home/widgets/address_box.dart';
import 'package:sportx/features/search/screens/search_screen.dart';
import 'package:sportx/providers/user_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigateToSearchScreen(String query) {
    if (query != '') {
      Navigator.pushNamed(
        context,
        SearchScreen.routeName,
        arguments: query,
      );
    }
  }

  void navigateToAddressScreen(double sum, String imageUrl) {
    Navigator.pushNamed(
      context,
      AddressScreen.routeName,
      arguments: {
        'amount': sum.toString(),
        'imageUrl': imageUrl,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    ///
    ///
    double subtotal = 0;
    for (int i = 0; i < user.cart.length; i++) {
      subtotal += user.cart[i].quantity * user.cart[i].product.finalPrice;
    }

    ///
    ///
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(59),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Container(
            width: 245,
            height: 42,
            margin: const EdgeInsets.only(left: 15),
            child: Material(
              // borderRadius: BorderRadius.circular(7),
              color: Colors.white,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
                side: const BorderSide(color: Colors.grey),
              ),
              child: TextFormField(
                onFieldSubmitted: navigateToSearchScreen,
                style: const TextStyle(fontSize: 17),
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 4),
                  border: InputBorder.none,
                  prefixIcon: InkWell(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.only(left: 6),
                      child: Icon(
                        Icons.search,
                        size: 23,
                      ),
                    ),
                  ),
                  hintText: 'Search Remise.in',
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AddressBox(),
            const CartSubtotal(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: subtotal == 0
                  ? const Text(
                      'Your cart is empty..',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : userProvider.isBusy
                      ? CustomButton(
                          text: 'Updating..',
                          onTap: () {},
                          color:
                              GlobalVariables.remiseBlueColor.withOpacity(0.75),
                        )
                      : CustomButton(
                          text: 'Proceed to Buy (${user.cart.length} items)',
                          onTap: () => navigateToAddressScreen(
                              subtotal, user.cart[0].product.images[0]),
                          color: GlobalVariables.remiseBlueColor,
                        ),
            ),
            const SizedBox(height: 15),
            Container(
              color: Colors.black12.withOpacity(0.08),
              height: 1,
            ),
            const SizedBox(height: 15),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: user.cart.length,
              itemBuilder: (context, index) {
                return CartProduct(index: index);
              },
            )
          ],
        ),
      ),
    );
  }
}
