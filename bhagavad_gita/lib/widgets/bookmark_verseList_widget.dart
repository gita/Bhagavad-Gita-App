import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/localization/demo_localization.dart';
import 'package:bhagavad_gita/models/verse_detail_model.dart';
import 'package:bhagavad_gita/services/navigator_service.dart';
import 'package:bhagavad_gita/services/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:popover/popover.dart';
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
                              '${DemoLocalization.of(context)!.getTranslatedValue('verse').toString()} ${listLastReadVerse[index].gitaVerseById!.chapterNumber}.${listLastReadVerse[index].gitaVerseById!.verseNumber}',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                print('Helloooo Ritvik');
                                showPopover(
                                  context: context,
                                  bodyBuilder: (context) => const ListItems(),
                                  onPop: () => print('Popover was popped!'),
                                  direction: PopoverDirection.top,
                                  width: 200,
                                  height: 400,
                                  arrowHeight: 15,
                                  arrowWidth: 30,
                                );

                                // showPopover(
                                //   context: context,
                                //   transitionDuration:
                                //       const Duration(milliseconds: 150),
                                //   bodyBuilder: (context) => Container(
                                //     height: 100,
                                //     width: 100,
                                //     color: orangeColor,
                                //     child: Column(
                                //       children: [],
                                //     ),
                                //   ),
                                //   onPop: () => print('Popover was popped!'),
                                //   direction: PopoverDirection.top,
                                //   width: 200,
                                //   height: 400,
                                //   arrowHeight: 15,
                                //   arrowWidth: 30,
                                // );
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
                        SizedBox(height: kPadding * 2),
                        Text(
                          listLastReadVerse[index]
                                  .gitaVerseById!
                                  .gitaTranslationsByVerseId!
                                  .nodes![0]
                                  .description ??
                              '',
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

  /* showBookMarkDialog(
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
                          DemoLocalization.of(context)!
                              .getTranslatedValue('delete')
                              .toString(),
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
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        );
      },
    );
  }*/
}

class ListItems extends StatelessWidget {
  const ListItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                height: 50,
                color: Colors.amber[100],
                child: const Center(child: Text('Entry A')),
              ),
            ),
            const Divider(),
            Container(
              height: 50,
              color: Colors.amber[200],
              child: const Center(child: Text('Entry B')),
            ),
            const Divider(),
            Container(
              height: 50,
              color: Colors.amber[300],
              child: const Center(child: Text('Entry C')),
            ),
          ],
        ),
      ),
    );
  }
}
