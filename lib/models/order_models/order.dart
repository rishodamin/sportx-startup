import 'package:json_annotation/json_annotation.dart';
import 'package:sportx/models/order_models/ordered_product.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  final String id;
  final List<OrderedProduct> products;
  final String address;
  final String userId;
  final int orderedAt;
  final int status;
  final int totalPrice;

  Order(
      {required this.id,
      required this.products,
      required this.address,
      required this.userId,
      required this.orderedAt,
      required this.status,
      required this.totalPrice});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
