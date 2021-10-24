import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType textInputType;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hint,
    this.textInputType = TextInputType.emailAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      controller: controller,
      validator: (name) {
        if (name!.isEmpty || name.length < 4) {
          return 'Muito curto';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hint,
        labelText: hint,
        suffixIcon: const Icon(
          Icons.bookmark_add,
        ),
      ),
    );
  }
}
