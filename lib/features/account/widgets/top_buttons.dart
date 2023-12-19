import 'package:flutter/material.dart';
import 'package:sportx/features/account/screens/my_orders_screen.dart';
import 'package:sportx/features/account/services/account_services.dart';
import 'package:sportx/features/account/widgets/account_button.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({super.key});

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  bool isLoggingOut = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: 'Log Out',
              onTap: () => setState(() {
                isLoggingOut = true;
              }),
            ),
            AccountButton(
                text: 'Your Orders',
                onTap: () => Navigator.pushNamed(
                      context,
                      MyOrders.routeName,
                    )),
          ],
        ),
        if (isLoggingOut)
          Column(
            children: [
              const SizedBox(height: 10),
              const Text(
                'Are you Sure You want to Log out?',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  AccountButton(
                    text: 'No',
                    onTap: () => setState(() {
                      isLoggingOut = false;
                    }),
                  ),
                  AccountButton(
                    text: 'Yes',
                    onTap: () => AccountServices().logout(context),
                  ),
                ],
              ),
            ],
          )
      ],
    );
  }
}
