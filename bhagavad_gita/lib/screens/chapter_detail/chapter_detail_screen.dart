import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/Constant/http_link_string.dart';
import 'package:bhagavad_gita/localization/demo_localization.dart';
import 'package:bhagavad_gita/models/chapter_detail_model.dart';
import 'package:bhagavad_gita/routes/route_names.dart';
import 'package:bhagavad_gita/services/navigator_service.dart';
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

  @override
  void initState() {
    super.initState();
    client = ValueNotifier<GraphQLClient>(
        GraphQLClient(link: httpLink, cache: GraphQLCache()));

    chapterDetailQuery = """ 
    {
    gitaChapterById(id: ${widget.chapterNumber}) {
      chapterNumber
      nameTranslated
      chapterSummary
      gitaVersesByChapterId {
        nodes {
          chapterNumber
          verseNumber
          gitaTranslationsByVerseId(
            condition: { language: "english", authorName: "Swami Sivananda" }
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

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return GraphQLProvider(
      client: client,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Center(
              child: SvgPicture.asset("assets/icons/icon_back_arrow.svg",
                  width: 20),
            ),
          ),
          actions: [
            Spacer(),
            // TextButton(
            //   onPressed: () {},
            //   child: Text(
            //     StringConstant.strAa,
            //     style: Theme.of(context)
            //         .textTheme
            //         .headline1!
            //         .copyWith(fontSize: 18, fontWeight: FontWeight.w100),
            //   ),
            // ),
            InkWell(
              onTap: () {
                navigationService.pushNamed(r_ChapterTableView);
              },
              child: Container(
                width: 40,
                child: Center(
                  child: SvgPicture.asset('assets/icons/Icon_menu_bottom.svg'),
                ),
              ),
            ),
            SizedBox(width: kDefaultPadding),
          ],
        ),
        body: Stack(
          children: [
            Positioned(
              child: SvgPicture.asset("assets/icons/flower_chapterDetail.svg"),
            ),
            Positioned(
              right: 0,
              child: SvgPicture.asset(
                  "assets/icons/flower_chapterDetail_right.svg"),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: kPadding * 2),
                child: SingleChildScrollView(
                  child: Query(
                      options: QueryOptions(document: gql(chapterDetailQuery)),
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
                        print(
                            "Verse : ${chapterDetailData.gitaChapterById!.gitaVersesByChapterId!.nodes![0].gitaTranslationsByVerseId!.nodes![0].verseId}");
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
                                      color: orangeColor,
                                      fontSize: 16,
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
                                  .copyWith(fontSize: 18),
                            ),
                            SizedBox(height: kDefaultPadding * 2),
                            Text(
                              chapterDetailData
                                      .gitaChapterById!.chapterSummary ??
                                  '',
                              maxLines: isShowMoreChapterDetail ? 500 : 4,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.subtitle1,
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
                                        ? DemoLocalization.of(context)!.getTranslatedValue('showLess').toString()
                                        : DemoLocalization.of(context)!.getTranslatedValue('showMore').toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2!
                                        .copyWith(color: textLightGreyColor),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: kDefaultPadding),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: chapterDetailData.gitaChapterById!
                                  .gitaVersesByChapterId!.nodes!.length,
                              itemBuilder: (BuildContext context, index) {
                                return VerseDetailWidget(
                                  verse: chapterDetailData.gitaChapterById!
                                      .gitaVersesByChapterId!.nodes![index],
                                );
                              },
                            )
                          ],
                        );
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
