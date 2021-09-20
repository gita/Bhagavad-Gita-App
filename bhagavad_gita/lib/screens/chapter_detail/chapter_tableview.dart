import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/Constant/http_link_string.dart';
import 'package:bhagavad_gita/models/verse_tableView_model.dart';
import 'package:bhagavad_gita/services/navigator_service.dart';
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

  bool isShowVerseNumberCount = false;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return GraphQLProvider(
      client: client,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
        body: SafeArea(
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
                Map<String, dynamic>? vTable = result.data;
                ChapterListResponseModel chapterListResponseModel =
                    ChapterListResponseModel.fromJson(vTable!);
                print(
                    'CHAPTER  ${chapterListResponseModel.data!.allGitaChapters!.nodes![0].chapterNumber}');
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: vTable.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "CHAPTER ${chapterListResponseModel.data!.allGitaChapters!.nodes![0].chapterNumber}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(fontSize: 14),
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      child: Center(
                                        child: SvgPicture.asset(
                                            "assets/icons/icon_downsidearrow.svg"),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                  "${chapterListResponseModel.data!.allGitaChapters!.nodes![0].nameTranslated}",
                                  style: Theme.of(context).textTheme.subtitle1),
                              SizedBox(height: kDefaultPadding),
                              Row(
                                children: [
                                  Container(
                                    height: 9.33,
                                    width: 12,
                                    child: SvgPicture.asset(
                                        "assets/icons/Icon_menu_bottom.svg",
                                        color: textLightGreyColor),
                                  ),
                                  SizedBox(width: kPadding),
                                  Text(
                                    "${chapterListResponseModel.data!.allGitaChapters!.nodes![0].versesCount}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(
                                            fontSize: 14,
                                            color: textLightGreyColor),
                                  ),
                                ],
                              ),
                              Divider(height: kDefaultPadding * 2)
                            ],
                          );
                        },
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

/*

Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 18,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "CHAPTER 1",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(fontSize: 14),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                setState(() {});
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                child: Center(
                                  child: SvgPicture.asset(
                                      "assets/icons/icon_downsidearrow.svg"),
                                ),
                              ),
                            )
                          ],
                        ),
                        Text("Arjuna Visada Yoga",
                            style: Theme.of(context).textTheme.subtitle1),
                        SizedBox(height: kDefaultPadding),
                        Row(
                          children: [
                            Container(
                              height: 9.33,
                              width: 12,
                              child: SvgPicture.asset(
                                  "assets/icons/Icon_menu_bottom.svg",
                                  color: textLightGreyColor),
                            ),
                            SizedBox(width: kPadding),
                            Text(
                              "42 verse",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                      fontSize: 14, color: textLightGreyColor),
                            ),
                          ],
                        ),
                        Divider(height: kDefaultPadding * 2)
                      ],
                    );
                  },
                ),
              )
            ],
          ),

*/
