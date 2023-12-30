import 'package:flutter/material.dart';
import 'package:sportx/common/widgets/loader.dart';
import 'package:sportx/common/widgets/product_card.dart';
import 'package:sportx/constants/global_variables.dart';
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
  int? offer;

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product = await homeServices.fetchDealOfDay(context: context);
    offer = (((product!.price - product!.finalPrice) / product!.price) * 100)
        .ceil();
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
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 255,
                          width: 255,
                          padding: const EdgeInsets.all(15),
                          child: Productcard(
                            imageUrl: product!.images[0],
                            height: 235,
                          ),
                        ),
                        const Positioned(
                          top: -5,
                          right: -5,
                          child: Icon(
                            Icons.circle,
                            color: GlobalVariables.remiseBlueColor,
                            size: 80,
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Column(
                            children: [
                              Text(
                                ' $offer%',
                                style: const TextStyle(
                                  color: GlobalVariables.halfWhiteColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Text(
                                'off',
                                style: TextStyle(
                                  color: GlobalVariables.halfWhiteColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                      child: Row(
                        children: [
                          const Text(
                            'Remise Deal Price: ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '₹${product!.finalPrice}',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '₹${product!.price}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
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
                      child: const Text('View full details',
                          style: TextStyle(
                            color: GlobalVariables.selectedNavBarColor,
                          )),
                    )
                  ],
                ),
              );
  }
}
