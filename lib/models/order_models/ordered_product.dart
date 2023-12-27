import 'package:json_annotation/json_annotation.dart';
import 'package:sportx/models/product_models/product.dart';

part 'ordered_product.g.dart';

@JsonSerializable()
class OrderedProduct {
  final Product product;
  final int quantity;
  final String size;

  OrderedProduct({
    required this.product,
    required this.quantity,
    required this.size,
  });

  factory OrderedProduct.fromJson(Map<String, dynamic> json) =>
      _$OrderedProductFromJson(json);

  Map<String, dynamic> toJson() => _$OrderedProductToJson(this);
}
