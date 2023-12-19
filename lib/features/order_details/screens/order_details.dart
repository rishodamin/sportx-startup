import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sportx/common/widgets/custom_button.dart';
import 'package:sportx/constants/global_variables.dart';
import 'package:sportx/features/admin/services/admin_services.dart';
import 'package:sportx/features/search/screens/search_screen.dart';
import 'package:sportx/models/order_models/ordered_product.dart';
import 'package:sportx/providers/user_provider.dart';

class OrderDetailScreen extends StatefulWidget {
  static const String routeName = '/order-details';
  final List<OrderedProduct> product;
  final String address;
  final String userId;
  final int orderedAt;
  final int status;
  final String orderId;
  final int totalAmount;
  const OrderDetailScreen({
    super.key,
    required this.product,
    required this.address,
    required this.userId,
    required this.orderedAt,
    required this.status,
    required this.orderId,
    required this.totalAmount,
  });

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final AdminServices _adminServices = AdminServices();
  int? currentStep;

  @override
  void initState() {
    super.initState();
    currentStep = widget.status;
  }

  void navigateToSearchScreen(String query) {
    if (query != '') {
      Navigator.pushNamed(
        context,
        SearchScreen.routeName,
        arguments: query,
      );
    }
  }

  //  !! ONLY FOR ADMIN !!
  void changeOrderStatus() {
    _adminServices.changeOrderStatus(
      context: context,
      orderId: widget.orderId,
      status: currentStep! + 1,
      onSuccess: () {
        setState(() {
          currentStep = currentStep! + 1;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(59),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: Container(
              width: 230,
              height: 42,
              margin: const EdgeInsets.only(left: 15),
              child: Material(
                // borderRadius: BorderRadius.circular(7),
                color: Colors.white,
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                  side: const BorderSide(color: Colors.grey),
                ),
                child: TextFormField(
                  onFieldSubmitted: navigateToSearchScreen,
                  style: const TextStyle(fontSize: 17),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 4),
                    border: InputBorder.none,
                    prefixIcon: InkWell(
                      onTap: () {},
                      child: const Padding(
                        padding: EdgeInsets.only(left: 6),
                        child: Icon(
                          Icons.search,
                          size: 23,
                        ),
                      ),
                    ),
                    hintText: 'Search Amazon.in',
                  ),
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Vier order details',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Date:        ${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(widget.orderedAt))}',
                      ),
                      Text(
                        'Order ID:            ${widget.orderId}',
                      ),
                      Text('Order Total:       ₹${widget.totalAmount}')
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Purchase Details',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for (int i = 0; i < widget.product.length; i++)
                        Row(
                          children: [
                            Image.network(
                              widget.product[i].product.images[0],
                              width: 120,
                              height: 120,
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.product[i].product.name,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text('Qty: ${widget.product[i].quantity}'),
                              ],
                            ))
                          ],
                        )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Tracking',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                      ),
                    ),
                    child: Stepper(
                      currentStep: currentStep!,
                      controlsBuilder: (context, details) {
                        if (user.type == 'admin' && details.currentStep < 3) {
                          return CustomButton(
                            text: 'Done',
                            onTap: changeOrderStatus,
                          );
                        }
                        return const SizedBox();
                      },
                      steps: [
                        Step(
                          title: const Text(
                            'Pending',
                          ),
                          content: const Text(
                            'Your order is yet to be deliverd',
                          ),
                          isActive: currentStep! >= 0,
                          state: currentStep! >= 0
                              ? StepState.complete
                              : StepState.indexed,
                        ),
                        Step(
                          title: const Text(
                            'Completed',
                          ),
                          content: const Text(
                            'Your order has been delivered, you are yet to sign',
                          ),
                          isActive: currentStep! >= 1,
                          state: currentStep! >= 1
                              ? StepState.complete
                              : StepState.indexed,
                        ),
                        Step(
                          title: const Text(
                            'Received',
                          ),
                          content: const Text(
                            'Your order has been delivered and signed by you.',
                          ),
                          isActive: currentStep! >= 2,
                          state: currentStep! >= 2
                              ? StepState.complete
                              : StepState.indexed,
                        ),
                        Step(
                          title: const Text(
                            'Delivered',
                          ),
                          content: const Text(
                            'Your order has been delivered and signed by you.',
                          ),
                          isActive: currentStep! >= 3,
                          state: currentStep! >= 3
                              ? StepState.complete
                              : StepState.indexed,
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}
