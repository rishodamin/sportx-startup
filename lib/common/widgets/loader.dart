import 'package:flutter/material.dart';
import 'package:sportx/constants/global_variables.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: GlobalVariables.secondaryColor,
      ),
    );
  }
}
