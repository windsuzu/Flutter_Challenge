import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/i18n.dart';
import 'package:flutter_challenge/Functional/EventBusRoute.dart' show EventBus;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  EventBus bus = EventBus();
  SpecifiedLocalizationDelegate _localeOverrideDelegate;
  var locale = Locale("en", "");

  @override
  void initState() {
    super.initState();
    _localeOverrideDelegate = SpecifiedLocalizationDelegate(null);

    bus.on('language', (e) {
      locale =
          locale.languageCode == "en" ? Locale("zh", "TW") : Locale("en", "US");

      onLocaleChange(locale);
    });
  }

  onLocaleChange(Locale l) {
    setState(() {
      _localeOverrideDelegate = SpecifiedLocalizationDelegate(l);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: [
          _localeOverrideDelegate,
          const GeneratedLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        localeListResolutionCallback:
            S.delegate.listResolution(fallback: Locale("en", "")),
        localeResolutionCallback:
            S.delegate.resolution(fallback: Locale("en", "")),
        title: 'Flutter Challenge',
        debugShowCheckedModeBanner: false,
        home:
            Builder(builder: (context) => HomePage(S.of(context).tap_counter)));
  }
}

class SpecifiedLocalizationDelegate extends LocalizationsDelegate<S> {
  final Locale overriddenLocale;

  const SpecifiedLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => overriddenLocale != null;

  @override
  Future<S> load(Locale locale) =>
      GeneratedLocalizationsDelegate().load(overriddenLocale);

  @override
  bool shouldReload(SpecifiedLocalizationDelegate old) => true;
}
