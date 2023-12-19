import 'package:flutter/material.dart';
import 'package:sportx/common/services/common_services.dart';
import 'package:sportx/common/widgets/loader.dart';
import 'package:sportx/common/widgets/product_card.dart';
import 'package:sportx/constants/global_variables.dart';
import 'package:sportx/features/product_details/screens/product_details_screen.dart';
import 'package:sportx/features/search/widget/searched_product.dart';
import 'package:sportx/models/product_models/product.dart';

class RandomProducts extends StatefulWidget {
  const RandomProducts({super.key});

  @override
  State<RandomProducts> createState() => _RandomProductsState();
}

class _RandomProductsState extends State<RandomProducts> {
  List<Product>? products;
  final CommonServices _commonServices = CommonServices();

  @override
  void initState() {
    super.initState();
    fetchSearchedProduct();
  }

  fetchSearchedProduct() async {
    products = await _commonServices.fetchSearchedPoducts(
      context: context,
    );
    setState(() {});
  }

  void navigateToProductDetailScreen(Product product) {
    Navigator.pushNamed(
      context,
      ProductDetailScreen.routeName,
      arguments: {
        'product': product,
        'searchQuery': '',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1,
              crossAxisCount: 2,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 20, //products!.length, // Added duplicate REMOVE LATER
            itemBuilder: (context, index) {
              return InkWell(
                splashColor: GlobalVariables.lightGray,
                onTap: () => navigateToProductDetailScreen(
                    products![index % products!.length]),
                child: Productcard(
                  product: products![index % products!.length],
                  imageUrl: products![index % products!.length].images[0],
                ),
              );
            },
          );
  }
}
