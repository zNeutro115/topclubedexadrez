import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topxadrez/controllers/page_controller.dart';

class ComprovanteField extends StatelessWidget {
  final TextInputType? keyboardType;
  final String hint;
  final String? initialValue;
  final void Function(String)? onChanged;
  const ComprovanteField({
    Key? key,
    this.keyboardType,
    this.onChanged,
    this.initialValue,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      child: TextFormField(
        enabled: !context.watch<ScreenController>().isLoading,
        keyboardType: keyboardType ?? TextInputType.emailAddress,
        onChanged: onChanged ?? (text) {},
        validator: (name) {
          if (name!.isEmpty || name.length < 4) {
            return 'Muito curto';
          }
          return null;
        },
        initialValue: initialValue ?? '',
        decoration: InputDecoration(
          hintText: hint,
          labelText: hint,
          border: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 4, 125, 141), width: 5.0),
          ),
        ),
      ),
    );
  }
}
