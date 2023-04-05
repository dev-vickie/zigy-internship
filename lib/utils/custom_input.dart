import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?) validator;
  const CustomInput({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
      return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      hintText: hintText,
    ),
    validator: validator,
  );
  }
}


