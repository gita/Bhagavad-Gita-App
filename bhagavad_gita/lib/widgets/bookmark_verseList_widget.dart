import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/localization/demo_localization.dart';
import 'package:bhagavad_gita/models/verse_detail_model.dart';
import 'package:bhagavad_gita/screens/home_screen.dart/read_more_page.dart';
import 'package:bhagavad_gita/services/navigator_service.dart';
import 'package:bhagavad_gita/services/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import '../locator.dart';

class BookmarkVersListWidget extends StatefulWidget {
  const BookmarkVersListWidget({Key? key}) : super(key: key);

  @override
  State<BookmarkVersListWidget> createState() => _BookmarkVersListWidgetState();
}

class _BookmarkVersListWidgetState extends State<BookmarkVersListWidget> {
  final NavigationService navigationService = locator<NavigationService>();
  List<LastReadVerse> listLastReadVerse = [];

  @override
  void initState() {
    super.initState();
    getAllSavedVerse();
  }

  getAllSavedVerse() {
    Future.delayed(Duration(milliseconds: 200), () async {
      var result = await SharedPref.getAllSaveBookmarkVerse();
      setState(() {
        listLastReadVerse = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: listLastReadVerse.length,
            itemBuilder: (BuildContext context, int indexVerse) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/icons/icon_verseLogo.svg'),
                            SizedBox(width: kPadding),
                            Text(
                              '${DemoLocalization.of(context)!.getTranslatedValue('verse').toString()} ${listLastReadVerse[indexVerse].gitaVerseById!.chapterNumber}.${listLastReadVerse[indexVerse].gitaVerseById!.verseNumber}',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            Spacer(),
                            PopupMenuButton(
                              itemBuilder: (BuildContext context) {
                                return List.generate(2, (index) {
                                  if (index == 0) {
                                    return PopupMenuItem(
                                      padding: EdgeInsets.all(0),
                                      child: Row(
                                        children: [
                                          SizedBox(width: kDefaultPadding),
                                          SvgPicture.asset(
                                              'assets/icons/icon_delete_.svg'),
                                          SizedBox(width: kDefaultPadding),
                                          Text(
                                            DemoLocalization.of(context)!
                                                .getTranslatedValue('delete')
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2!
                                                .copyWith(
                                                    color: Colors.red,
                                                    fontSize: 16),
                                          )
                                        ],
                                      ),
                                      onTap: () async {
                                        await SharedPref.removeVerseFromSaved(
                                            listLastReadVerse[indexVerse]
                                                .verseID!);
                                        getAllSavedVerse();
                                      },
                                    );
                                  } else {
                                    return PopupMenuItem(
                                      padding: EdgeInsets.all(0),
                                      child: Row(
                                        children: [
                                          SizedBox(width: kDefaultPadding),
                                          SvgPicture.asset(
                                              'assets/icons/icon_go_to_verse.svg'),
                                          SizedBox(width: kDefaultPadding),
                                          Text(
                                            DemoLocalization.of(context)!
                                                .getTranslatedValue('goToVerse')
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2!
                                                .copyWith(
                                                    color: blackColor,
                                                    fontSize: 16),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        Future.delayed(
                                            Duration(milliseconds: 200), () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ContinueReading(
                                                verseID:
                                                    "${listLastReadVerse[indexVerse].verseID ?? 0}",
                                              ),
                                            ),
                                          );
                                        });
                                      },
                                    );
                                  }
                                });
                              },
                              child: Container(
                                height: kPadding * 3,
                                width: kPadding * 3,
                                color: Colors.transparent,
                                child: Center(
                                  child: SvgPicture.asset(
                                      'assets/icons/Icon_more_setting.svg'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: kPadding * 2),
                        Text(
                          listLastReadVerse[indexVerse]
                                  .gitaVerseById!
                                  .gitaTranslationsByVerseId!
                                  .nodes![0]
                                  .description ??
                              ''.replaceAll("\n", ""),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Divider()
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
