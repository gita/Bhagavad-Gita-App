import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/localization/demo_localization.dart';
import 'package:bhagavad_gita/models/notes_model.dart';
import 'package:bhagavad_gita/routes/route_names.dart';
import 'package:bhagavad_gita/services/navigator_service.dart';
import 'package:bhagavad_gita/services/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../locator.dart';

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
                            InkWell(
                              onTap: () {
                                showNoteDialog(onClickDelete: () async {
                                  await SharedPref.removeVerseNotesFromSaved(
                                      writeNotes[index].verseID!);
                                  getNoteVerse();
                                }, onClickGoToEdit: () {
                                  navigationService.pushNamed(r_AddNote,
                                      arguments: writeNotes[index]);
                                }, onClickGoToVerse: () {
                                  navigationService.pushNamed(r_ContinueReading,
                                      arguments:
                                          "${writeNotes[index].verseID ?? 0}");
                                });
                              },
                              child: Container(
                                height: kPadding * 2,
                                width: kPadding * 2,
                                child: Center(
                                  child: SvgPicture.asset(
                                      'assets/icons/Icon_more_setting.svg'),
                                ),
                              ),
                            )
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
                              width: 290,
                              child: Text(
                                '${writeNotes[index].verseNote}',
                                maxLines: 5,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            )
                          ],
                        ),
                        Divider(height: kDefaultPadding * 2)
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

  showNoteDialog(
      {Function()? onClickDelete,
      Function()? onClickGoToVerse,
      Function()? onClickGoToEdit}) {
    return showGeneralDialog(
      barrierLabel: "",
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
              height: 160,
              child: Center(
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
                            DemoLocalization.of(context)!
                                .getTranslatedValue('delete')
                                .toString(),
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(color: Colors.red, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: kDefaultPadding),
                        SvgPicture.asset(
                          'assets/icons/Icon_writenote_pen.svg',
                          height: kPadding * 1.8,
                          width: kPadding * 1.8,
                        ),
                        SizedBox(width: kPadding),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            onClickGoToEdit!();
                          },
                          child: Text(
                            DemoLocalization.of(context)!
                                .getTranslatedValue('edit')
                                .toString(),
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(color: blackColor, fontSize: 16),
                          ),
                        ),
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
                            DemoLocalization.of(context)!
                                .getTranslatedValue('goToVerse')
                                .toString(),
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
