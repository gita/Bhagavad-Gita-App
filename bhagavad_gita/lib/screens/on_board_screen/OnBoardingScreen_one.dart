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
  bool isSkip = false;

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

  _pageChange(int index) {
    if (!isSkip) {
      print("Page changed : $index");
      setState(() {
        pagerIndex = index;
        controller.animateToPage(index,
            duration: Duration(milliseconds: 500), curve: Curves.ease);
      });
    } else {
      isSkip = false;
    }
  }

  _navigateToLastPage() {
    print("Navigate last page");
    isSkip = true;
    setState(() {
      pagerIndex = 3;
      controller.jumpToPage(3);
      // controller.animateToPage(3,
      //     duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: kPadding * 2.8, right: kPadding * 2.8),
          child: Column(
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
                  ? Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(245, 121, 3, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            buildShowDialog(context);
                          },
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
                      ),
                    )
                  : Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            _navigateToLastPage();
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
                            _pageChange(pagerIndex + 1);
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
        ),
      ),
    );
  }

  buildShowDialog(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [
            Container(
              height: 425, //MediaQuery.of(context).size.height / 100 * 80,
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
                        height: height*0.030,
                      ),
                      SvgPicture.asset("assets/icons/abc_language.svg"),
                      SizedBox(
                        height: height *0.02,
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
                        padding: EdgeInsets.symmetric(horizontal:30,vertical: height*0.030),
                        child: Container(
                          height: kPadding * 5,
                          width: kPadding * 19,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(245, 121, 3, 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                SharedPref.saveSkipOnboardScreen();
                                navigationService
                                    .pushNamedAndRemoveUntil(r_Tabbar);
                              },
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
        SizedBox(height: height * 0.089),
        SvgPicture.asset('assets/icons/img_simplified_one.svg',height: height*0.39,),
        SizedBox(height: height *0.052),
        Text(
          DemoLocalization.of(context)!
              .getTranslatedValue('bhagvadGitaSimplified')
              .toString(),
          style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 18),
        ),
        SizedBox(height: height * 0.02),
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
        SvgPicture.asset('assets/icons/img_beautiful_two.svg',height: height*0.45,),
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
        SizedBox(height: height * 0.07),
        SvgPicture.asset('assets/icons/img_exploreverse_three.svg',height: height*0.35,),
        SizedBox(height: height * 0.03),
        Text(
          DemoLocalization.of(context)!
              .getTranslatedValue('exploreEachVerse')
              .toString(),
          style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 18),
        ),
        SizedBox(height: kPadding-4),
        Text(
          DemoLocalization.of(context)!
              .getTranslatedValue('divedeepEachVerse')
              .toString(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: textLightGreyColor,fontSize:height* 0.022
              ),
        ),
        // SizedBox(height: kPadding),
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
        SvgPicture.asset('assets/icons/img_makeitowe_forth.svg',height: height*0.32,),
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
