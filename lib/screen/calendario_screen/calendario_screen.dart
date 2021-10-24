import 'package:flutter/material.dart';
import 'package:topxadrez/commun/utils.dart';
import 'package:topxadrez/commun/visibility_button.dart';
import 'package:topxadrez/commun/widgets/custom_progress_indicator.dart';
import 'package:topxadrez/controllers/calendar_controller.dart';
import 'package:topxadrez/controllers/page_controller.dart';
import 'package:topxadrez/controllers/user_controller.dart';
import 'package:topxadrez/models/date_event.dart';
import 'package:topxadrez/screen/calendario_screen/widget/calendar_widget.dart';
import 'package:provider/provider.dart';
import 'package:topxadrez/screen/register_screen/register_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:week_of_year/date_week_extensions.dart';

class CalendarioScreen extends StatelessWidget {
  const CalendarioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: context.watch<CalendarController>().isEventUpdating
              ? [const CusIndicator()]
              : [
                  const Text(
                    'Confira os eventos e agende suas aulas semanais:',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 4, 125, 141),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const CalendarWidget(),
                  const SizedBox(height: 32),
                  VisibilityWidget(
                    nivel: VisibilityWidget.semConta,
                    text: 'Crie ou logue na conta para marcar aulas',
                    onPressed: () async {
                      await context.read<UserController>().logout();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (ctx) => const RegisterScreen()),
                      );
                    },
                  ),
                  VisibilityWidget(
                    nivel: VisibilityWidget.logadoApenas,
                    text: 'Pedir Afiliação para poder marcar aulas',
                    onPressed: () async {
                      if (await canLaunch(
                          'https://api.whatsapp.com/send?phone=5521973630631&text=Ol%C3%A1%2C%20gostaria%20de%20saber%20como%20funcionar%20o%20processo%20para%20me%20tornar%20afiliado%20ao%20TOP%20CLUBE%20DE%20XADREZ.')) {
                        launch(
                            'https://api.whatsapp.com/send?phone=5521973630631&text=Ol%C3%A1%2C%20gostaria%20de%20saber%20como%20funcionar%20o%20processo%20para%20me%20tornar%20afiliado%20ao%20TOP%20CLUBE%20DE%20XADREZ.');
                      }
                    },
                  ),
                  const VisibilityWidget(
                    nivel: VisibilityWidget.logadoApenas,
                    widget: Text(
                      'Após clicar no botão, você será redirecionado pro '
                      'whatapp da equipe TOP CLUBE XADREZ para pedir afiliação.',
                    ),
                  ),
                  const VisibilityWidget(
                    nivel: VisibilityWidget.admin,
                    text: 'Marcar Aula',
                    page: 6,
                  ),
                  VisibilityWidget(
                    nivel: VisibilityWidget.apenasAfiliado,
                    widget: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: !context
                                .watch<CalendarController>()
                                .canMarkEvent(
                                    context.read<UserController>().currentUser)
                            ? Colors.red[400]
                            : const Color.fromARGB(255, 4, 125, 141),
                      ),
                      onPressed: !context
                              .watch<CalendarController>()
                              .canMarkEvent(
                                  context.read<UserController>().currentUser)
                          ? null
                          : () {
                              context.read<ScreenController>().currentPage = 6;
                            },
                      child: Text(
                        !context.watch<CalendarController>().canMarkEvent(
                                context.read<UserController>().currentUser)
                            ? 'Você já marcou aula essa semana...'
                            : 'Marcar Aula',
                      ),
                    ),
                  ),
                  if (!context.watch<CalendarController>().canMarkEvent(
                      context.watch<UserController>().currentUser))
                    VisibilityWidget(
                      nivel: VisibilityWidget.apenasAfiliado,
                      widget: TextButton(
                        onPressed: () async {
                          CalendarController cal =
                              context.read<CalendarController>();
                          var _eventsOfWeek = cal.eventsOnTheDate.where(
                              (element) =>
                                  element.date.weekOfYear ==
                                  DateTime.now().weekOfYear);

                          List<DateEvent> toBeDeleted = [];
                          for (var element in _eventsOfWeek) {
                            if (element.idOfPerson ==
                                context
                                    .read<UserController>()
                                    .currentUser!
                                    .id) {}
                          }
                          for (var element in toBeDeleted) {
                            try {
                              await cal.deleteDateEvent(element);
                            } catch (e) {
                              Utils.buildErrorMensage(context, error: e);
                            }
                          }
                        },
                        child: const Text(
                          'Quer cancelar sua aula? clique aqui',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                ],
        ),
      ),
    );
  }
}
