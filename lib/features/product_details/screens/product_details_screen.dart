import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:sportx/common/widgets/custom_button.dart';
import 'package:sportx/common/widgets/product_card.dart';
import 'package:sportx/common/widgets/stars.dart';
import 'package:sportx/constants/global_variables.dart';
import 'package:sportx/constants/utils.dart';
import 'package:sportx/features/product_details/services/product_details_services.dart';
import 'package:sportx/features/search/screens/search_screen.dart';
import 'package:sportx/models/product_models/product.dart';
import 'package:sportx/providers/user_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  static const String routeName = '/product-details';
  final Product product;
  final String searchQuery;
  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.searchQuery,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  double avgRating = 0;
  double myRating = 0;
  int? selectedSizeIndex;

  void navigateToSearchScreen(String query) {
    if (query != '') {
      Navigator.pushNamed(
        context,
        SearchScreen.routeName,
        arguments: query,
      );
    }
  }

  void updateRatings({double? rating}) {
    print(widget.product.rating);
    if (widget.product.rating != null) {
      double totalRatings = 0;
      for (int i = 0; i < widget.product.rating!.length; i++) {
        totalRatings += widget.product.rating![i].rating;
        if (widget.product.rating![i].userId ==
            Provider.of<UserProvider>(context, listen: false).user.id) {
          if (rating == null) {
            myRating = widget.product.rating![i].rating;
          } else {
            totalRatings -= widget.product.rating![i].rating - rating;
            widget.product.rating![i].rating = rating;
          }
        }
      }
      if (totalRatings > 0) {
        avgRating = totalRatings / widget.product.rating!.length;
      } else {
        avgRating = 5;
      }
    } else {
      avgRating = 5;
    }
  }

  void addToCart() {
    if (widget.product.size.isNotEmpty && selectedSizeIndex == null) {
      showSnackBar(context, 'Please select a size');
      return;
    }
    Provider.of<UserProvider>(context, listen: false).setBusy(true);
    productDetailsServices
        .addToCart(
          context: context,
          product: widget.product,
          size: widget.product.size.isEmpty
              ? ''
              : widget.product.size[selectedSizeIndex!],
        )
        .then((value) =>
            Provider.of<UserProvider>(context, listen: false).setBusy(false));
  }

  @override
  void initState() {
    super.initState();
    updateRatings();
  }

  @override
  Widget build(BuildContext context) {
    final int offer = (((widget.product.price - widget.product.finalPrice) /
                widget.product.price) *
            100)
        .ceil();
    print(widget.product.size);
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
            width: 230,
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
                initialValue: widget.searchQuery,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product.id!,
                  ),
                  Stars(rating: avgRating),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Row(
                children: [
                  SizedBox(
                    width: 250,
                    child: Text(
                      // 'This is container containing a very very long text..',
                      widget.product.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(
                        Icons.circle,
                        color: GlobalVariables.remiseBlueColor,
                        size: 80,
                      ),
                      Column(
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
                    ],
                  ),
                ],
              ),
            ),
            CarouselSlider(
              items: widget.product.images.map((i) {
                return Builder(
                    builder: (BuildContext context) => Productcard(
                          imageUrl: i,
                          height: 200,
                        ));
              }).toList(),
              options: CarouselOptions(viewportFraction: 1, height: 300),
            ),
            Center(
              child: Text(
                ' · ' * widget.product.images.length,
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.grey.withOpacity(0.75),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Container(
              color: Colors.black12,
              height: 5,
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
                    '₹${widget.product.finalPrice}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '₹${widget.product.price}',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'You are saving ₹${widget.product.price - widget.product.finalPrice} on this order',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.green,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.product.description),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                text: 'Buy Now',
                onTap: () {},
                color: const Color.fromARGB(255, 104, 233, 61),
              ),
            ),
            const SizedBox(height: 10),
            Provider.of<UserProvider>(context).isBusy
                ? Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomButton(
                      color: GlobalVariables.remiseBlueColor.withOpacity(0.5),
                      text: 'Addding to Cart..',
                      onTap: () {},
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomButton(
                      color: GlobalVariables.remiseBlueColor,
                      text: 'Add to Cart',
                      onTap: addToCart,
                    ),
                  ),
            const SizedBox(height: 10),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            const SizedBox(height: 10),
            if (widget.product.size.isNotEmpty)
              Column(
                children: [
                  const Text(
                    '  Choose a Size',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.product.size.length,
                      itemBuilder: (context, index) {
                        final size = widget.product.size[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedSizeIndex = index;
                              });
                            },
                            child: Chip(
                              label: Text(size),
                              backgroundColor: (selectedSizeIndex != null &&
                                      selectedSizeIndex == index)
                                  ? Theme.of(context).colorScheme.primary
                                  : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Rate The Product',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            RatingBar.builder(
                initialRating: myRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: GlobalVariables.remiseBlueColor,
                    ),
                onRatingUpdate: (rating) {
                  productDetailsServices.rateProduct(
                    context: context,
                    product: widget.product,
                    rating: rating,
                  );
                  updateRatings(rating: rating);
                  setState(() {});
                }),
          ],
        ),
      ),
    );
  }
}
