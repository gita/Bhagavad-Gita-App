import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/models/notes_model.dart';
import 'package:bhagavad_gita/services/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotesVerseKistWidget extends StatefulWidget {
  @override
  _NotesVerseKistWidgetState createState() => _NotesVerseKistWidgetState();
}

class _NotesVerseKistWidgetState extends State<NotesVerseKistWidget> {
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
            itemCount: 10,
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
                              'Verse 10.18',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                showNoteDialog();
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
                          'Dhṛtarāṣṭra said: O Sañjaya, after my sons and the sons of Pāṇḍu assembled in the place of...',
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
                                'Apparently we had reached a great height in the atmosphere, for the sky was a dead black, and the stars had ceased to twinkle. ',
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

  showNoteDialog() {
    return showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.7),
      // transitionDuration: Duration(milliseconds: 700),
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
                          onPressed: () {},
                          child: Text(
                            'Delete',
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
                        SizedBox(width: kDefaultPadding),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Edit',
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
                          onPressed: () {},
                          child: Text(
                            'Go to verse',
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
