import 'package:flutter/material.dart';
import 'package:topxadrez/commun/tabs/ending_page_tab.dart';
import 'package:topxadrez/commun/tabs/headler_tab.dart';
import 'package:topxadrez/commun/tabs/screen_view_tab.dart';
import 'package:provider/provider.dart';
import 'package:topxadrez/controllers/artigo_controller.dart';
import 'package:topxadrez/controllers/board_controller.dart';
import 'package:topxadrez/controllers/calendar_controller.dart';
import 'package:topxadrez/controllers/favorites_controller.dart';
import 'package:topxadrez/controllers/loja_controller.dart';
import 'package:topxadrez/controllers/page_controller.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ArtigoController()),
        ChangeNotifierProvider(create: (_) => BoardController()),
        ChangeNotifierProvider(create: (_) => CalendarController()),
        ChangeNotifierProvider(create: (_) => LojaController()),
        ChangeNotifierProvider(create: (_) => EventDestaqueController()),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xff005560),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/fundo.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Container(
              width: 800,
              color: Colors.white,
              child: Consumer<ScreenController>(
                builder: (_, screenController, __) {
                  return ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      const HeadlerTab(),
                      const ScreenTabView(),
                      // Container(
                      //   color: Colors.red[400],
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       const Icon(
                      //         Icons.warning_rounded,
                      //         color: Colors.white,
                      //       ),
                      //       const SizedBox(width: 8),
                      //       const Text(
                      //         'Sua mensalidade acaba 24/08/2022!'
                      //         '  Renove para continuar sendo associado.',
                      //         style: TextStyle(
                      //             color: Colors.white,
                      //             fontWeight: FontWeight.bold),
                      //       ),
                      //       if (context.watch<UserController>().currentUser !=
                      //           null)
                      //         Text(context
                      //             .watch<UserController>()
                      //             .currentUser!
                      //             .nome),
                      //     ],
                      //   ),
                      // ),
                      Padding(
                        padding: screenController.currentPage == 4
                            ? const EdgeInsets.only(bottom: 32)
                            : const EdgeInsets.only(
                                left: 32, right: 32, top: 16, bottom: 16),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height * 0.8,
                          ),
                          child: screenController
                              .listView[screenController.currentPage],
                        ),
                      ),
                      const EndingPageTab(),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
