// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['_id'] as String,
      name: json['name'] as String,
      password: json['password'] as String,
      address:
          (json['address'] as List<dynamic>).map((e) => e.toString()).toList(),
      type: json['type'] as String,
      token: json['token'] as String,
      email: json['email'] as String,
      cart: (json['cart'] as List<dynamic>)
          .map((e) => Cart.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'type': instance.type,
      'token': instance.token,
      'address': instance.address,
      'cart': instance.cart,
    };
