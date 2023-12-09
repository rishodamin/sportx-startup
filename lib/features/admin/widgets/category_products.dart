import 'package:flutter/material.dart';
import 'package:sportx/constants/global_variables.dart';
import 'package:sportx/features/admin/models/sales.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CategoryProductsChart extends StatelessWidget {
  final List<Sales> data;
  const CategoryProductsChart({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      tooltipBehavior: TooltipBehavior(enable: true),
      primaryXAxis: CategoryAxis(),
      series: <ChartSeries<Sales, String>>[
        BarSeries<Sales, String>(
          dataSource: data,
          xValueMapper: (Sales data, _) => data.label,
          yValueMapper: (Sales data, _) => data.earnings,
          name: 'Earnings',
          color: GlobalVariables.secondaryColor,
        ),
      ],
    );
  }
}
