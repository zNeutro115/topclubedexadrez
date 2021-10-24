import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:topxadrez/controllers/page_controller.dart';
import 'package:topxadrez/controllers/user_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:topxadrez/screen/layout_screen.dart';

import 'commun/utils.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => UserController()),
              ChangeNotifierProvider(create: (_) => Utils()),
              ChangeNotifierProvider(create: (_) => ScreenController()),
            ],
            child: MaterialApp(
              title: 'Top Clube Xadrez',
              theme: ThemeData(
                indicatorColor: const Color.fromARGB(255, 4, 125, 141),
                iconTheme: const IconThemeData(
                  color: Color.fromARGB(255, 4, 125, 141),
                ),
                primarySwatch: Colors.blue,
              ),
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],
              supportedLocales: const [
                Locale('pt', 'BR'),
              ],
              builder: (context, widget) => ResponsiveWrapper.builder(
                BouncingScrollWrapper.builder(context, widget!),
                // ClampingScrollWrapper.builder(context, widget!),
                defaultScale: true,
                maxWidth: 1366,
                minWidth: 800,
                breakpoints: const [
                  ResponsiveBreakpoint.resize(800, name: DESKTOP),
                  ResponsiveBreakpoint.autoScale(1366),
                ],
              ),
              home: const LayoutScreen(),
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
