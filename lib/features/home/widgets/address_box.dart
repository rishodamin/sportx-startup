import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportx/providers/user_provider.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
        alignment: Alignment.centerLeft,
        width: double.infinity,
        height: 40,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 114, 226, 221),
              Color.fromARGB(255, 162, 236, 233),
            ],
            stops: [0.5, 1.0],
          ),
        ),
        padding: const EdgeInsets.only(left: 15),
        child: Text(
          'Welcome ${user.name} !',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ));
  }
}
