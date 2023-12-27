import 'package:json_annotation/json_annotation.dart';
import 'package:sportx/models/product_models/product.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart {
  final Product product;
  final int quantity;
  final String size;

  Cart({
    required this.product,
    required this.quantity,
    required this.size,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);
}
