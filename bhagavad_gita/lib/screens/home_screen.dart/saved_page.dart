import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/screens/home_screen.dart/notes_list_screen.dart';
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
                    SizedBox(height: kPadding * 0.7),
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
                    SizedBox(height: kPadding * 0.7),
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
