import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/Constant/http_link_string.dart';
import 'package:bhagavad_gita/Constant/static_model.dart';
import 'package:bhagavad_gita/Constant/string_constant.dart';
import 'package:bhagavad_gita/models/color_selection_model.dart';
import 'package:bhagavad_gita/localization/demo_localization.dart';
import 'package:bhagavad_gita/models/notes_model.dart';
import 'package:bhagavad_gita/models/verse_detail_model.dart';
import 'package:bhagavad_gita/routes/route_names.dart';
import 'package:bhagavad_gita/screens/bottom_navigation_menu/bottom_navigation_screen.dart';
import 'package:bhagavad_gita/screens/setting_screens/open_setting_screen.dart';
import 'package:bhagavad_gita/services/last_read_services.dart';
import 'package:bhagavad_gita/services/navigator_service.dart';
import 'package:bhagavad_gita/services/shared_preferences.dart';
import 'package:bhagavad_gita/widgets/add_notes_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:share/share.dart';
import '../../locator.dart';

class ContinueReading extends StatefulWidget {
  const ContinueReading({
    Key? key,
    required this.verseID,
  }) : super(key: key);

  @override
  _ContinueReadingState createState() => _ContinueReadingState();
  final String verseID;
}

class _ContinueReadingState extends State<ContinueReading> {
  final NavigationService navigationService = locator<NavigationService>();
  final HttpLink httpLink = HttpLink(strGitaHttpLink);
  late ValueNotifier<GraphQLClient> client;
  late String verseDetailQuery;

  bool isVerseSaved = false;
  VerseNotes? verseNotes;
  int versId = 1;
  bool isScrolleScreen = false;

  LastReadVerse? lastReadVerse;

  //// Customisation
  double lineSpacing = 1.5;
  String fontFamily = 'Inter';
  double fontSize = 18;
  FormatingColor formatingColor = whiteFormatingColor;
  late VerseCustomissation verseCustomissation;

  bool showTraliteration = true;
  bool showTranslation = true;
  bool showCommentry = true;
  late ScrollController _hideButtomController;
  @override
  void initState() {
    super.initState();
    setState(() {
      versId = int.parse(widget.verseID);
      getVersDetails();

      _isVisible = true;
      _hideButtomController = new ScrollController();
      _hideButtomController.addListener(() {
        if (_hideButtomController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (_isVisible)
            setState(() {
              _isVisible = false;
              print("**** $_isVisible up");
            });
        }
        if (_hideButtomController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (!_isVisible)
            setState(() {
              _isVisible = true;
              print("**** $_isVisible down");
            });
        }
      });
    });

    SharedPref.getSavedVerseListCustomisation().then((value) {
      verseCustomissation = value;
      setState(() {
        lineSpacing = value.lineSpacing;
        fontFamily = value.fontfamily;
        fontSize = value.fontsize.toDouble();
        if (value.colorId == "1") {
          formatingColor = whiteFormatingColor;
        } else if (value.colorId == "2") {
          formatingColor = orangeFormatingColor;
        } else if (value.colorId == "3") {
          formatingColor = blackFormatingColor;
        }
      });
    });

    getAllToggelValueFormShowingContent();
  }

  getAllToggelValueFormShowingContent() {
    SharedPref.getSavedBoolValue(PreferenceConstant.verseTransliterationSetting)
        .then((value) {
      setState(() {
        showTraliteration = value;
      });
    });
    SharedPref.getSavedBoolValue(PreferenceConstant.verseTranslationSetting)
        .then((value) {
      setState(() {
        showTranslation = value;
      });
    });
    SharedPref.getSavedBoolValue(PreferenceConstant.verseCommentarySetting)
        .then((value) {
      setState(() {
        showCommentry = value;
      });
    });
  }

  getVersDetails() {
    client = ValueNotifier<GraphQLClient>(
        GraphQLClient(link: httpLink, cache: GraphQLCache()));

    print('object-------$versId');
    String language1 = savedVerseTranslation.language ?? "english";
    String language2 = savedVerseCommentary.language ?? "english";

    String auther1 = savedVerseTranslation.authorName ?? "Swami Sivananda";
    String auther2 = savedVerseCommentary.authorName ?? "Swami Sivananda";

    verseDetailQuery = """
  query GetVerseDetailsById {
    gitaVerseById(id: $versId) {
      chapterNumber
      verseNumber
      text
      transliteration
      wordMeanings
      gitaTranslationsByVerseId(condition: { language: "$language1", authorName: "$auther1" }) {
        nodes {
          description
        }
      }
      gitaCommentariesByVerseId(condition: { language: "$language2", authorName: "$auther2" }) {
        nodes {
          description
        }
      }
    }
  }
  """;

    print("Query : $verseDetailQuery");
    getVerseNotes();
  }

