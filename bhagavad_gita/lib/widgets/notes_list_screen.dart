import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/localization/demo_localization.dart';
import 'package:bhagavad_gita/models/notes_model.dart';
import 'package:bhagavad_gita/routes/route_names.dart';
import 'package:bhagavad_gita/services/navigator_service.dart';
import 'package:bhagavad_gita/services/shared_preferences.dart';
import 'package:bhagavad_gita/widgets/add_notes_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../locator.dart';

class NotesVerseKistWidget extends StatefulWidget {
  @override
  _NotesVerseKistWidgetState createState() => _NotesVerseKistWidgetState();
}

class _NotesVerseKistWidgetState extends State<NotesVerseKistWidget> {
  final NavigationService navigationService = locator<NavigationService>();
  List<VerseNotes> writeNotes = [];
  @override
  void initState() {
    super.initState();
    getNoteVerse();
  }

  getNoteVerse() {
    Future.delayed(Duration(microseconds: 200), () async {
      var result = await SharedPref.getAllSavedVerseNotes();
      setState(() {
        writeNotes = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size.height;
    MediaQuery.of(context).size.width;
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: writeNotes.length,
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
                              '${DemoLocalization.of(context)!.getTranslatedValue('verse').toString()} ${writeNotes[index].gitaVerseById!.chapterNumber}.${writeNotes[index].gitaVerseById!.verseNumber}',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            Spacer(),
                            PopupMenuButton(
                              itemBuilder: (BuildContext context) {
                                return List.generate(3, (indexNotes) {
                                  if (indexNotes == 0) {
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
                                        await SharedPref
                                            .removeVerseNotesFromSaved(
                                                writeNotes[index].verseID!);
                                        getNoteVerse();
                                      },
                                    );
                                  } else if (indexNotes == 1) {
                                    return PopupMenuItem(
                                      padding: EdgeInsets.all(0),
                                      child: Row(
                                        children: [
                                          SizedBox(width: kDefaultPadding),
                                          SvgPicture.asset(
                                              'assets/icons/Icon_writenote_pen.svg'),
                                          SizedBox(width: kDefaultPadding),
                                          Text(
                                            DemoLocalization.of(context)!
                                                .getTranslatedValue('edit')
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
                                            Duration(milliseconds: 200),
                                            () async {
                                          bool temp = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AddNotesWidget(
                                                verseNotes: writeNotes[index],
                                              ),
                                            ),
                                          );
                                          if (temp) {
                                            getNoteVerse();
                                          }
                                        });
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
                                          navigationService.pushNamed(
                                              r_ContinueReading,
                                              arguments:
                                                  "${writeNotes[index].verseID ?? 0}");
                                        });
                                      },
                                    );
                                  }
                                });
                              },
                              child: Container(
                                height: kPadding * 3,
                                width: kPadding * 3,
                                child: Center(
                                  child: SvgPicture.asset(
                                      'assets/icons/Icon_more_setting.svg'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: kPadding * 1.5),
                        Text(
                          writeNotes[index]
                                  .gitaVerseById!
                                  .gitaTranslationsByVerseId!
                                  .nodes![0]
                                  .description ??
                              "",
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: textLightGreyColor),
                        ),
                        SizedBox(height: kPadding * 1.5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: SvgPicture.asset(
                                  'assets/icons/Icon_writenote_pen.svg'),
                            ),
                            SizedBox(width: kPadding),
                            Container(
                              width: 280,
                              child: Text(
                                '${writeNotes[index].verseNote}',
                                maxLines: 5,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            )
                          ],
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
