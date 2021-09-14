// ignore_for_file: file_names, prefer_const_constructors, use_key_in_widget_constructors

import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/Constant/string_constant.dart';
import 'package:bhagavad_gita/locator.dart';
import 'package:bhagavad_gita/routes/route_names.dart';
import 'package:bhagavad_gita/services/navigator_service.dart';
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

  int val = -1;

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
                  // SizedBox(height: kPadding * 10),
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
                  // SizedBox(height: kPadding * 1),
                  PageIndicator(pagerIndex: pagerIndex, totalPages: 4),
                  SizedBox(
                    height: kPadding * 8,
                  ),
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
                                StringConstant.strGetStarted,
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
                                StringConstant.strSkip,
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
                                    StringConstant.srtNext,
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
                  SizedBox(
                    height: kPadding * 2,
                  ),
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
              height: MediaQuery.of(context).size.height / 100 * 80,
              width: 1000,
              decoration: BoxDecoration(
                  // color: Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: BorderRadius.circular(15)),
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
                        StringConstant.strChooseLanguage,
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
                        StringConstant.strDontWorry,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontSize: 14, color: textLightGreyColor),
                      ),
                      SizedBox(
                        height: kPadding * 3.5,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: kPadding * 2.7, right: kPadding * 2.7),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: kPadding,
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                icon: Icon(
                                  Icons.search,
                                  color: blackColor,
                                ),
                                hintText: StringConstant.strSearchLanguage,
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: textLightGreyColor),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 20,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text("English"),
                              leading: Radio(
                                value: 1,
                                groupValue: val,
                                onChanged: (value) {
                                  setState(() {
                                    val = lastPage;
                                  });
                                },
                                activeColor: Colors.green,
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(30),
                        child: InkWell(
                          onTap: () {
                            navigationService.pushNamed(r_Tabbar);
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
                                StringConstant.strOkLetsGo,
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
}

class SimplifiedPageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(height: kPadding * 10),
        SvgPicture.asset('assets/icons/img_simplified_one.svg'),
        SizedBox(height: kPadding * 5),
        Text(
          StringConstant.strBhagvadGitaSimplified,
          style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 18),
        ),
        SizedBox(height: kPadding * 2),
        Text(
          StringConstant.strReadTheGita,
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
        SizedBox(
          height: kPadding * 5,
        ),
        Text(
          StringConstant.strBeautifulDesign,
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 18),
        ),
        SizedBox(
          height: kPadding * 2,
        ),
        Text(
          StringConstant.strModernAndInteractive,
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
        SizedBox(height: kPadding * 10),
        SvgPicture.asset('assets/icons/img_exploreverse_three.svg'),
        SizedBox(height: kPadding * 5),
        Text(
          StringConstant.strExploreEachVerse,
          style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 18),
        ),
        SizedBox(height: kPadding * 2),
        Text(
          StringConstant.strDiveDeepEachVerse,
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
        SizedBox(height: kPadding * 10),
        SvgPicture.asset('assets/icons/img_makeitowe_forth.svg'),
        SizedBox(height: kPadding * 5),
        Text(
          StringConstant.strMakeItYourOwn,
          style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 18),
        ),
        SizedBox(height: kPadding * 2),
        Text(
          StringConstant.strShareMemories,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: textLightGreyColor,
              ),
        ),
      ],
    );
  }
}
