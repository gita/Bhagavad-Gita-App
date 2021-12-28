import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/locator.dart';
import 'package:bhagavad_gita/routes/route_names.dart';
import 'package:bhagavad_gita/services/navigator_service.dart';
import 'package:bhagavad_gita/services/shared_preferences.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final NavigationService navigationService = locator<NavigationService>();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 1), () async {
      bool onBoardSkip = await SharedPref.checkOnBoardScreenIsSkip();
      navigationService
          .pushReplacementNamed(onBoardSkip ? r_Tabbar : r_Onboarding);
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: Container(
          height: height * 0.4,
          width: width * 0.4,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/splashScreen.png'),
            ),
          ),
        ),
      ),
    );
  }
}
