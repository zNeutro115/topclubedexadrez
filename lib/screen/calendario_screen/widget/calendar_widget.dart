import 'package:cell_calendar/cell_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:topxadrez/commun/utils.dart';
import 'package:topxadrez/commun/visibility_button.dart';
import 'package:topxadrez/controllers/calendar_controller.dart';
import 'package:topxadrez/controllers/user_controller.dart';
import 'package:topxadrez/models/date_event.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final _sampleEvents = sampleEvents();
    final cellCalendarPageController = CellCalendarPageController();
    return Container(
      decoration: BoxDecoration(
        // borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      height: 600,
      width: 600,
      child: Consumer<CalendarController>(
        builder: (_, calendarController, __) {
          return CellCalendar(
            events: calendarController.eventsOnTheDate
                .map((e) => CalendarEvent(
                      eventName: e.eventColor == 2
                          ? 'EVENTO'
                          : e.eventColor == 3
                              ? 'TORNEIO'
                              : (context.read<UserController>().currentUser ==
                                          null ||
                                      !context
                                          .read<UserController>()
                                          .currentUser!
                                          .isAfiliado)
                                  ? 'AULA'
                                  : e.name,
                      eventDate: e.date,
                      eventBackgroundColor: DateEvent.colors[e.eventColor],
                      eventTextColor: Colors.white,
                    ))
                .toList(),
            daysOfTheWeekBuilder: (dayIndex) {
              final labels = ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sáb"];
              return Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  labels[dayIndex],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            },
            monthYearLabelBuilder: (datetime) {
              final year = datetime!.year.toString();
              final month =
                  DateFormat(DateFormat.MONTH, 'pt_Br').format(datetime);
              // final month = datetime.month.monthName;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    Text(
                      "${month.replaceFirst(month[0], month[0].toUpperCase())}  $year",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () {
                        cellCalendarPageController.animateToDate(
                          DateTime.now(),
                          curve: Curves.linear,
                          duration: const Duration(milliseconds: 300),
                        );
                      },
                    )
                  ],
                ),
              );
            },
            onCellTapped: (date) {
              final month = DateFormat(DateFormat.MONTH, 'pt_Br').format(date);
              debugPrint('$date');
              final _eventsOnTheDate =
                  calendarController.eventsOnTheDate.where((event) {
                final eventDate = event.date;
                return eventDate.year == date.year &&
                    eventDate.month == date.month &&
                    eventDate.day == date.day;
              }).toList();
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: (context.read<UserController>().currentUser == null ||
                          !context
                              .read<UserController>()
                              .currentUser!
                              .isAfiliado)
                      ? const Text('AULA')
                      : Text(DateFormat(DateFormat.MONTH, 'pt_Br')
                              .format(date)
                              .replaceFirst(month[0], month[0].toUpperCase()) +
                          ", dia " +
                          date.day.toString()),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _eventsOnTheDate
                        .map(
                          (event) => Container(
                            width: 400,
                            padding: const EdgeInsets.all(4),
                            margin: const EdgeInsets.only(bottom: 12),
                            color: DateEvent.colors[event.eventColor],
                            child: Row(
                              children: [
                                if (context
                                        .watch<UserController>()
                                        .currentUser ==
                                    null)
                                  VisibilityWidget(
                                    willApear: event.eventColor != 3 &&
                                        event.eventColor != 2,
                                    widget: Text(
                                      ' AULA de ${DateEvent.listOfHours[event.hour]}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                if (context
                                        .watch<UserController>()
                                        .currentUser ==
                                    null)
                                  VisibilityWidget(
                                    willApear: event.eventColor == 3 ||
                                        event.eventColor == 2,
                                    widget: Text(
                                      ' De ${event.compromiss}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                //#######################################
                                if (context
                                        .watch<UserController>()
                                        .currentUser !=
                                    null)
                                  if (!context
                                      .watch<UserController>()
                                      .currentUser!
                                      .isAfiliado)
                                    VisibilityWidget(
                                      willApear: event.eventColor != 3 &&
                                          event.eventColor != 2,
                                      widget: Text(
                                        ' AULA de ${DateEvent.listOfHours[event.hour]}',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                if (context
                                        .watch<UserController>()
                                        .currentUser !=
                                    null)
                                  if (context
                                      .watch<UserController>()
                                      .currentUser!
                                      .isAfiliado)
                                    Text(
                                      ' De ${event.compromiss}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                if (context
                                        .watch<UserController>()
                                        .currentUser !=
                                    null)
                                  if (context
                                      .watch<UserController>()
                                      .currentUser!
                                      .isAdmin)
                                    IconButton(
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                        try {
                                          await context
                                              .read<CalendarController>()
                                              .deleteDateEvent(event);
                                        } catch (e) {
                                          Utils.buildErrorMensage(context,
                                              error: e);
                                        }
                                        Utils.buildErrorMensage(context,
                                            text: 'Deletado com sucesso!');
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              );
            },
            todayMarkColor: const Color.fromARGB(255, 4, 125, 141),
            todayTextColor: Colors.white,
            onPageChanged: (firstDate, lastDate) {
              /// Called when the page was changed
              /// Fetch additional events by using the range between [firstDate] and [lastDate] if you want
            },
          );
        },
      ),
    );
  }
}