  getVerseNotes() {
    setState(() {
      isVerseSaved = false;
      verseNotes = null;
    });
    Future.delayed(Duration(milliseconds: 200), () async {
      var result = await SharedPref.checkVerseIsSavedOrNot("$versId");
      var resultVerseNotes =
          await SharedPref.checkVerseNotesIsSavedOrNot("$versId");
      setState(() {
        isVerseSaved = result;
        verseNotes = resultVerseNotes;
      });
    });
  }

  changeVersePage() {
    setState(() {
      versId = versId + 1;
      getVersDetails();
    });
  }

  reverschangeVersePage() {
    setState(() {
      versId = versId - 1;
      getVersDetails();
    });
  }

  shareVerse() async {
    await Share.share(lastReadVerse!
            .gitaVerseById!.gitaTranslationsByVerseId!.nodes![0].description ??
        "");
  }

  var _isVisible;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: formatingColor.bgColor,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop(true);
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
                _onPressedEditButton(context);
              });
            },
            child: Text(
              StringConstant.strAa,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w100,
                  color: formatingColor.naviagationIconColor),
            ),
          ),
          SizedBox(
            width: kPadding,
          ),
          InkWell(
            onTap: () async {
              var temp = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingScreen(
                    refresh: () {
                      getAllToggelValueFormShowingContent();
                      setState(() {
                        getVersDetails();
                      });
                    },
                  ),
                ),
              );
              if (temp) {
                getAllToggelValueFormShowingContent();
                setState(() {
                  getVersDetails();
                });
              }
            },
            child: Container(
              width: 40,
              child: Center(
                child: SvgPicture.asset('assets/icons/icon_setting_nonsele.svg',
                    color: formatingColor.naviagationIconColor),
              ),
            ),
          ),
          SizedBox(
            width: kDefaultPadding,
          )
        ],
      ),
      backgroundColor: formatingColor.bgColor,
      body: GraphQLProvider(
        client: client,
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                height: height,
                child: SingleChildScrollView(
                  controller: _hideButtomController,
                  child: Query(
                    options: QueryOptions(document: gql(verseDetailQuery)),
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
                      print("SSSSSS : ${result.data}");
                      Map<String, dynamic>? verse = result.data;
                      VerseDetailData data = VerseDetailData.fromJson(verse!);
                      if (data.gitaVerseById == null) {
                        return Container();
                      }
                      lastReadVerse = LastReadVerse(
                          verseID: "$versId",
                          gitaVerseById: data.gitaVerseById!);
                      //SharedPref.saveLastRead(lastReadVerse!);
                      LocalNotification.instance
                          .setNeedToShowLastRead(lastReadVerse!);
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        child: Column(
                          children: [
                            SizedBox(
                              height: kDefaultPadding,
                            ),
                            Text(
                                "${data.gitaVerseById!.chapterNumber ?? 0}.${data.gitaVerseById!.verseNumber}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                        fontFamily: fontFamily,
                                        fontSize: fontSize + 5,
                                        color: formatingColor.textColor)),
                            SizedBox(
                              height: kDefaultPadding,
                            ),
                            Text(
                              "${data.gitaVerseById!.text}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: fontFamily,
                                  color: Color(0xffd97706),
                                  fontSize: fontSize + 2,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: kDefaultPadding * 1.5),
                            showTraliteration
                                ? Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              "assets/icons/icon_left_rtansection.svg"),
                                          SizedBox(width: 7),
                                          Text(
                                            DemoLocalization.of(context)!
                                                .getTranslatedValue(
                                                    'transliteration')
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(
                                                  fontFamily: fontFamily,
                                                  fontSize: (Localizations
                                                                  .localeOf(
                                                                      context)
                                                              .languageCode ==
                                                          'hi')
                                                      ? fontSize + 2
                                                      : fontSize - 2,
                                                  color:
                                                      formatingColor.textColor,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                          ),
                                          SizedBox(width: 7),
                                          SvgPicture.asset(
                                              "assets/icons/icon_right_translation.svg")
                                        ],
                                      ),
                                      SizedBox(height: kDefaultPadding),
                                      Text(
                                        "${data.gitaVerseById!.transliteration}",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                                fontSize:
                                                    (Localizations.localeOf(
                                                                    context)
                                                                .languageCode ==
                                                            'hi')
                                                        ? fontSize + 2
                                                        : fontSize,
                                                fontStyle: FontStyle.italic,
                                                height: lineSpacing,
                                                color: formatingColor.textColor,
                                                fontFamily: fontFamily),
                                      ),
                                      SizedBox(height: kDefaultPadding),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              "assets/icons/icon_left_rtansection.svg"),
                                          SizedBox(width: 7),
                                          Text(
                                            DemoLocalization.of(context)!
                                                .getTranslatedValue(
                                                    'word_meanings')
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(
                                                  fontFamily: fontFamily,
                                                  fontSize: (Localizations
                                                                  .localeOf(
                                                                      context)
                                                              .languageCode ==
                                                          'hi')
                                                      ? fontSize + 2
                                                      : fontSize - 2,
                                                  color:
                                                      formatingColor.textColor,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                          ),
                                          SizedBox(width: 7),
                                          SvgPicture.asset(
                                              "assets/icons/icon_right_translation.svg")
                                        ],
                                      ),
                                      SizedBox(height: kDefaultPadding),
                                      Text(
                                        "${data.gitaVerseById!.wordMeanings}",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                                fontSize:
                                                    (Localizations.localeOf(
                                                                    context)
                                                                .languageCode ==
                                                            'hi')
                                                        ? fontSize + 2
                                                        : fontSize,
                                                height: lineSpacing,
                                                color: formatingColor.textColor,
                                                fontFamily: fontFamily),
                                      ),
                                      SizedBox(height: kDefaultPadding * 1.5)
                                    ],
                                  )
                                : Text(''),
                            showTranslation
                                ? Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              "assets/icons/icon_left_rtansection.svg"),
                                          SizedBox(width: kDefaultPadding),
                                          Text(
                                            DemoLocalization.of(context)!
                                                .getTranslatedValue(
                                                    'translation')
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(
                                                  fontFamily: fontFamily,
                                                  fontSize: (Localizations
                                                                  .localeOf(
                                                                      context)
                                                              .languageCode ==
                                                          'hi')
                                                      ? fontSize + 2
                                                      : fontSize - 2,
                                                  color:
                                                      formatingColor.textColor,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                          ),
                                          SizedBox(width: kDefaultPadding),
                                          SvgPicture.asset(
                                              "assets/icons/icon_right_translation.svg")
                                        ],
                                      ),
                                      SizedBox(height: kDefaultPadding),
                                      Text(
                                        data
                                                    .gitaVerseById!
                                                    .gitaTranslationsByVerseId!
                                                    .nodes!
                                                    .length >
                                                0
                                            ? data
                                                .gitaVerseById!
                                                .gitaTranslationsByVerseId!
                                                .nodes![0]
                                                .description!
                                            : "---",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                                height: lineSpacing,
                                                fontSize:
                                                    (Localizations.localeOf(
                                                                    context)
                                                                .languageCode ==
                                                            'hi')
                                                        ? fontSize + 2
                                                        : fontSize,
                                                color: formatingColor.textColor,
                                                fontFamily: fontFamily),
                                      ),
                                    ],
                                  )
                                : Text(''),
                            showCommentry
                                ? Column(
                                    children: [
                                      SizedBox(height: kDefaultPadding * 1.5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              "assets/icons/icon_left_rtansection.svg"),
                                          SizedBox(width: kDefaultPadding),
                                          Text(
                                            DemoLocalization.of(context)!
                                                .getTranslatedValue('commentry')
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(
                                                    fontFamily: fontFamily,
                                                    fontSize: (Localizations
                                                                    .localeOf(
                                                                        context)
                                                                .languageCode ==
                                                            'hi')
                                                        ? fontSize + 2
                                                        : fontSize - 2,
                                                    color: formatingColor
                                                        .textColor,
                                                    fontWeight:
                                                        FontWeight.w700),
                                          ),
                                          SizedBox(width: kDefaultPadding),
                                          SvgPicture.asset(
                                              "assets/icons/icon_right_translation.svg")
                                        ],
                                      ),
                                      SizedBox(
                                        height: kDefaultPadding,
                                      ),
                                      Text(
                                        data
                                                    .gitaVerseById!
                                                    .gitaCommentariesByVerseId!
                                                    .nodes!
                                                    .length >
                                                0
                                            ? data
                                                .gitaVerseById!
                                                .gitaCommentariesByVerseId!
                                                .nodes![0]
                                                .description!
                                            : "---",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                                height: lineSpacing,
                                                fontSize:
                                                    (Localizations.localeOf(
                                                                    context)
                                                                .languageCode ==
                                                            'hi')
                                                        ? fontSize + 2
                                                        : fontSize,
                                                color: formatingColor.textColor,
                                                fontFamily: fontFamily),
                                      ),
                                    ],
                                  )
                                : Container(),
                            SizedBox(height: kDefaultPadding * 5),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              versId == 1
                  ? Container()
                  : Positioned(
                      top: MediaQuery.of(context).size.height / 100 * 71,
                      left: kDefaultPadding,
                      child: _isVisible
                          ? AnimatedContainer(
                              duration: Duration(milliseconds: 200),
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
                                      versId == 1
                                          ? versId = 1
                                          : reverschangeVersePage();
                                    },
                                    child: Center(
                                      child: SvgPicture.asset(
                                        "assets/icons/icon_slider_verse.svg",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ),
              versId == 701
                  ? Container()
                  : Positioned(
                      top: MediaQuery.of(context).size.height / 100 * 71,
                      right: kDefaultPadding,
                      child: _isVisible
                          ? AnimatedContainer(
                              duration: Duration(milliseconds: 200),
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
                                      changeVersePage();
                                    },
                                    child: Center(
                                      child: SvgPicture.asset(
                                        "assets/icons/Icon_slider_verseNext.svg",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    )
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          height: _isVisible ? 48.0 : 0.0,
          child: _isVisible
              ? BottomAppBar(
                  elevation: 0,
                  child: Container(
                    height: 48,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              navigationService.pushNamed(r_ChapterTableView);
                            },
                            child: Container(
                              child: Center(
                                child: SvgPicture.asset(
                                    "assets/icons/Icon_menu_bottom.svg"),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              shareVerse();
                            },
                            child: Container(
                              child: Center(
                                child: SvgPicture.asset(
                                    "assets/icons/Icon_shear_bottom.svg"),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              if (verseNotes == null) {
                                VerseNotes temp = VerseNotes(
                                    verseID: "$versId",
                                    gitaVerseById: lastReadVerse!.gitaVerseById,
                                    verseNote: "");
                                bool saved = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AddNotesWidget(verseNotes: temp),
                                  ),
                                );
                                if (saved) {
                                  getVerseNotes();
                                }
                              } else {
                                bool saved = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AddNotesWidget(verseNotes: verseNotes!),
                                  ),
                                );
                                if (saved) {
                                  getVerseNotes();
                                }
                              }
                            },
                            child: Container(
                              child: Center(
                                child: verseNotes == null
                                    ? SvgPicture.asset(
                                        "assets/icons/Icon_write_bottom.svg")
                                    : SvgPicture.asset(
                                        'assets/icons/Icon_fill_addNote.svg'),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              if (lastReadVerse != null) {
                                if (isVerseSaved) {
                                  await SharedPref.removeVerseFromSaved(
                                      "$versId");
                                  setState(() {
                                    isVerseSaved = !isVerseSaved;
                                  });
                                } else {
                                  await SharedPref.saveBookmarkVerse(
                                      lastReadVerse!);
                                  setState(() {
                                    isVerseSaved = !isVerseSaved;
                                  });
                                }
                              }
                            },
                            child: Container(
                              child: Center(
                                child: isVerseSaved
                                    ? SvgPicture.asset(
                                        "assets/icons/Icon_saved_bottom.svg")
                                    : SvgPicture.asset(
                                        "assets/icons/Icon_save_bottom.svg"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
        ),
      ),
    );
  }

  _onPressedEditButton(context) {
    showModalBottomSheet(
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
