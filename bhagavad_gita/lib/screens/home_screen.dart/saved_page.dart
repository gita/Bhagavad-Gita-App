import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SavedPage extends StatefulWidget {
  @override
  _SavedPageState createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  bool isShowDialoug = true;
  final PageController controller = PageController();
  var isPageIndex = 0;
  void _pageChange(int index) {
    setState(
      () {
        isPageIndex = index;
        controller.animateToPage(index,
            duration: Duration(milliseconds: 500), curve: Curves.ease);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: kDefaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _pageChange(isPageIndex - 1);
                          isPageIndex = isPageIndex - 1;
                        });
                      },
                      child: Text(
                        'Bookmarks',
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontSize: 16,
                              color: isPageIndex == 0
                                  ? orangeColor
                                  : textLightGreyColor,
                            ),
                      ),
                    ),
                    SizedBox(height: kPadding * 0.5),
                    isPageIndex == 0
                        ? Container(
                            height: 5,
                            width: 40,
                            decoration: BoxDecoration(
                              color: orangeColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          )
                        : Container(
                            height: 5,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          )
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _pageChange(isPageIndex + 1);
                          isPageIndex = isPageIndex - 1;
                        });
                      },
                      child: Text(
                        'Notes',
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontSize: 16,
                              color: isPageIndex == 1
                                  ? orangeColor
                                  : textLightGreyColor,
                            ),
                      ),
                    ),
                    SizedBox(height: kPadding * 0.5),
                    isPageIndex == 1
                        ? Container(
                            height: 5,
                            width: 40,
                            decoration: BoxDecoration(
                              color: orangeColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          )
                        : Container(
                            height: 5,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          )
                  ],
                ),
              ],
            ),
            SizedBox(height: kDefaultPadding * 2),
            Expanded(
              child: PageView(
                onPageChanged: _pageChange,
                children: [
                  bookMarkWidget(),
                  notesWidget(),
                ],
                controller: controller,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column notesWidget() {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
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

  Future<Object?> showNoteDialog() {
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

  Future<Object?> showBookMarkDialog() {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
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
                        onPressed: () {},
                        child: Text(
                          'Delete',
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

  Column bookMarkWidget() {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
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
                                showBookMarkDialog();
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
                          'Dhṛtarāṣṭra said: O Sañjaya, after my sons and the sons of Pāṇḍu assembled in the place of pilgrimage at Kurukṣetra, desiring to fight, what did they do?',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Divider(height: kDefaultPadding * 2),
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
