import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';
import 'package:topxadrez/commun/utils.dart';
import 'package:topxadrez/commun/widgets/custom_progress_indicator.dart';
import 'package:topxadrez/controllers/calendar_controller.dart';
import 'package:topxadrez/controllers/page_controller.dart';
import 'package:topxadrez/controllers/user_controller.dart';
import 'package:topxadrez/models/date_event.dart';
import 'package:topxadrez/models/user_modal.dart';
import 'package:topxadrez/screen/calendario_screen/widget/compromiss_choice.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:topxadrez/screen/calendario_screen/widget/text_editing.dart';

class MarcarAulaScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  MarcarAulaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: context.watch<CalendarController>().isEventUpdating
          ? [const CusIndicator()]
          : [
              const Text(
                'Escolha o dia e o horario:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 4, 125, 141),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 100,
                child: DatePicker(
                  DateTime.now(),
                  locale: 'pt',
                  initialSelectedDate: null,
                  selectionColor: Colors.black,
                  selectedTextColor: Colors.white,
                  onDateChange: (date) {
                    var dateEvent =
                        Provider.of<CalendarController>(context, listen: false);
                    dateEvent.dateTime = date;
                  },
                ),
              ),
              ...DateEvent.listOfHours
                  .map(
                    (e) => CompromissChoice(
                      e,
                      DateEvent.listOfHours
                          .indexWhere((element) => element == e),
                      context.watch<CalendarController>().isValid(e),
                    ),
                  )
                  .toList(),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    const TextSpan(
                        text: 'Sua próxima aula está marcada para o dia '),
                    if (context.watch<CalendarController>().dateTime != null)
                      TextSpan(
                        text: DateFormat(DateFormat.DAY, 'pt_Br').format(
                            context.watch<CalendarController>().dateTime!),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    if (context.watch<CalendarController>().dateTime == null)
                      const TextSpan(
                        text: '???',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    const TextSpan(text: ' de '),
                    if (context.watch<CalendarController>().dateTime != null)
                      TextSpan(
                        text: DateFormat(DateFormat.MONTH, 'pt_Br').format(
                            context.watch<CalendarController>().dateTime!),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    if (context.watch<CalendarController>().dateTime == null)
                      const TextSpan(
                        text: '???',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    const TextSpan(text: ' das '),
                    if (context.watch<CalendarController>().hour != null)
                      TextSpan(
                        text: DateEvent.listOfHours[
                            context.watch<CalendarController>().hour!],
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    if (context.watch<CalendarController>().hour == null)
                      const TextSpan(
                        text: '???',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    const TextSpan(text: '. '),
                    context.watch<CalendarController>().isOnline
                        ? const TextSpan(
                            text: 'Online',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          )
                        : const TextSpan(
                            text: 'Presencial',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                    const TextSpan(text: '.'),
                  ],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 4, 125, 141),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text(
                    'Qual será a modalidade da aula?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  const Text('PRESENCIAL '),
                  Switch(
                    activeColor: DateEvent.colors[1],
                    inactiveTrackColor: const Color(0xff2074ac).withAlpha(100),
                    inactiveThumbColor: const Color(0xff2074ac),
                    value: context.watch<CalendarController>().isOnline,
                    onChanged: (bool valor) {
                      context.read<CalendarController>().isOnline = valor;
                    },
                  ),
                  const Text('ON-LINE'),
                ],
              ),
              context.watch<CalendarController>().isOnline
                  ? const Text(
                      'Lembrando que a plataforma da aula online será marcada, '
                      'favor chamar o professor em seu número (21) 9 8464-7493 para agendar a aula.',
                    )
                  : const Text(
                      'A aula será presencial no horario marcado, dentro do clube, '
                      'localizado no terceiro andar do Top Shopping.',
                    ),
              const SizedBox(height: 16),
              Form(
                key: _formKey,
                child: SearchField(
                  suggestions: context
                      .watch<UserController>()
                      .listOfUsers
                      .map((e) => e.nome)
                      .toList(),
                  hint: 'Escolha o usuário que terá a aula marcada',
                  searchStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.black.withOpacity(0.8),
                  ),
                  validator: (x) {
                    if (!context
                            .read<UserController>()
                            .listOfUsers
                            .map((e) => e.nome)
                            .toList()
                            .contains(x) ||
                        x!.isEmpty) {
                      return 'Porfavor escolha um usuario válido';
                    }
                    return null;
                  },
                  searchInputDecoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  maxSuggestionsInViewPort: 6,
                  itemHeight: 50,
                  onTap: (x) {
                    UserModel pessoa = context
                        .read<UserController>()
                        .listOfUsers
                        .firstWhere((element) => element.nome == x);
                    context.read<CalendarController>().idOfUser = pessoa.id;
                  },
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: !context.watch<CalendarController>().isOnline
                      ? const Color.fromARGB(255, 4, 125, 141)
                      : DateEvent.colors[1],
                ),
                onPressed: () async {
                  CalendarController con = context.read<CalendarController>();
                  UserModel? user = context.read<UserController>().currentUser;
                  if (user == null) {
                    return;
                  }

                  if (con.hour == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Escolha um horário')));
                    return;
                  }

                  if (con.idOfUser == null && user.isAdmin) {
                    if (!_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Escolha o aluno que terá aula')));
                      return;
                    }
                  }

                  if (con.dateTime == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Escolha um dia')));
                    return;
                  }

                  if (con.isOnline) {
                    con.color = 1;
                  } else {
                    con.color = 0;
                  }
                  if (!user.isAdmin) {
                    con.idOfUser = user.id;
                  }
                  try {
                    if (user.isAdmin) {
                      try {
                        await con.uploadDateEvent(context
                            .read<UserController>()
                            .listOfUsers
                            .firstWhere(
                                (element) => element.id == con.idOfUser));
                        context.read<ScreenController>().currentPage = 2;
                        Utils.zerarTudo(context);
                        Utils.buildErrorMensage(context,
                            text: 'AULA MARCADA COM SUCESSO!',
                            color: Colors.green);
                      } catch (e) {
                        Utils.buildErrorMensage(context, error: e);
                        context.read<ScreenController>().currentPage = 2;
                      }
                      return;
                    } else {
                      try {
                        await con.uploadDateEvent(user);
                        context.read<ScreenController>().currentPage = 2;
                        Utils.zerarTudo(context);
                        Utils.buildErrorMensage(context,
                            text: 'AULA MARCADA COM SUCESSO!',
                            color: Colors.green);
                      } catch (e) {
                        Utils.buildErrorMensage(context, error: e);
                        context.read<ScreenController>().currentPage = 2;
                      }
                      return;
                    }
                  } catch (e) {
                    Utils.buildErrorMensage(context, error: e);
                  }
                },
                child: !context.watch<CalendarController>().isOnline
                    ? const Text('Marcar Aula Presencial')
                    : const Text('Marcar Aula On-line'),
              ),
              const SizedBox(height: 8),
              if (context.watch<UserController>().currentUser != null)
                if (context.watch<UserController>().currentUser!.isAdmin)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: DateEvent.colors[2],
                    ),
                    onPressed: () {
                      CalendarController con =
                          context.read<CalendarController>();
                      if (con.hour == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Escolha um horário')));
                        return;
                      }

                      if (con.dateTime == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Escolha um dia')));
                        return;
                      }

                      showDialog(
                        context: context,
                        builder: (_) => TextEventEditingModal(
                          primaryContext: context,
                          color: 2,
                        ),
                      );
                    },
                    child: const Text('Marcar Evento'),
                  ),
              const SizedBox(height: 8),
              if (context.watch<UserController>().currentUser != null)
                if (context.watch<UserController>().currentUser!.isAdmin)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: DateEvent.colors[3],
                    ),
                    onPressed: () {
                      CalendarController con =
                          context.read<CalendarController>();
                      if (con.hour == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Escolha um horário'),
                          ),
                        );
                        return;
                      }
                      if (con.dateTime == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Escolha um dia')));
                        return;
                      }

                      showDialog(
                        context: context,
                        builder: (_) => TextEventEditingModal(
                          primaryContext: context,
                          color: 3,
                        ),
                      );
                    },
                    child: const Text('Marcar Torneio'),
                  ),
            ],
    );
  }
}
