import 'package:json_annotation/json_annotation.dart';
import 'package:sportx/models/product.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart {
  final Product product;
  final int quantity;

  Cart({
    required this.product,
    required this.quantity,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);
}
