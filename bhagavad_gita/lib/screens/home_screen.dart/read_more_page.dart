// ignore_for_file: unused_local_variable

import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/Constant/http_link_string.dart';
import 'package:bhagavad_gita/models/verse_detail_model.dart';
import 'package:bhagavad_gita/routes/route_names.dart';
import 'package:bhagavad_gita/screens/bottom_navigation_menu/bottom_navigation_screen.dart';
import 'package:bhagavad_gita/services/navigator_service.dart';
import 'package:bhagavad_gita/services/shared_preferences.dart';
import 'package:bhagavad_gita/widgets/last_read_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../locator.dart';

class ContinueReading extends StatefulWidget {
  const ContinueReading({Key? key, required this.verseID}) : super(key: key);

  @override
  _ContinueReadingState createState() => _ContinueReadingState();
  final String verseID;
}

class _ContinueReadingState extends State<ContinueReading> {
  final NavigationService navigationService = locator<NavigationService>();
  final HttpLink httpLink = HttpLink(strGitaHttpLink);
  late ValueNotifier<GraphQLClient> client;
  late String verseDetailQuery;

  @override
  void initState() {
    super.initState();
    client = ValueNotifier<GraphQLClient>(
        GraphQLClient(link: httpLink, cache: GraphQLCache()));

    verseDetailQuery = """
  query GetVerseDetailsById {
    gitaVerseById(id: ${widget.verseID}) {
      chapterNumber
      verseNumber
      text
      gitaTranslationsByVerseId(condition: { language: "english", authorName: "Swami Sivananda" }) {
        nodes {
          description
        }
      }
      gitaCommentariesByVerseId(condition: { language: "english", authorName: "Swami Sivananda" }) {
        nodes {
          description
        }
      }
    }
  }
  """;
  }

