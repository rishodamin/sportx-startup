import 'package:flutter/material.dart';
import 'package:sportx/common/widgets/random_products.dart';
import 'package:sportx/constants/global_variables.dart';
import 'package:sportx/features/account/widgets/below_app_bar.dart';
import 'package:sportx/features/account/widgets/orders.dart';
import 'package:sportx/features/account/widgets/top_buttons.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Image.asset(
            'assets/images/amazon_in.png',
            width: 120,
            height: 45,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BelowAppBar(),
            const SizedBox(height: 20),
            const TopButtons(),
            const SizedBox(height: 20),
            const Orders(),
            // display random products
            const SizedBox(height: 80),
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                "Deals for you :)",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Builder(
              builder: (BuildContext context) => const RandomProducts(),
            ),
            //////////////////////////
          ],
        ),
      ),
    );
  }
}
