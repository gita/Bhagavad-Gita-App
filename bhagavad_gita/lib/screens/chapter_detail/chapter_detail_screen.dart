import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/Constant/http_link_string.dart';
import 'package:bhagavad_gita/Constant/static_model.dart';
import 'package:bhagavad_gita/Constant/string_constant.dart';
import 'package:bhagavad_gita/localization/demo_localization.dart';
import 'package:bhagavad_gita/models/chapter_detail_model.dart';
import 'package:bhagavad_gita/models/chapter_model.dart';
import 'package:bhagavad_gita/models/color_selection_model.dart';
import 'package:bhagavad_gita/models/notes_model.dart';
import 'package:bhagavad_gita/routes/route_names.dart';
import 'package:bhagavad_gita/screens/bottom_navigation_menu/bottom_navigation_screen.dart';
import 'package:bhagavad_gita/services/navigator_service.dart';
import 'package:bhagavad_gita/services/shared_preferences.dart';
import 'package:bhagavad_gita/widgets/verse_detail_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../locator.dart';

class ChapterDetailScreen extends StatefulWidget {
  const ChapterDetailScreen({Key? key, required this.chapterNumber})
      : super(key: key);

  @override
  _ChapterDetailScreenState createState() => _ChapterDetailScreenState();

  final int chapterNumber;
}

class _ChapterDetailScreenState extends State<ChapterDetailScreen> {
  final NavigationService navigationService = locator<NavigationService>();
  final HttpLink httpLink = HttpLink(strGitaHttpLink);
  late ValueNotifier<GraphQLClient> client;
  late String chapterDetailQuery;
  bool isShowMoreChapterDetail = false;
  String fontFamily = 'Inter';
  double lineSpacing = 1.5;
  double fontSize = 16;
  FormatingColor formatingColor = whiteFormatingColor;
  bool isChapterNumSave = false;
  Chapter? chapter;
  int chapterNumber = 1;
  late VerseCustomissation verseCustomissation;

  @override
  void initState() {
    super.initState();
    chapterNumber = widget.chapterNumber;
    getChapterDetail();

    refreshChapterDetailPage();
  }

  refreshChapterDetailPage() {
    SharedPref.getSavedVerseListCustomisation().then((value) {
      verseCustomissation = value;
      setState(() {
        lineSpacing = value.lineSpacing;
        fontFamily = value.fontfamily;
        fontSize = value.fontsize.toDouble();
        print('FontSize ----> $fontSize');
        if (value.colorId == '1') {
          formatingColor = whiteFormatingColor;
        } else if (value.colorId == '2') {
          formatingColor = orangeFormatingColor;
        } else if (value.colorId == '3') {
          formatingColor = blackFormatingColor;
        }
      });
    });
  }

  getChapterDetail() {
    client = ValueNotifier<GraphQLClient>(
        GraphQLClient(link: httpLink, cache: GraphQLCache()));

    chapterDetailQuery = """ 
    {
    gitaChapterById(id: $chapterNumber) {
      chapterNumber
      nameTranslated
      chapterSummary
      gitaVersesByChapterId {
        nodes {
          chapterNumber
          verseNumber
          gitaTranslationsByVerseId(
            condition: { language: "${savedVerseTranslation.language ?? "english"}", authorName: "${savedVerseTranslation.authorName ?? "Swami Sivananda"}" }
          ) {
            nodes {
              description
              verseId
            }
          }
        }
      }
    }
  }
  """;
  }

  changeChapterPage() {
    if (chapterNumber < 18) {
      setState(() {
        chapterNumber = chapterNumber + 1;
        getChapterDetail();
      });
    }
  }

