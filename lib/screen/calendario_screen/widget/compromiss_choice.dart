import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topxadrez/controllers/calendar_controller.dart';

class CompromissChoice extends StatelessWidget {
  final String hour;
  final int index;
  final bool isActive;

  const CompromissChoice(this.hour, this.index, this.isActive, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: !isActive
          ? null
          : () {
              context.read<CalendarController>().hour = index;
            },
      child: Container(
        height: 40,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: !isActive
              ? Colors.red[300]
              : context.watch<CalendarController>().hour == index
                  ? const Color.fromARGB(255, 4, 125, 141)
                  : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isActive ? hour : 'Horário de $hour já foi reservado',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: context.watch<CalendarController>().hour == index
                    ? Colors.white
                    : const Color.fromARGB(255, 4, 125, 141),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
