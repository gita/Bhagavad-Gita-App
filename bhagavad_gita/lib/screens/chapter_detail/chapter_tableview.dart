import 'dart:convert';

import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/Constant/http_link_string.dart';
import 'package:bhagavad_gita/localization/demo_localization.dart';
import 'package:bhagavad_gita/models/all_chapter_verse_model.dart';
import 'package:bhagavad_gita/models/chapter_model.dart';
import 'package:bhagavad_gita/screens/home_screen.dart/read_more_page.dart';
import 'package:bhagavad_gita/services/navigator_service.dart';
import 'package:bhagavad_gita/widgets/tableof_content_Chapter_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../locator.dart';

class ChapterTableViewScreen extends StatefulWidget {
  @override
  _ChapterTableViewScreenState createState() => _ChapterTableViewScreenState();
}

class _ChapterTableViewScreenState extends State<ChapterTableViewScreen> {
  final NavigationService navigationService = locator<NavigationService>();
  final HttpLink httpLink = HttpLink(strGitaHttpLink);
  late ValueNotifier<GraphQLClient> client;
  late String verseTableView;
  List<Chapter> listChapters = [];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    client = ValueNotifier<GraphQLClient>(
        GraphQLClient(link: httpLink, cache: GraphQLCache()));

    verseTableView = """
    {
      allGitaChapters {
        nodes {
          chapterNumber
          nameTranslated
          name
          versesCount
        }
      }
    }
    """;
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
          SizedBox(width: kDefaultPadding),
          Spacer(),
          Row(
            children: [
              Text(
                DemoLocalization.of(context)!
                    .getTranslatedValue('tableOfContents')
                    .toString(),
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(fontSize: 18),
              ),
            ],
          ),
          Spacer(),
          SvgPicture.asset(
            "assets/icons/icon_back_arrow.svg",
            color: Colors.transparent,
          ),
          SizedBox(width: kDefaultPadding),
        ],
      ),
      body: GraphQLProvider(
        client: client,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: kPadding * 2),
            child: Query(
              options: QueryOptions(document: gql(verseTableView)),
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
                Map<String, dynamic> allGitaChapters = node["allGitaChapters"];
                List chapters = allGitaChapters["nodes"];
                if (listChapters.length == 0) {
                  listChapters = chapters.map((e) {
                    Map<String, dynamic> chapterTemp = e;
                    return Chapter.fromJson(chapterTemp);
                  }).toList();
                }

                print("Table of content : $chapters");
                return ListView.builder(
                  itemCount: listChapters.length,
                  itemBuilder: (context, index) {
                    Chapter chapter = listChapters[index];
                    return Column(
                      children: [
                        TableOfContentChapterWidget(
                          chapter: chapter,
                          onTap: () {
                            print('Tap');
                            setState(() {
                              listChapters.forEach((element) {
                                element.isExpanded = false;
                              });
                              chapter.isExpanded = !chapter.isExpanded!;
                            });
                          },
                        ),
                        chapter.isExpanded == true
                            ? AnimatedContainer(
                                height: chapter.isExpanded!
                                    ? calculateVerGridHeight(
                                        chapter.versesCount ?? 0)
                                    : 0,
                                duration: Duration(milliseconds: 300),
                                child: TableOfContectVerseGridWidget(
                                  chapter: chapter,
                                ))
                            : Container(),
                        Divider()
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  double calculateVerGridHeight(int verseCount) {
    if (verseCount % 5 == 0) {
      return (verseCount / 5) * 80;
    } else {
      if ((verseCount - 1) % 5 == 0) {
        return (((verseCount - 1) / 5) * 80) + 72;
      } else if ((verseCount - 2) % 5 == 0) {
        return (((verseCount - 2) / 5) * 80) + 72;
      } else if ((verseCount - 3) % 5 == 0) {
        return (((verseCount - 3) / 5) * 80) + 72;
      } else {
        return (((verseCount - 4) / 5) * 80) + 72;
      }
    }
  }
}

class TableOfContectVerseGridWidget extends StatefulWidget {
  const TableOfContectVerseGridWidget({Key? key, required this.chapter})
      : super(key: key);

  @override
  _TableOfContectVerseGridWidgetState createState() =>
      _TableOfContectVerseGridWidgetState();

  final Chapter chapter;
}

class _TableOfContectVerseGridWidgetState
    extends State<TableOfContectVerseGridWidget> {
  final NavigationService navigationService = locator<NavigationService>();
  final HttpLink httpLink = HttpLink(strGitaHttpLink);
  late ValueNotifier<GraphQLClient> client;
  late String strQueryVerseList;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    client = ValueNotifier<GraphQLClient>(
        GraphQLClient(link: httpLink, cache: GraphQLCache()));

    strQueryVerseList = """
    {
  gitaChapterById(id: ${widget.chapter.chapterNumber ?? 0}) {
    versesCount
    gitaVersesByChapterId {
      nodes {
        id
        verseNumber
      }
    }
  }
}
    """;
  }

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(document: gql(strQueryVerseList)),
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
        String json = jsonEncode(node);
        print("Verser list : $json");
        GetAllChapterVerseResponseModel chapterVerse =
            getAllChapterVerseResponseModelFromJson(json);
        List<ChapterVerseInfo> verse =
            chapterVerse.gitaChapterById!.gitaVersesByChapterId!.nodes!;

        return GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: kDefaultPadding * 2,
            mainAxisSpacing: kDefaultPadding * 2,
          ),
          itemCount: verse.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContinueReading(
                      verseID: "${verse[index].id}",
                    ),
                  ),
                );
              },
              child: Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  color: selectedIndex == index
                      ? primaryLightColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    '${verse[index].verseNumber ?? 0}',
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: 16,
                        color: selectedIndex == index
                            ? orangeColor
                            : textLightGreyColor),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
