import 'package:flutter/material.dart';

class CustomDialogPopup extends StatelessWidget {
  final String text;
  final Color color;
  final Widget? icon;
  final List<PopupMenuItem> modals;
  const CustomDialogPopup({
    Key? key,
    required this.text,
    required this.modals,
    this.icon,
    this.color = Colors.white,
  }) : super(key: key);

  static PopupMenuItem buildPopupModal(String popupText, void Function() f,
      {Color color = Colors.blue, String? textHeadler}) {
    return PopupMenuItem(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (textHeadler != null)
            Row(
              children: [
                const Spacer(),
                Text(textHeadler),
                const Spacer(),
              ],
            ),
          Text(
            popupText,
            style: TextStyle(color: color),
          ),
        ],
      ),
      onTap: f,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<dynamic>(
        padding: const EdgeInsets.all(0),
        icon: icon ??
            Text(
              text,
              style: TextStyle(color: color),
            ),
        itemBuilder: (BuildContext context) {
          return modals;
        });
  }
}
