import 'package:flutter/material.dart';
import 'package:sportx/common/widgets/loader.dart';
import 'package:sportx/features/account/widgets/single_product.dart';
import 'package:sportx/features/admin/services/admin_services.dart';
import 'package:sportx/features/order_details/screens/order_details.dart';
import 'package:sportx/models/order_models/order.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final AdminServices _adminServices = AdminServices();
  List<Order>? orders;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await _adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : GridView.builder(
            itemCount: orders!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              final orderData = orders![index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    OrderDetailScreen.routeName,
                    arguments: {
                      'product': orderData.products,
                      'address': orderData.address,
                      'userId': orderData.userId,
                      'orderedAt': orderData.orderedAt,
                      'status': orderData.status,
                      'orderId': orderData.id,
                      'totalAmount': orderData.totalPrice,
                    },
                  ).then((_) {
                    setState(() {
                      orders = null;
                    });
                    fetchOrders();
                  });
                },
                child: SizedBox(
                  height: 140,
                  child: SingleProduct(
                      image: orderData.products[0].product.images[0]),
                ),
              );
            },
          );
  }
}
