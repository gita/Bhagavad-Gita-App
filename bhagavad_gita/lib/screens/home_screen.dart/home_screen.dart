// ignore_for_file: deprecated_member_use
import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/Constant/string_constant.dart';
import 'package:bhagavad_gita/localization/demo_localization.dart';
import 'package:bhagavad_gita/locator.dart';
import 'package:bhagavad_gita/models/chapter_model.dart';
import 'package:bhagavad_gita/models/verse_detail_model.dart';
import 'package:bhagavad_gita/routes/route_names.dart';
import 'package:bhagavad_gita/services/navigator_service.dart';
import 'package:bhagavad_gita/services/shared_preferences.dart';
import 'package:bhagavad_gita/widgets/chapter_list_tile_widget.dart';
import 'package:bhagavad_gita/widgets/last_read_widget.dart';
import 'package:bhagavad_gita/widgets/verse_of_the_day_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NavigationService navigationService = locator<NavigationService>();
  LastReadVerse? lastReadVerse;

  String fontFamily = 'Inter';

  final tempQuery = gql("""
    query {
    allGitaChapters {
      nodes {
        chapterNumber
        nameTranslated
        versesCount
      }
    }
  }
  """);

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 200), () async {
      var tempLastRead = await SharedPref.getLastRead();
      setState(() {
        lastReadVerse = tempLastRead;
      });
    });

    print("selected language : $langauge");
  }

  @override
  Widget build(BuildContext context) {
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
              child: SvgPicture.asset('assets/icons/icn_settings.svg')),
          SizedBox(
            width: kDefaultPadding,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            VerseOfTheDayWidget(),
            lastReadVerse == null
                ? Container()
                : LastReadWidget(
                    lastReadVerse: lastReadVerse!,
                    onButtonTap: () {
                      navigationService.pushNamed(r_ContinueReading,
                          arguments: "${lastReadVerse!.verseID ?? 0}");
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
                            .copyWith(color: greyScalBodyColor, fontSize: 20),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          print('Sort button tap');
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          child: Center(
                            child:
                                SvgPicture.asset('assets/icons/icn_sort.svg'),
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
                Map<String, dynamic> allGitaChapters = node["allGitaChapters"];
                List chapters = allGitaChapters["nodes"];
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: chapters.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> chapterTemp = chapters[index];
                    Chapter chapter = Chapter.fromJson(chapterTemp);
                    print("Chapter $chapter");
                    return ChapterListTileWidget(
                      index: index,
                      onTap: () {
                        navigationService.pushNamed(r_ChapterDetail,
                            arguments: chapter.chapterNumber ?? 1);
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
    );
  }
}
