import 'package:flutter/material.dart';
import 'package:sportx/constants/global_variables.dart';
import 'package:sportx/models/product_models/product.dart';

class Productcard extends StatelessWidget {
  final Product? product;
  final double? height;
  final Color? color;
  final String imageUrl;
  final bool setBorder;
  const Productcard({
    super.key,
    this.product,
    this.height,
    this.color,
    this.setBorder = false,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: height,
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          border: setBorder ? Border.all() : null,
          color: color ?? GlobalVariables.greyBackgroundCOlor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ));
  }
}