  reverschangeChapterPage() {
    if (chapterNumber > 1) {
      setState(() {
        chapterNumber = chapterNumber - 1;
        getChapterDetail();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return GraphQLProvider(
      client: client,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: formatingColor.bgColor,
          automaticallyImplyLeading: false,
          centerTitle: false,
          leading: InkWell(
            onTap: () {
              navigationService.goBack();
            },
            child: Center(
              child: SvgPicture.asset("assets/icons/icon_back_arrow.svg",
                  width: 20, color: formatingColor.naviagationIconColor),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  print('Bottom Navigation Menu');
                  formatingModalBottomSheet(context);
                });
              },
              child: Text(
                StringConstant.strAa,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 18,
                      color: formatingColor.naviagationIconColor,
                      fontWeight: FontWeight.w100,
                    ),
              ),
            ),
            SizedBox(width: kPadding),
            InkWell(
              onTap: () {
                navigationService.pushNamed(r_ChapterTableView);
              },
              child: Container(
                width: 40,
                child: Center(
                  child: SvgPicture.asset('assets/icons/Icon_menu_bottom.svg',
                      color: formatingColor.naviagationIconColor),
                ),
              ),
            ),
            SizedBox(width: kDefaultPadding),
          ],
        ),
        backgroundColor: formatingColor.bgColor,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: SafeArea(
                child: Stack(
                  children: [
                    SvgPicture.asset("assets/icons/flower_chapterDetail.svg"),
                    Positioned(
                      right: 0,
                      child: SvgPicture.asset(
                          "assets/icons/flower_chapterDetail_right.svg"),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: kPadding * 2),
                      child: Query(
                        options:
                            QueryOptions(document: gql(chapterDetailQuery)),
                        builder: (
                          QueryResult result, {
                          Refetch? refetch,
                          FetchMore? fetchMore,
                        }) {
                          if (result.hasException) {
                            print("ERROR : ${result.exception.toString()}");
                          }
                          if (result.data == null) {
                            return Container(
                              height: 200,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: primaryColor,
                                  strokeWidth: 2,
                                ),
                              ),
                            );
                          }
                          Map<String, dynamic>? res = result.data;
                          ChapterDetailData chapterDetailData =
                              ChapterDetailData.fromJson(res!);
                          print("API Response : $res");
                          return Column(
                            children: [
                              SizedBox(height: kDefaultPadding * 2),
                              Center(
                                child: Text(
                                  "${DemoLocalization.of(context)!.getTranslatedValue('chapter').toString()}  ${chapterDetailData.gitaChapterById!.chapterNumber ?? 1}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(
                                        height: lineSpacing,
                                        color: orangeColor,
                                        fontSize: fontSize,
                                        fontFamily: fontFamily,
                                      ),
                                ),
                              ),
                              SizedBox(height: kPadding),
                              Text(
                                chapterDetailData
                                        .gitaChapterById!.nameTranslated ??
                                    "",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                      height: lineSpacing,
                                      fontSize: fontSize,
                                      fontFamily: fontFamily,
                                      color:
                                          formatingColor.naviagationIconColor,
                                    ),
                              ),
                              SizedBox(height: kDefaultPadding * 2),
                              Text(
                                chapterDetailData
                                        .gitaChapterById!.chapterSummary ??
                                    '',
                                maxLines: isShowMoreChapterDetail ? 500 : 4,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      fontSize: fontSize,
                                      height: lineSpacing,
                                      fontFamily: fontFamily,
                                      color:
                                          formatingColor.naviagationIconColor,
                                    ),
                              ),
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        isShowMoreChapterDetail =
                                            !isShowMoreChapterDetail;
                                      });
                                    },
                                    child: Text(
                                      isShowMoreChapterDetail
                                          ? DemoLocalization.of(context)!
                                              .getTranslatedValue('showLess')
                                              .toString()
                                          : DemoLocalization.of(context)!
                                              .getTranslatedValue('showMore')
                                              .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .copyWith(
                                            fontSize: fontSize,
                                            height: lineSpacing,
                                            fontFamily: fontFamily,
                                            color: textLightGreyColor,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: kDefaultPadding),
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: chapterDetailData.gitaChapterById!
                                    .gitaVersesByChapterId!.nodes!.length,
                                itemBuilder: (BuildContext context, index) {
                                  return VerseDetailWidget(
                                    verse: chapterDetailData.gitaChapterById!
                                        .gitaVersesByChapterId!.nodes![index],
                                    formatingColor: formatingColor,
                                    lineSpacing: lineSpacing,
                                    fontSize: fontSize,
                                    fontFamily: fontFamily,
                                    refreshEditing: () {
                                      refreshChapterDetailPage();
                                    },
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            chapterNumber == 1
                ? Container()
                : Positioned(
                    top: MediaQuery.of(context).size.height / 100 * 75,
                    left: kDefaultPadding,
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: editBoxBorderColor,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        shape: CircleBorder(),
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          onTap: () {
                            reverschangeChapterPage();
                          },
                          child: Center(
                            child: SvgPicture.asset(
                              "assets/icons/icon_slider_verse.svg",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
            chapterNumber == 18
                ? Container()
                : Positioned(
                    top: MediaQuery.of(context).size.height / 100 * 75,
                    right: kDefaultPadding,
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: editBoxBorderColor,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        shape: CircleBorder(),
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          onTap: () {
                            changeChapterPage();
                          },
                          child: Center(
                            child: SvgPicture.asset(
                              "assets/icons/Icon_slider_verseNext.svg",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  formatingModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Color(0XFF737373),
          height: 350,
          child: Container(
            child: BottomNavigationMenu(
              lineSpacing: (double value) {
                setState(() {
                  lineSpacing = value;
                });
                verseCustomissation.lineSpacing = value;
                SharedPref.saveVerseListCustomisation(verseCustomissation);
              },
              initialLineSpacing: lineSpacing,
              selectedFontFamily: (String strFontFamily) {
                setState(() {
                  fontFamily = strFontFamily;
                });
                verseCustomissation.fontfamily = strFontFamily;
                SharedPref.saveVerseListCustomisation(verseCustomissation);
              },
              selectedFontSize: (int) {},
              fontName: fontFamily,
              fontSizeIncrease: (bool increase) {
                if (increase) {
                  setState(() {
                    fontSize = fontSize + 1;
                    print('FONTSIZE====>>$fontSize');
                  });
                } else {
                  setState(() {
                    fontSize = fontSize - 1;
                  });
                }
                verseCustomissation.fontsize = fontSize.toInt();
                SharedPref.saveVerseListCustomisation(verseCustomissation);
              },
              formatingColorSelection: (FormatingColor colorMode) {
                setState(() {
                  formatingColor = colorMode;
                });
                verseCustomissation.colorId = colorMode.id;
                SharedPref.saveVerseListCustomisation(verseCustomissation);
              },
              formatingColor: formatingColor,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          ),
        );
      },
    );
  }
}
