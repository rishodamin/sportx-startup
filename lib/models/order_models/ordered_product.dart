import 'package:json_annotation/json_annotation.dart';
import 'package:sportx/models/product_models/product.dart';

part 'ordered_product.g.dart';

@JsonSerializable()
class OrderedProduct {
  final Product product;
  final int quantity;

  OrderedProduct({
    required this.product,
    required this.quantity,
  });

  factory OrderedProduct.fromJson(Map<String, dynamic> json) =>
      _$OrderedProductFromJson(json);

  Map<String, dynamic> toJson() => _$OrderedProductToJson(this);
}
