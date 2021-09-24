import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/Constant/http_link_string.dart';
import 'package:bhagavad_gita/models/chapter_model.dart';
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
                "Table of contents",
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
                                chapter.isExpanded = !chapter.isExpanded!;
                              });
                            }),
                        AnimatedContainer(
                          height: chapter.isExpanded! ? 300 : 0,
                          duration: Duration(milliseconds: 300),
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              crossAxisSpacing: kDefaultPadding * 2,
                              mainAxisSpacing: kDefaultPadding * 2,
                            ),
                            itemCount: chapter.versesCount,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
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
                                      '${index + 1}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .copyWith(
                                              fontSize: 16,
                                              color: selectedIndex == index
                                                  ? orangeColor
                                                  : textLightGreyColor),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
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
}
