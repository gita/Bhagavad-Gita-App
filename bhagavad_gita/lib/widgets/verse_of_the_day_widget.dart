import 'dart:convert';
import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/Constant/http_link_string.dart';
import 'package:bhagavad_gita/Constant/static_model.dart';
import 'package:bhagavad_gita/localization/demo_localization.dart';
import 'package:bhagavad_gita/models/all_verse_of_the_day_model.dart';
import 'package:bhagavad_gita/models/verse_of_the_day_detail_model.dart';
import 'package:bhagavad_gita/screens/home_screen.dart/read_more_page.dart';
import 'package:bhagavad_gita/services/last_read_services.dart';
import 'package:bhagavad_gita/services/navigator_service.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import '../locator.dart';

class VerseOfTheDayWidget extends StatefulWidget {
  const VerseOfTheDayWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<VerseOfTheDayWidget> createState() => _VerseOfTheDayWidgetState();
}

class _VerseOfTheDayWidgetState extends State<VerseOfTheDayWidget> {
  final NavigationService navigationService = locator<NavigationService>();
  final HttpLink httpLink = HttpLink(strGitaHttpLink);

  late ValueNotifier<GraphQLClient> client;

  late String verseOfTheDayQuery;
  @override
  void initState() {
    super.initState();
    client = ValueNotifier<GraphQLClient>(
        GraphQLClient(link: httpLink, cache: GraphQLCache()));

    verseOfTheDayQuery = """
    query GetVerseOfTheDayId {
    allVerseOfTheDays(last: 1) {
    nodes {
      verseOrder
        } 
      }
    }
    """;
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: Query(
        options: QueryOptions(document: gql(verseOfTheDayQuery)),
        builder: (
          QueryResult result, {
          Refetch? refetch,
          FetchMore? fetchMore,
        }) {
          if (result.hasException) {
            print("ERROR : ${result.exception.toString()}");
          }
          Map<String, dynamic>? verseDay = result.data;
          if (verseDay == null) {
            return Container(
              height: 100,
              child: Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                  strokeWidth: 2,
                ),
              ),
            );
          }
          var respose = jsonEncode(verseDay);
          print('Verse of the day id : $respose');
          AllVerseOTheDayResponseModel allVerseOTheDayResponseModel =
              allVerseOTheDayResponseModelFromJson(respose);
          if (allVerseOTheDayResponseModel.allVerseOfTheDays!.nodes!.length ==
              0) {
            return Container();
          }
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding * 0.5,
                vertical: kDefaultPadding * 0.5),
            child: Container(
              height: (width - kDefaultPadding) * 0.52,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage('assets/images/home_verse_of_the_day.png'),
                      fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(kDefaultCornerRadius)),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/black_layer.png'),
                            fit: BoxFit.fill),
                        borderRadius:
                            BorderRadius.circular(kDefaultCornerRadius)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: kDefaultPadding,
                        top: kDefaultPadding,
                        bottom: kPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DemoLocalization.of(context)!
                              .getTranslatedValue('verseOfTheDay')
                              .toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(
                                  color: whiteColor, fontSize: width * 0.037),
                        ),
                        Spacer(),
                        VerseOfTheDayTextWidget(
                          verseID:
                              "${allVerseOTheDayResponseModel.allVerseOfTheDays!.nodes![0].verseOrder ?? 0}",
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContinueReading(
                                  verseID: allVerseOTheDayResponseModel
                                      .allVerseOfTheDays!.nodes![0].verseOrder
                                      .toString(),
                                ),
                              ),
                            );
                          },
                          child: Text(
                            DemoLocalization.of(context)!
                                .getTranslatedValue('readMore')
                                .toString(),
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(
                                    color: whiteColor, fontSize: width * 0.037),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class VerseOfTheDayTextWidget extends StatefulWidget {
  const VerseOfTheDayTextWidget({Key? key, required this.verseID})
      : super(key: key);

  @override
  State<VerseOfTheDayTextWidget> createState() =>
      _VerseOfTheDayTextWidgetState();
  final String verseID;
}

class _VerseOfTheDayTextWidgetState extends State<VerseOfTheDayTextWidget> {
  final HttpLink httpLink = HttpLink(strGitaHttpLink);
  late ValueNotifier<GraphQLClient> client;

  late String getVerseDetail;
  @override
  void initState() {
    super.initState();
    client = ValueNotifier<GraphQLClient>(
        GraphQLClient(link: httpLink, cache: GraphQLCache()));

    LocalNotification.instance.needToRefreshVerseOfTheDay.addListener(() {
      print("-->>>>>>>>>>");
      setState(() {
        String language1 = savedVerseTranslation.language ?? "english";
        String auther1 = savedVerseTranslation.authorName ?? "Swami Sivananda";
        getVerseDetail = """
            query GetVerseDetailsById {
              gitaVerseById(id: ${widget.verseID}) {
              chapterNumber
              verseNumber
              gitaTranslationsByVerseId(condition: { language: "$language1", authorName: "$auther1" }) {
                nodes {
                  description
                }
              }
            }
          }
          """;
        print('verse Detail Query===>>>--->>>$getVerseDetail');
      });
    });

    String language1 = savedVerseTranslation.language ?? "english";
    String auther1 = savedVerseTranslation.authorName ?? "Swami Sivananda";
    getVerseDetail = """
            query GetVerseDetailsById {
              gitaVerseById(id: ${widget.verseID}) {
              chapterNumber
              verseNumber
              gitaTranslationsByVerseId(condition: { language: "$language1", authorName: "$auther1" }) {
                nodes {
                  description
                }
              }
            }
          }
          """;
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: Query(
        options: QueryOptions(document: gql(getVerseDetail)),
        builder: (
          QueryResult result, {
          Refetch? refetch,
          FetchMore? fetchMore,
        }) {
          if (result.hasException) {
            print("ERROR : ${result.exception.toString()}");
          }
          Map<String, dynamic>? verseDetail = result.data;
          if (verseDetail == null) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                  strokeWidth: 2,
                ),
              ),
            );
          }
          var respose = jsonEncode(verseDetail);
          VerseOTheDayDetailResponseModel verseOTheDayDetailResponseModel =
              verseOTheDayDetailResponseModelFromJson(respose);
          print('VerseDetail : $respose');
          return RichText(
            maxLines: 4,
            text: TextSpan(
              text:
                  '${verseOTheDayDetailResponseModel.gitaVerseById!.chapterNumber ?? 0}.${verseOTheDayDetailResponseModel.gitaVerseById!.verseNumber ?? 0} | ',
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: orangeColor,
                    fontSize: width * 0.037,
                  ),
              children: <TextSpan>[
                TextSpan(
                  text: verseOTheDayDetailResponseModel.gitaVerseById!
                              .gitaTranslationsByVerseId!.nodes!.length >
                          0
                      ? '${verseOTheDayDetailResponseModel.gitaVerseById!.gitaTranslationsByVerseId!.nodes![0].description ?? ''}'
                      : '',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        overflow: TextOverflow.ellipsis,
                        color: whiteColor,
                        fontSize: width * 0.037,
                      ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
