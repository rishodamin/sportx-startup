import 'package:flutter/material.dart';
import 'package:sportx/constants/global_variables.dart';
import 'package:sportx/features/account/widgets/single_product.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  // temporary list
  List list = [
    'https://uhlmann-fechtsport.com/media/62/2f/37/1605297108/10843.jpg',
    'https://uhlmann-fechtsport.com/media/62/2f/37/1605297108/10843.jpg',
    'https://uhlmann-fechtsport.com/media/62/2f/37/1605297108/10843.jpg',
    'https://uhlmann-fechtsport.com/media/62/2f/37/1605297108/10843.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: const Text(
                'Your Orders',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                'See all',
                style: TextStyle(
                  color: GlobalVariables.selectedNavBarColor,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        // display orders
        Container(
          height: 170,
          padding: const EdgeInsets.only(left: 10, top: 20),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return SingleProduct(image: list[index]);
            },
          ),
        ),
      ],
    );
  }
}
