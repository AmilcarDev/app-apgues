import 'package:catcher/catcher_plugin.dart';
import 'package:flutter/material.dart';
import 'package:pgues_app/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

//void main() => runApp(MyApp());

void main() {
  //debug configuration
  String error_title = "Ha courrido un error";
  String error_msg = """
Este mensaje de error puede ser causado por una de las siguientes razones:

 - Los datos del expediente no estan completos.
 - Es imosible contactar con el servidor.

Por favor verifique los datos desde la aplicacion web o intente volver mas tarde.""";
  CatcherOptions debugOptions = CatcherOptions(DialogReportMode(), [
    ConsoleHandler()
  ], localizationOptions: [
    LocalizationOptions("es",
        notificationReportModeTitle: error_title,
        notificationReportModeContent: error_msg,
        dialogReportModeTitle: error_title,
        dialogReportModeDescription: error_msg,
        dialogReportModeAccept: "Aceptar",
        dialogReportModeCancel: "Cancelar",
        pageReportModeTitle: error_title,
        pageReportModeDescription: error_msg,
        pageReportModeAccept: "Aceptar",
        pageReportModeCancel: "Cancelar")
  ]);

  //release configuration
  CatcherOptions releaseOptions = CatcherOptions(DialogReportMode(), [], localizationOptions: [
    LocalizationOptions("es",
        notificationReportModeTitle: error_title,
        notificationReportModeContent: error_msg,
        dialogReportModeTitle: error_title,
        dialogReportModeDescription: error_msg,
        dialogReportModeAccept: "Aceptar",
        dialogReportModeCancel: "Cancelar",
        pageReportModeTitle: error_title,
        pageReportModeDescription: error_msg,
        pageReportModeAccept: "Aceptar",
        pageReportModeCancel: "Cancelar")
  ]);

  //profile configuration
  CatcherOptions profileOptions = CatcherOptions(
    NotificationReportMode(),
    [ConsoleHandler(), ToastHandler()],
    handlerTimeout: 10000,
    customParameters: {"example": "example_parameter"},
  );

  //MyApp is root widget
  Catcher(MyApp(),
      debugConfig: debugOptions,
      releaseConfig: releaseOptions,
      profileConfig: profileOptions);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'APGUES',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      navigatorKey: Catcher.navigatorKey,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('es', 'ES'),
      ],

      //********************************************
//       builder: (BuildContext context, Widget widget) {
//         Catcher.addDefaultErrorWidget(
//             showStacktrace: false,
//             customTitle: "Ha ocurido un error",
//             customDescription: """
// Este mensaje de error puede ser causado por una de las siguientes razones:

//  - Los datos del expediente no estan completos.
//  - Es imosible contactar con el servidor.

// Por favor verifique los datos desde la aplicacion web o intente volver mas tarde.""");
//         return widget;
//       },
      routes: routes,
    );
  }
}
