import 'package:farmx/Screens/LandingScreen.dart';
import 'package:farmx/Services/location.dart';
import 'package:farmx/generated/l10n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'Services/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIOverlays(
    [
      SystemUiOverlay.bottom,
      SystemUiOverlay.top,
    ],
  );
  // SystemUiOverlayStyle(statusBarColor: Colors.white)
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: Provider<LocationService>(
        create: (context) => LocationCoordinates(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateTitle: (BuildContext context) => S.of(context).appTitle,
          title: "FarmX",
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            primaryTextTheme: TextTheme(
              headline6: TextStyle(
                color: Colors.white,
                fontFamily: 'Roboto',
                fontSize: 20.0,
              ),
            ),
          ),
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', ''), // English, no country code
            const Locale('te', ''),
            const Locale('hi', '')
          ],
          localeResolutionCallback: (
            Locale? locale,
            Iterable<Locale> supportedLocales,
          ) {
            return locale;
          },
          home: LandingScreen(),
        ),
      ),
    );
  }
}
