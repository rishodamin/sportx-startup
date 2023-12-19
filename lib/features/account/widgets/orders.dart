import 'package:flutter/material.dart';
import 'package:sportx/common/widgets/loader.dart';
import 'package:sportx/constants/global_variables.dart';
import 'package:sportx/features/account/screens/my_orders_screen.dart';
import 'package:sportx/features/account/services/account_services.dart';
import 'package:sportx/features/account/widgets/single_product.dart';
import 'package:sportx/features/order_details/screens/order_details.dart';
import 'package:sportx/models/order_models/order.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final AccountServices _accountServices = AccountServices();
  List<Order>? order;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    order = await _accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return order == null
        ? const Loader()
        : order!.isEmpty
            ? Container()
            : Column(
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
                        child: GestureDetector(
                          onTap: () => Navigator.pushNamed(
                            context,
                            MyOrders.routeName,
                          ),
                          child: Text(
                            'See all',
                            style: TextStyle(
                              color: GlobalVariables.selectedNavBarColor,
                              fontSize: 16,
                            ),
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
                      itemCount: order!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              OrderDetailScreen.routeName,
                              arguments: {
                                'product': order![index].products,
                                'address': order![index].address,
                                'userId': order![index].userId,
                                'orderedAt': order![index].orderedAt,
                                'status': order![index].status,
                                'orderId': order![index].id,
                                'totalAmount': order![index].totalPrice,
                              },
                            );
                          },
                          child: SingleProduct(
                            image: order![index].products[0].product.images[0],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
  }
}
