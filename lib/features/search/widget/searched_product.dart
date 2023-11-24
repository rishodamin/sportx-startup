import 'package:flutter/material.dart';
import 'package:sportx/common/widgets/stars.dart';
import 'package:sportx/models/product.dart';

class SearchedProduct extends StatelessWidget {
  final Product product;
  const SearchedProduct({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    double avgRating;
    if (product.rating != null) {
      double totalRatings = 0;
      for (int i = 0; i < product.rating!.length; i++) {
        totalRatings += product.rating![i].rating;
      }
      if (totalRatings > 0) {
        avgRating = totalRatings / product.rating!.length;
      } else {
        avgRating = 5;
      }
    } else {
      avgRating = 5;
    }
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.contain,
                height: 135,
                width: 135,
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
                    Stars(rating: avgRating),
                    const SizedBox(height: 5),
                    Text(
                      '\$${product.price}',
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
      ],
    );
  }
}
