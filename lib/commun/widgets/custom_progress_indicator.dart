import 'package:flutter/material.dart';

class CusIndicator extends StatelessWidget {
  final double size;
  const CusIndicator({Key? key, this.size = 50}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: const CircularProgressIndicator(
        color: Color.fromARGB(255, 4, 125, 141),
      ),
    );
  }
}
