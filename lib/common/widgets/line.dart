import 'package:flutter/material.dart';

class Line extends StatelessWidget {
  const Line({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 0.5,
      color: Colors.grey[400],
    );
  }
}
