// ignore_for_file: deprecated_member_use

import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/Constant/string_constant.dart';
import 'package:bhagavad_gita/localization/demo_localization.dart';
import 'package:bhagavad_gita/locator.dart';
import 'package:bhagavad_gita/models/chapter_model.dart';
import 'package:bhagavad_gita/models/verse_detail_model.dart';
import 'package:bhagavad_gita/routes/route_names.dart';
import 'package:bhagavad_gita/screens/home_screen.dart/read_more_page.dart';
import 'package:bhagavad_gita/services/last_read_services.dart';
import 'package:bhagavad_gita/services/navigator_service.dart';
import 'package:bhagavad_gita/services/shared_preferences.dart';
import 'package:bhagavad_gita/widgets/chapter_list_tile_widget.dart';
import 'package:bhagavad_gita/widgets/last_read_widget.dart';
import 'package:bhagavad_gita/widgets/verse_of_the_day_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  final NavigationService navigationService = locator<NavigationService>();
  LastReadVerse? lastReadVerse;
  bool isSortChapterNum = true;
  int numberOfChapRead = 0;
  bool reviewDialogShown = false;

  String fontFamily = 'Inter';
  bool isReverse = false;

  final tempQuery = gql("""
    query {
    allGitaChapters {
      nodes {
        chapterNumber
        name
        nameTranslated
        versesCount
      }
    }
  }
  """);

  @override
  void initState() {
    super.initState();

    print('-->> Init State');
    Future.delayed(Duration(milliseconds: 200), () async {
      var tempLastRead = await SharedPref.getLastRead();
      setState(() {
        lastReadVerse = tempLastRead;
      });
      if (tempLastRead != null) {
        LocalNotification.instance.setNeedToShowLastRead(tempLastRead);
      }
    });
    LocalNotification.instance.needToShowLastRead.addListener(() {
      setState(() {
        lastReadVerse = LocalNotification.instance.needToShowLastRead.value;
      });
    });

    print("selected language : $langauge");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        actions: [
          SizedBox(width: kDefaultPadding),
          Center(
            child: Text(
              DemoLocalization.of(context)!
                  .getTranslatedValue('bhagvad_gita')
                  .toString(),
              style: AppBarTheme.of(context).textTheme!.headline1,
            ),
          ),
          Spacer(),
          InkWell(
            onTap: () {
              navigationService.pushNamed(r_Setting);
            },
            child: Container(
              width: kPadding * 4,
              child: Center(
                child: SvgPicture.asset('assets/icons/icn_settings.svg'),
              ),
            ),
          ),
          SizedBox(
            width: kDefaultPadding,
          )
        ],
      ),
      body: OfflineBuilder(
        connectivityBuilder: (BuildContext context,
            ConnectivityResult connectivity, Widget child) {
          final bool connected = connectivity != ConnectivityResult.none;
          return new Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                height: 24.0,
                left: 0.0,
                right: 0.0,
                child: !connected
                    ? Container(
                        color:
                            connected ? Color(0xFF00EE44) : Color(0xFFEE4400),
                        child: Center(
                          child: Text("${connected ? 'ONLINE' : 'OFFLINE'}"),
                        ),
                      )
                    : Container(),
              ),
              !connected
                  ? Center(
                      child: Text(
                        'connect to internet',
                        style: AppBarTheme.of(context).textTheme!.headline1,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          VerseOfTheDayWidget(),
                          lastReadVerse == null
                              ? Container()
                              : LastReadWidget(
                                  lastReadVerse: lastReadVerse!,
                                  onButtonTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ContinueReading(
                                          verseID:
                                              "${lastReadVerse!.verseID ?? 0}",
                                        ),
                                      ),
                                    );
                                  },
                                ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: kDefaultPadding,
                                right: kDefaultPadding,
                                bottom: kDefaultPadding),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      DemoLocalization.of(context)!
                                          .getTranslatedValue('chapters')
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1!
                                          .copyWith(
                                              color: greyScalBodyColor,
                                              fontSize: 20),
                                    ),
                                    Spacer(),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          isReverse = !isReverse;
                                        });
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        child: Center(
                                          child: SvgPicture.asset(
                                              'assets/icons/icn_sort.svg'),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Query(
                            options: QueryOptions(document: tempQuery),
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
                              Map<String, dynamic> node = result.data!;
                              Map<String, dynamic> allGitaChapters =
                                  node["allGitaChapters"];
                              List chapters = allGitaChapters["nodes"];
                              return ListView.builder(
                                reverse: isReverse,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: chapters.length,
                                itemBuilder: (context, index) {
                                  Map<String, dynamic> chapterTemp =
                                      chapters[index];
                                  Chapter chapter =
                                      Chapter.fromJson(chapterTemp);
                                  return ChapterListTileWidget(
                                    index: index,
                                    onTap: () async {
                                      if (reviewDialogShown == false) {
                                        numberOfChapRead = numberOfChapRead + 1;
                                      }
                                      if (numberOfChapRead == 5) {
                                        showReviewDialog();
                                        numberOfChapRead = numberOfChapRead + 1;
                                        reviewDialogShown = true;
                                      } else {
                                        navigationService.pushNamed(
                                            r_ChapterDetail,
                                            arguments:
                                                chapter.chapterNumber ?? 1);
                                      }
                                    },
                                    chapter: chapter,
                                  );
                                },
                              );
                            },
                          ),
                          SizedBox(height: kDefaultPadding * 2)
                        ],
                      ),
                    ),
            ],
          );
        },
        child: Container(),
      ),
    );
  }

  Future<void> showReviewDialog() async {
    final InAppReview inAppReview = InAppReview.instance;

    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }

  @override
  bool get wantKeepAlive => true;
}
