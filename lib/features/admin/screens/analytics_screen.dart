import 'package:flutter/material.dart';
import 'package:sportx/common/widgets/loader.dart';
import 'package:sportx/features/admin/models/sales.dart';
import 'package:sportx/features/admin/services/admin_services.dart';
import 'package:sportx/features/admin/widgets/category_products.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices _adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await _adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return totalSales == null
        ? const Loader()
        : Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  'Total earnings : ₹$totalSales',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 70),
                CategoryProductsChart(data: earnings!),
              ],
            ),
          );
  }
}
