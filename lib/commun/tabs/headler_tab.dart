import 'package:flutter/material.dart';

class HeadlerTab extends StatelessWidget {
  const HeadlerTab({Key? key}) : super(key: key);
  // crossAxisAlignment: CrossAxisAlignment.stretch,

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 200,
      width: double.maxFinite,
      child: Image.asset(
        'assets/headler_wallpaper.jpg',
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
