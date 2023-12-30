import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sportx/common/widgets/product_card.dart';
import 'package:sportx/constants/global_variables.dart';
import 'package:sportx/features/address/services/address_services.dart';

class PaymentScreen extends StatefulWidget {
  static const String routeName = '/payment';
  final String imageUrl;
  final String amount;
  final String address;
  const PaymentScreen({
    super.key,
    required this.imageUrl,
    required this.amount,
    required this.address,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final AddressServices _addressServices = AddressServices();

  Future<void> placeOrder() async {
    await _addressServices.placeOrder(
      context: context,
      address: widget.address,
      totalSum: double.parse(widget.amount),
    );
  }

  @override
  Widget build(BuildContext context) {
    final DateTime time = DateTime.now().add(const Duration(days: 3));
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(59),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: const Text(
            'Payment',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Stack(
                  children: [
                    Productcard(
                      imageUrl: widget.imageUrl,
                      height: 80,
                      setBorder: true,
                    ),
                    Positioned(
                      top: -3,
                      left: -3,
                      child: Productcard(
                        imageUrl: widget.imageUrl,
                        height: 80,
                        setBorder: true,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total amount: ₹${widget.amount}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Text(
                      'Deliver address:',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(widget.address),
                    ),
                    Row(
                      children: [
                        const Text(
                          'Expected delivery: ',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(DateFormat.yMMMd().format(time)),
                      ],
                    ),
                  ],
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              color: GlobalVariables.greyBackgroundCOlor,
              height: 2.5,
            ),
          ],
        ),
      ),
    );
  }
}