  double lineSpacing = 1.5;
  LastReadVerse? lastReadVerse;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Center(
            child:
                SvgPicture.asset("assets/icons/icon_back_arrow.svg", width: 20),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Aa",
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: 18, fontWeight: FontWeight.w100),
            ),
          ),
          SizedBox(
            width: kPadding,
          ),
          InkWell(
            onTap: () {
              navigationService.pushNamed(r_Setting);
            },
            child: Container(
              width: 40,
              child: Center(
                child:
                    SvgPicture.asset('assets/icons/icon_setting_nonsele.svg'),
              ),
            ),
          ),
          SizedBox(
            width: kDefaultPadding,
          )
        ],
      ),
      body: GraphQLProvider(
        client: client,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SingleChildScrollView(
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
                        Map<String, dynamic>? verse = result.data;
                        VerseDetailData data = VerseDetailData.fromJson(verse!);
                        lastReadVerse = LastReadVerse(
                            verseID: widget.verseID,
                            gitaVerseById: data.gitaVerseById!);
                        SharedPref.saveLastRead(lastReadVerse!);
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
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              SizedBox(
                                height: kDefaultPadding,
                              ),
                              Text(
                                "${data.gitaVerseById!.text}",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      color: orangeColor,
                                    ),
                              ),
                              SizedBox(
                                height: kPadding * 3,
                              ),
                              Text(
                                "dhṛitarāśhtra uvācha\ndharma-kṣhetre kuru-kṣhetre\nsamavetā yuyutsavaḥ\nmāmakāḥ pāṇḍavāśhchaiva\nkimakurvata sañjaya",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(height: lineSpacing),
                              ),
                              SizedBox(
                                height: kDefaultPadding * 2,
                              ),
                              Text(
                                "dhṛitarāśhtraḥ uvācha—Dhritarashtra said;\ndharma-kṣhetre—the land of dharma;\nkuru-kṣhetre—at Kurukshetra;\nsamavetāḥ—having gathered;\nyuyutsavaḥ—desiring to fight;\nmāmakāḥ—my sons; pāṇḍavāḥ—the sons\nof Pandu; cha—and; eva—certainly;\nkim—what; akurvata—did they do;\nsañjaya—Sanjay",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(height: lineSpacing),
                              ),
                              SizedBox(height: kDefaultPadding * 2),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      "assets/icons/icon_left_rtansection.svg"),
                                  SizedBox(width: kDefaultPadding),
                                  Text(
                                    "TRANSLATION",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  SizedBox(width: kDefaultPadding),
                                  SvgPicture.asset(
                                      "assets/icons/icon_right_translation.svg")
                                ],
                              ),
                              SizedBox(height: kDefaultPadding),
                              Text(
                                data.gitaVerseById!.gitaTranslationsByVerseId!
                                    .nodes![0].description!,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(height: lineSpacing),
                              ),
                              SizedBox(
                                height: kDefaultPadding,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      "assets/icons/icon_left_rtansection.svg"),
                                  SizedBox(width: kDefaultPadding),
                                  Text(
                                    "COMMENTARY",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700),
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
                                data.gitaVerseById!.gitaCommentariesByVerseId!
                                    .nodes![0].description!,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(height: lineSpacing),
                              ),
                              SizedBox(height: kDefaultPadding * 5)
                            ],
                          ),
                        );
                      })),
              Positioned(
                top: MediaQuery.of(context).size.height / 100 * 71,
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
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/icons/icon_slider_verse.svg",
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 100 * 71,
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
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/icons/Icon_slider_verseNext.svg",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 15,
        child: Container(
          height: 48,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  navigationService.pushNamed(r_ChapterTableView);
                },
                child: Container(
                  height: 48,
                  width: 70,
                  child: Center(
                    child:
                        SvgPicture.asset("assets/icons/Icon_menu_bottom.svg"),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 48,
                  width: 70,
                  child: Center(
                    child:
                        SvgPicture.asset("assets/icons/Icon_shear_bottom.svg"),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _onPressedEditButton(context);
                  });
                },
                child: Container(
                  height: 48,
                  width: 70,
                  child: Center(
                    child:
                        SvgPicture.asset("assets/icons/Icon_write_bottom.svg"),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (lastReadVerse != null) {
                    SharedPref.saveBookmarkVerse(lastReadVerse!);
                  }
                },
                child: Container(
                  height: 48,
                  width: 70,
                  child: Center(
                    child:
                        SvgPicture.asset("assets/icons/Icon_save_bottom.svg"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressedEditButton(BuildContext context) {
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
              },
              initialLineSpacing: lineSpacing,
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

/*

return Padding(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Column(
                    children: [
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      Text(
                        "${verseDetailData.gitaVerseById!.chapterNumber ?? ''}",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      Text(
                        "धृतराष्ट्र उवाच |\nधर्मक्षेत्रे कुरुक्षेत्रे समवेता युयुत्सवः |\nमामकाः पाण्डवाश्चैव किमकुर्वत सञ्जय ||1||",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: orangeColor, height: lineSpacing * 1.5),
                      ),
                      SizedBox(
                        height: kPadding * 3,
                      ),
                      Text(
                        "dhṛitarāśhtra uvācha\ndharma-kṣhetre kuru-kṣhetre\nsamavetā yuyutsavaḥ\nmāmakāḥ pāṇḍavāśhchaiva\nkimakurvata sañjaya",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(height: lineSpacing),
                      ),
                      SizedBox(
                        height: kDefaultPadding * 2,
                      ),
                      Text(
                        "dhṛitarāśhtraḥ uvācha—Dhritarashtra said;\ndharma-kṣhetre—the land of dharma;\nkuru-kṣhetre—at Kurukshetra;\nsamavetāḥ—having gathered;\nyuyutsavaḥ—desiring to fight;\nmāmakāḥ—my sons; pāṇḍavāḥ—the sons\nof Pandu; cha—and; eva—certainly;\nkim—what; akurvata—did they do;\nsañjaya—Sanjay",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(height: lineSpacing),
                      ),
                      SizedBox(height: kDefaultPadding * 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                              "assets/icons/icon_left_rtansection.svg"),
                          SizedBox(width: kDefaultPadding),
                          Text(
                            "TRANSLATION",
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                          SizedBox(width: kDefaultPadding),
                          SvgPicture.asset(
                              "assets/icons/icon_right_translation.svg")
                        ],
                      ),
                      SizedBox(height: kDefaultPadding),
                      Text(
                        "Dhritarashtra said: O Sanjay, after gathering on the holy field of Kurukshetra, and desiring to fight, what did my sons and the sons of Pandu do?  ",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(height: lineSpacing),
                      ),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                              "assets/icons/icon_left_rtansection.svg"),
                          SizedBox(width: kDefaultPadding),
                          Text(
                            "COMMENTARY",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w700),
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
                        "The two armies had gathered on the battlefield of Kurukshetra, well prepared to fight a war that was inevitable. Still, in this verse, King Dhritarashtra asked Sanjay, what his sons and his brother Pandu’s sons were doing on the battlefield? It was apparent that they would fight, then why did he ask such a question?The blind King Dhritarashtra’s fondness for his own sons had clouded his spiritual wisdom and deviated him from the path of virtue. He had usurped the kingdom of Hastinapur from the rightful heirs; the Pandavas, sons of his brother Pandu. Feeling guilty of the injustice he had done towards his nephews, his conscience worried him about the outcome of this battle.The words dharma kṣhetre, the land of dharma (virtuous conduct) used by Dhritarashtra depict the dilemma he was experiencing.  Kurukshetra is described as kurukṣhetraṁ deva yajanam in the Shatapath Brahman, the Vedic textbook detailing rituals. It means “Kurukshetra is the sacrificial arena of the celestial gods.” Hence, it was regarded as the sacred land that nourished dharma. Dhritarashtra feared that the holy land might influence the minds of his sons. If it aroused the faculty of discrimination, they might turn away from killing their cousins and negotiate a truce. A peaceful settlement meant that the Pandavas would continue being a hindrance for them. He felt great displeasure at these possibilities, instead preferred that this war transpires. He was uncertain of the consequences of the war, yet desired to determine the fate of his sons. Therefore, he asked Sanjay about the activities of the two armies on the battleground.",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(height: lineSpacing),
                      )
                    ],
                  ),
                );

*/
