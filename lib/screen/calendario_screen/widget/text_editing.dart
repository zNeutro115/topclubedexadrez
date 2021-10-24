import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topxadrez/commun/utils.dart';
import 'package:topxadrez/controllers/calendar_controller.dart';
import 'package:topxadrez/controllers/user_controller.dart';
import 'package:topxadrez/models/date_event.dart';

class TextEventEditingModal extends StatelessWidget {
  final BuildContext primaryContext;
  final String initialText;
  final int color;

  const TextEventEditingModal({
    required this.primaryContext,
    required this.color,
    this.initialText = '',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final admin = color == 1 || color == 0;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        width: 750,
        decoration: BoxDecoration(
          color: Colors.white,
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
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                admin
                    ? 'Qual o nome do aluno?'
                    : color == 2
                        ? 'Escreva o nome do Evento'
                        : 'Escreva o nome do Torneio',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 4, 125, 141),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                ),
                child: Material(
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      initialValue: initialText,
                      validator: (String? value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return 'Digite algo...';
                          }
                          if (value.length < 5) {
                            return 'Precisa ter, ao menos, 5 caracteres...';
                          }
                        }
                        return null;
                      },
                      onSaved: (textBloc) {
                        try {
                          primaryContext.read<CalendarController>().compromiss =
                              '${DateEvent.listOfHours[primaryContext.read<CalendarController>().hour!]} -  ${textBloc!}';
                          primaryContext.read<CalendarController>().color =
                              color;
                          primaryContext
                              .read<CalendarController>()
                              .uploadDateEvent(
                                  context.read<UserController>().currentUser!);
                          Navigator.of(context).pop();
                          Utils.buildErrorMensage(context,
                              text: 'MARCADO COM SUCESSO!',
                              color: Colors.green);
                        } catch (e) {
                          Utils.buildErrorMensage(context, error: e);
                          Navigator.of(context).pop();
                        }
                      },
                      maxLines: null,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 4, 125, 141),
                        ),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 4, 125, 141),
                              width: 4),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 4, 125, 141),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  _formKey.currentState?.save();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: DateEvent.colors[color],
                ),
                child: color == 2
                    ? const Text('Adicionar Evento')
                    : const Text('Adicionar Torneio'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
