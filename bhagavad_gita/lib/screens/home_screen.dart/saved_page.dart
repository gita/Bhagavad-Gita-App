import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/localization/demo_localization.dart';
import 'package:bhagavad_gita/widgets/notes_list_screen.dart';
import 'package:bhagavad_gita/widgets/bookmark_verseList_widget.dart';
import 'package:flutter/material.dart';

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        _pageChange(isPageIndex = 0);
                      },
                      child: Container(
                        height: kPadding * 6,
                        width: kDefaultPadding * 8,
                        child: Center(
                          child: Text(
                            DemoLocalization.of(context)!
                                .getTranslatedValue('bookMark')
                                .toString(),
                            style:
                                Theme.of(context).textTheme.headline1!.copyWith(
                                      fontSize: 16,
                                      color: isPageIndex == 0
                                          ? orangeColor
                                          : textLightGreyColor,
                                    ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 5,
                      width: 40,
                      decoration: BoxDecoration(
                        color:
                            isPageIndex == 0 ? orangeColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        _pageChange(isPageIndex = 1);
                      },
                      child: Container(
                        height: kPadding * 6,
                        width: kDefaultPadding * 8,
                        child: Center(
                          child: Text(
                            DemoLocalization.of(context)!
                                .getTranslatedValue('notes')
                                .toString(),
                            style:
                                Theme.of(context).textTheme.headline1!.copyWith(
                                      fontSize: 16,
                                      color: isPageIndex == 1
                                          ? orangeColor
                                          : textLightGreyColor,
                                    ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 5,
                      width: 40,
                      decoration: BoxDecoration(
                        color:
                            isPageIndex == 1 ? orangeColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: kDefaultPadding * 2),
            Expanded(
              child: PageView(
                onPageChanged: _pageChange,
                children: [
                  BookmarkVersListWidget(),
                  NotesVerseKistWidget(),
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
}
