import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/Constant/string_constant.dart';
import 'package:bhagavad_gita/models/verse_detail_model.dart';
import 'package:bhagavad_gita/routes/route_names.dart';
import 'package:bhagavad_gita/services/navigator_service.dart';
import 'package:bhagavad_gita/services/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            itemBuilder: (BuildContext context, int index) {
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
                              '${StringConstant.strVerse()} ${listLastReadVerse[index].gitaVerseById!.chapterNumber}.${listLastReadVerse[index].gitaVerseById!.verseNumber}',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                showBookMarkDialog(onClickDelete: () async {
                                  await SharedPref.removeVerseFromSaved(
                                      listLastReadVerse[index].verseID!);
                                  getAllSavedVerse();
                                }, onClickGoToVerse: () {
                                  navigationService.pushNamed(r_ContinueReading,
                                      arguments:
                                          "${listLastReadVerse[index].verseID ?? 0}");
                                });
                              },
                              child: Container(
                                height: 20,
                                width: 20,
                                child: Center(
                                  child: SvgPicture.asset(
                                      'assets/icons/Icon_more_setting.svg'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: kDefaultPadding),
                        Text(
                          listLastReadVerse[index]
                                  .gitaVerseById!
                                  .gitaTranslationsByVerseId!
                                  .nodes![0]
                                  .description ??
                              "",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Divider(),
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

  showBookMarkDialog(
      {Function()? onClickDelete, Function()? onClickGoToVerse}) {
    return showGeneralDialog(
      barrierLabel: '',
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.7),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(
                top: kDefaultPadding * 7.5, right: kDefaultPadding),
            child: Container(
              width: 200,
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: kPadding),
                  Row(
                    children: [
                      SizedBox(width: kDefaultPadding),
                      SvgPicture.asset('assets/icons/icon_delete.svg'),
                      SizedBox(width: kDefaultPadding),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          onClickDelete!();
                        },
                        child: Text(
                          StringConstant.strDelete(),
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(color: Colors.red, fontSize: 16),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: kDefaultPadding),
                      SvgPicture.asset('assets/icons/icon_go_to_verse.svg'),
                      SizedBox(width: kDefaultPadding),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          onClickGoToVerse!();
                        },
                        child: Text(
                          StringConstant.strGoToVrese(),
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(color: blackColor, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        );
      },
    );
  }
}
