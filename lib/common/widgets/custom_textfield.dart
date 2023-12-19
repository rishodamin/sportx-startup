import 'package:flutter/material.dart';
import 'package:sportx/constants/global_variables.dart';

class CustomText extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final TextInputType type;
  final TextInputAction action;
  const CustomText(
      {super.key,
      required this.controller,
      required this.hintText,
      this.maxLines = 1,
      this.type = TextInputType.text,
      this.action = TextInputAction.done});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: action,
      keyboardType: type,
      maxLines: maxLines,
      cursorColor: Colors.black,
      controller: controller,
      decoration: InputDecoration(
        // floatingLabelStyle: TextStyle(),
        hintText: hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: GlobalVariables.secondaryColor),
        ),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
    );
  }
}
