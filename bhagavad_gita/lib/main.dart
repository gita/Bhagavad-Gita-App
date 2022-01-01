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
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

///// firbase push notification in Background
Future<void> onBackgroundMessage(RemoteMessage message) async {
  print("remote background message${message.data.hashCode}");
  await Firebase.initializeApp();
  // flutterLocalNotificationsPlugin.show(
  //     message.data.hashCode,
  //     message.data['title'],
  //     message.data['body'],
  //     NotificationDetails(
  //         android: AndroidNotificationDetails(channel.id, channel.name,
  //             icon: message.notification?.android?.smallIcon)));
}

///// Android notification channel 
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'id',
  'android.intent.category.DEFAULT',
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //// firebase initialized
  await Firebase.initializeApp();
  //// firebase subscribeTopic
  await FirebaseMessaging.instance.subscribeToTopic('Bhagavad-gita-app');
  //FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  setupServiceLocator();
  langauge = (await SharedPref.getLanguage())!.replaceAll("\"", "");

  ///bool onBoardSkip = await SharedPref.checkOnBoardScreenIsSkip();
  savedVerseTranslation = await SharedPref.getSavedVerseTranslationSetting();
  savedVerseCommentary = await SharedPref.getSavedVerseCommentarySetting();
  //savedLastReadVerse = await SharedPref.getLastRead();
  print("Selected lang : $langauge");
  runApp(MyApp());
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
  String? token;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
    //// firebase forground notification
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("remote message${message.notification}");
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    icon: android.smallIcon)));
      }
    });
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bhagavad Gita',
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

  getToken() async {
    token = await FirebaseMessaging.instance.getToken();
    print("token  $token");
  }
}
