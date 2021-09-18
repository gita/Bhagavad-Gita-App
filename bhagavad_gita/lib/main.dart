import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/locator.dart';
import 'package:bhagavad_gita/routes/app_router.dart';
import 'package:bhagavad_gita/screens/home_screen.dart/home_screen.dart';
import 'package:bhagavad_gita/services/navigator_service.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'Constant/http_link_string.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bhagvad Gita',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
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
                  fontWeight: FontWeight.w400)),
          appBarTheme: AppBarTheme(
              color: Colors.white,
              elevation: 0,
              titleTextStyle: TextStyle(color: appBarTitleColor),
              // ignore: deprecated_member_use
              textTheme: TextTheme(
                  headline1: TextStyle(
                      color: appBarTitleColor,
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter'))),
          primaryColor: primaryColor,
          scaffoldBackgroundColor: Colors.white),
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: AppRouter.generateRoute,
      //initialRoute: r_Onboarding,
      home: FirstLoadPage(),
    );
  }
}

class FirstLoadPage extends StatefulWidget {
  @override
  State<FirstLoadPage> createState() => _FirstLoadPageState();
}

class _FirstLoadPageState extends State<FirstLoadPage> {
  final HttpLink httpLink = HttpLink(strGitaHttpLink);

  late ValueNotifier<GraphQLClient> client;

  @override
  void initState() {
    super.initState();
    client = ValueNotifier<GraphQLClient>(
        GraphQLClient(link: httpLink, cache: GraphQLCache()));
    print("Connect 1");
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      child: HomeScreen(),
      client: client,
    );
  }
}
