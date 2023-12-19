import 'package:flutter/material.dart';
import 'package:sportx/common/widgets/loader.dart';
import 'package:sportx/common/widgets/product_card.dart';
import 'package:sportx/features/home/services/home_services.dart';
import 'package:sportx/features/product_details/screens/product_details_screen.dart';
import 'package:sportx/models/product_models/product.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({super.key});

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  Product? product;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product = await homeServices.fetchDealOfDay(context: context);
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
    return product == null
        ? const Loader()
        : product!.name.isEmpty
            ? const SizedBox()
            : GestureDetector(
                onTap: () => navigateToProductDetailScreen(product!),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 10, top: 15),
                      child: const Text(
                        'Deal of the day',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Productcard(
                      imageUrl: product!.images[0],
                      height: 235,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15),
                      alignment: Alignment.topLeft,
                      child: Text(
                        '₹${product!.price}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(
                        left: 15,
                        top: 5,
                        right: 40,
                        bottom: 5,
                      ),
                      child: Text(
                        product!.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: product!.images
                            .map((e) => Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Productcard(
                                  imageUrl: e,
                                  height: 100,
                                )))
                            .toList(),
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(top: 15, bottom: 15, left: 15),
                      alignment: Alignment.topLeft,
                      child: Text('View full details',
                          style: TextStyle(
                            color: Colors.cyan[800],
                          )),
                    )
                  ],
                ),
              );
  }
}
