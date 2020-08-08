import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'visao/telas/TelaSplash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sentry/sentry.dart';

final SentryClient sentry = new SentryClient(
    dsn:
        'https://39bd23c015504724901ff2eef3ff1bf4@o428922.ingest.sentry.io/5374778');

main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    runApp(OverlaySupport(
      child: GetMaterialApp(
        home: TelaSplash(),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        theme: ThemeData(fontFamily: 'Segoe'),
        supportedLocales: [
          const Locale('pt', 'BR'),
        ],
        debugShowCheckedModeBanner: false,
      ),
    ));
  } catch (error, stackTrace) {
    await sentry.captureException(
      exception: error,
      stackTrace: stackTrace,
    );
  }
}
