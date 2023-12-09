// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['_id'] as String,
      products: (json['products'] as List<dynamic>)
          .map((e) => OrderedProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      address: json['address'] as String,
      userId: json['userId'] as String,
      orderedAt: json['orderedAt'] as int,
      status: json['status'] as int,
      totalPrice: json['totalPrice'] as int,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'products': instance.products,
      'address': instance.address,
      'userId': instance.userId,
      'orderedAt': instance.orderedAt,
      'status': instance.status,
      'totalPrice': instance.totalPrice,
    };
