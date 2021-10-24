import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:topxadrez/commun/visibility_button.dart';
import 'package:topxadrez/commun/widgets/custom_dialog.dart';
import 'package:topxadrez/controllers/favorites_controller.dart';
import 'package:topxadrez/controllers/user_controller.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class EventoDestaqueTile extends StatelessWidget {
  const EventoDestaqueTile({Key? key}) : super(key: key);

  Widget buildDestaqueTile(EventDestaque event, BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Row(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: event.title + '\n',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber[800],
                      ),
                    ),
                    TextSpan(text: event.subtitle),
                  ],
                ),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                      'Data: ${event.date.day}/${event.date.month}/${event.date.year}',
                      style: const TextStyle(color: Colors.black)),
                  const SizedBox(height: 4),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 4, 125, 141)),
                    onPressed: () async {
                      String nomeTorneio = event.title;
                      String link = 'https://api.whatsapp.com/send?'
                          'phone=5521973630631&text=Ol%C3%A1!%20Gostaria%20de%'
                          '20participar%20do%20torneio%20$nomeTorneio.%20Como%20'
                          'funciona%20o%20processo%20de%20inscri%C3%A7%C3%A3o%3F';
                      if (await canLaunch(link)) launch(link);
                    },
                    child: const Text('Fazer Inscrição'),
                  ),
                ],
              ),
              if (context.watch<UserController>().currentUser != null)
                if (context.watch<UserController>().currentUser!.isAdmin)
                  SizedBox(
                    // width: 123,
                    child: CustomDialogPopup(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 32,
                      ),
                      text: 'DELETAR ARTIGO',
                      modals: [
                        CustomDialogPopup.buildPopupModal(
                          'Clique para continuar',
                          () {
                            context
                                .read<EventDestaqueController>()
                                .deleteEvent(event);
                          },
                          textHeadler: 'Tem certeza?',
                        ),
                      ],
                    ),
                  ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const VisibilityWidget(
            nivel: VisibilityWidget.admin,
            text: 'Adicionar Evento Destacado',
            page: 15,
          ),
          ...context
              .watch<EventDestaqueController>()
              .events
              .map((e) => buildDestaqueTile(e, context))
              .toList(),
        ],
      ),
    );
  }
}
