import 'package:flutter/material.dart';

class BuildInfoWidget extends StatelessWidget {
  final String headlerText;
  final String infoText;
  final double width;
  const BuildInfoWidget(
    this.headlerText,
    this.infoText, {
    Key? key,
    this.width = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(
              headlerText,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4)
          ],
        ),
        SizedBox(width: width),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 2.0, color: Colors.black),
              ),
              color: Colors.white,
            ),
            child: Text(
              infoText,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
