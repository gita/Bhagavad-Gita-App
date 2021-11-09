// ignore_for_file: deprecated_member_use

import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/static_model.dart';
import 'package:bhagavad_gita/Constant/string_constant.dart';
import 'package:bhagavad_gita/localization/demo_localization.dart';
import 'package:bhagavad_gita/locator.dart';
import 'package:bhagavad_gita/routes/app_router.dart';
import 'package:bhagavad_gita/routes/route_names.dart';
import 'package:bhagavad_gita/services/navigator_service.dart';
import 'package:bhagavad_gita/services/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/* CHECK FOR NETWORK ISSUES AND DISPLAY SOME CONFIRMATION OF IT */
Future<bool> network_check() async {

    var connectivityResult = await (Connectivity().checkConnectivity());

    /* CHECK FOR NETWORK THROUGH MOBILE DATA CONNECTION */
    if (connectivityResult == ConnectivityResult.mobile) {

        if (await DataConnectionChecker().hasConnection) {
            /* MOBILE DATA / CONNECTION CONFIRMED */
            return true;
        } 
        else {
            /* CAN DISPLAY A TOAST ABOUT NO NETWORK CONNECTION */ 
            return false;
        }

    } 
    /* IF WIFI CONNECTION IS THERE ,THEN CHECK NETWORK CONNECTIVITY*/ 
    else if (connectivityResult == ConnectivityResult.wifi) {

        if (await DataConnectionChecker().hasConnection) {
            /* INTERNET CONNECTION CONFIRMED */
            return true;
        } 
        else {
            /* NO INTERNET CONNNECTION ALTHOUGH CONNECTED TO WIFI */
            return false;
        }
    }
    /* NIETHER MOBILE DATA NOR WIFI CONNECTION */
    else {
        return false;
    }

}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupServiceLocator();
  langauge = (await SharedPref.getLanguage())!.replaceAll("\"", "");
  ///bool onBoardSkip = await SharedPref.checkOnBoardScreenIsSkip();
  savedVerseTranslation = await SharedPref.getSavedVerseTranslationSetting();
  savedVerseCommentary = await SharedPref.getSavedVerseCommentarySetting();
  //savedLastReadVerse = await SharedPref.getLastRead();
  print("Selected lang : $langauge");
  runApp(MyApp(
    
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void setLocales(BuildContext context, Locale locale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(locale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = SharedPref().getLocal();

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bhagvad Gita',
      debugShowCheckedModeBanner: false,
      locale: _locale,
      supportedLocales: [
        Locale('en', 'US'),
        Locale('hi', 'IN'),
      ],
      localizationsDelegates: [
        DemoLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        for (var locale in supportedLocales) {
          if (locale.languageCode == deviceLocale?.languageCode &&
              locale.countryCode == deviceLocale?.countryCode) {
            return deviceLocale;
          }
        }
        return supportedLocales.first;
      },
      theme: ThemeData(
          accentColor: orangeColor,
          fontFamily: 'Inter',
          textTheme: TextTheme(
            headline1: TextStyle(
                color: appBarTitleColor,
                fontSize: 26,
                fontWeight: FontWeight.w700),
            headline2: TextStyle(
                color: appBarTitleColor,
                fontSize: 14,
                fontWeight: FontWeight.w600),
            subtitle1: TextStyle(
                color: appBarTitleColor,
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
          appBarTheme: AppBarTheme(
            color: Colors.white,
            elevation: 0,
            titleTextStyle: TextStyle(color: appBarTitleColor),
            textTheme: TextTheme(
              headline1: TextStyle(
                  color: appBarTitleColor,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Inter'),
            ),
          ),
          primaryColor: primaryColor,
          scaffoldBackgroundColor: Colors.white),
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: r_SpalshScreen,
      // initialRoute: widget.isOnBoardSkip ? r_SpalshScreen : r_Onboarding,
      //home: FirstLoadPage(),
    );
  }
}
