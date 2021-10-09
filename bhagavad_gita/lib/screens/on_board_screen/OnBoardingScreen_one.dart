import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/Constant/string_constant.dart';
import 'package:bhagavad_gita/localization/demo_localization.dart';
import 'package:bhagavad_gita/locator.dart';
import 'package:bhagavad_gita/main.dart';
import 'package:bhagavad_gita/routes/route_names.dart';
import 'package:bhagavad_gita/services/navigator_service.dart';
import 'package:bhagavad_gita/services/shared_preferences.dart';
import 'package:bhagavad_gita/widgets/indicatorWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class OnbordingScreen extends StatefulWidget {
  const OnbordingScreen({Key? key}) : super(key: key);

  @override
  _SimplifiedScreenState createState() => _SimplifiedScreenState();
}

class _SimplifiedScreenState extends State<OnbordingScreen> {
  final PageController controller = PageController();
  final NavigationService navigationService = locator<NavigationService>();

  int pagerIndex = 0;
  int lastPage = 0;
  bool languagePopUp = false;

  int val = 0;
  List<String> listLang = ["English", "Hindi"];

  var allPages = [
    SimplifiedPageOne(),
    BeautifulDesignPageTwo(),
    ExploreEachVerePageThree(),
    MakeItOwnPageFour(
      isLastPage: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    val = listLang.indexWhere((element) =>
        element.toLowerCase() ==
        langauge.toLowerCase().replaceAll("\"", "replace"));
  }

  void _pageChange(int index) {
    setState(() {
      pagerIndex = index;
      controller.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: kPadding * 2.8, right: kPadding * 2.8),
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      onPageChanged: _pageChange,
                      scrollDirection: Axis.horizontal,
                      controller: controller,
                      itemCount: allPages.length,
                      itemBuilder: (context, index) {
                        return allPages[index];
                      },
                    ),
                  ),
                  PageIndicator(pagerIndex: pagerIndex, totalPages: 4),
                  SizedBox(height: kPadding * 7),
                  pagerIndex == 3
                      ? InkWell(
                          onTap: () {
                            buildShowDialog(context);
                          },
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(245, 121, 3, 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                DemoLocalization.of(context)!
                                    .getTranslatedValue('getStarted')
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: whiteColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _pageChange(pagerIndex + 2);
                                  pagerIndex = pagerIndex - 1;
                                });
                              },
                              child: Text(
                                DemoLocalization.of(context)!
                                    .getTranslatedValue('skip')
                                    .toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(color: textLightGreyColor),
                              ),
                            ),
                            Spacer(),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _pageChange(pagerIndex + 1);
                                  pagerIndex = pagerIndex - 1;
                                });
                              },
                              child: Row(
                                children: [
                                  Text(
                                    DemoLocalization.of(context)!
                                        .getTranslatedValue('next')
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2!
                                        .copyWith(color: orangeColor),
                                  ),
                                  SizedBox(width: 5),
                                  SvgPicture.asset(
                                      'assets/icons/RightSide_Arrow_Image.svg'),
                                ],
                              ),
                            ),
                          ],
                        ),
                  SizedBox(height: kPadding * 2),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> buildShowDialog(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [
            Container(
              height: 480, //MediaQuery.of(context).size.height / 100 * 80,
              width: 1000,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: Stack(
                children: [
                  SvgPicture.asset("assets/icons/Top_Image_GetStarted.svg"),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: SvgPicture.asset(
                        "assets/icons/Bottom_Image_GetStarted.svg"),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      SvgPicture.asset("assets/icons/abc_language.svg"),
                      SizedBox(
                        height: kPadding * 3,
                      ),
                      Text(
                        DemoLocalization.of(context)!
                            .getTranslatedValue('chooseLanguage')
                            .toString(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(fontSize: 18, color: blackColor),
                      ),
                      SizedBox(
                        height: kPadding * 1,
                      ),
                      Text(
                        DemoLocalization.of(context)!
                            .getTranslatedValue('dontWorry')
                            .toString(),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontSize: 14, color: textLightGreyColor),
                      ),
                      SizedBox(
                        height: kPadding * 3.5,
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                        child: Column(
                          children: [
                            for (int i = 0; i < listLang.length; i++)
                              ListTile(
                                title: Text(listLang[i]),
                                onTap: () {
                                  print("Valye : $i");
                                    setState(() {
                                      val = i;
                                    });
                                    _changeLanguage(listLang[val]);
                                },
                                leading: Radio(
                                  value: i,
                                  groupValue: val,
                                  onChanged: (int? value) {
                                    print("Valye : $value");
                                    setState(() {
                                      val = value ?? 0;
                                    });
                                    _changeLanguage(listLang[val]);
                                  },
                                  activeColor: orangeColor,
                                ),
                              ),
                          ],
                        ),
                      )),
                      Padding(
                        padding: EdgeInsets.all(30),
                        child: InkWell(
                          onTap: () {
                            SharedPref.saveSkipOnboardScreen();
                            navigationService.pushNamedAndRemoveUntil(r_Tabbar);
                          },
                          child: Container(
                            height: kPadding * 5,
                            width: kPadding * 19,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(245, 121, 3, 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                DemoLocalization.of(context)!
                                    .getTranslatedValue('okLetsGo')
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: whiteColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  void _changeLanguage(String strlang) {
    SharedPref.savelanguage(strlang.toLowerCase());
    langauge = strlang.toLowerCase();
    Locale _temp;
    switch (strlang.toLowerCase()) {
      case 'english':
        _temp = Locale('en', 'US');
        break;
      default:
        _temp = Locale('hi', 'IN');
    }
    MyApp.setLocales(context, _temp);
  }
}

class SimplifiedPageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(height: kPadding * 9),
        SvgPicture.asset('assets/icons/img_simplified_one.svg'),
        SizedBox(height: kPadding * 5),
        Text(
          DemoLocalization.of(context)!
              .getTranslatedValue('bhagvadGitaSimplified')
              .toString(),
          style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 18),
        ),
        SizedBox(height: kPadding * 2),
        Text(
          DemoLocalization.of(context)!
              .getTranslatedValue('readTheGita')
              .toString(),
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: textLightGreyColor,
              ),
        ),
      ],
    );
  }
}

class BeautifulDesignPageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SvgPicture.asset('assets/icons/img_beautiful_two.svg'),
        Text(
          DemoLocalization.of(context)!
              .getTranslatedValue('beautifulDesign')
              .toString(),
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 18),
        ),
        SizedBox(height: kPadding),
        Text(
          DemoLocalization.of(context)!
              .getTranslatedValue('modernAndInteractive')
              .toString(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: textLightGreyColor,
              ),
        ),
      ],
    );
  }
}

class ExploreEachVerePageThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(height: kPadding * 7),
        SvgPicture.asset('assets/icons/img_exploreverse_three.svg'),
        SizedBox(height: kPadding * 3),
        Text(
          DemoLocalization.of(context)!
              .getTranslatedValue('exploreEachVerse')
              .toString(),
          style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 18),
        ),
        SizedBox(height: kPadding),
        Text(
          DemoLocalization.of(context)!
              .getTranslatedValue('divedeepEachVerse')
              .toString(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: textLightGreyColor,
              ),
        ),
        SizedBox(height: kPadding),
      ],
    );
  }
}

class MakeItOwnPageFour extends StatelessWidget {
  final bool isLastPage;

  const MakeItOwnPageFour({Key? key, required this.isLastPage})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(height: kPadding * 7),
        SvgPicture.asset('assets/icons/img_makeitowe_forth.svg'),
        SizedBox(height: kPadding * 3),
        Text(
          DemoLocalization.of(context)!
              .getTranslatedValue('makeItYourOwn')
              .toString(),
          style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 18),
        ),
        SizedBox(height: kPadding),
        Text(
          DemoLocalization.of(context)!
              .getTranslatedValue('shearMemories')
              .toString(),
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: textLightGreyColor),
        ),
      ],
    );
  }
}
