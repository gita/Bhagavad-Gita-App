import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/Constant/string_constant.dart';
import 'package:bhagavad_gita/screens/home_screen.dart/about_gita_page.dart';
import 'package:bhagavad_gita/screens/home_screen.dart/home_screen.dart';
import 'package:bhagavad_gita/screens/home_screen.dart/quotes_page.dart';
import 'package:bhagavad_gita/screens/home_screen.dart/saved_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TabScreenController extends StatefulWidget {
  const TabScreenController({Key? key}) : super(key: key);

  @override
  _TabScreenControllerState createState() => _TabScreenControllerState();
}

class _TabScreenControllerState extends State<TabScreenController>
    with SingleTickerProviderStateMixin {
  int seletecTab = 0;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    tabController.index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: menu(),
        ),
        body: TabBarView(
          controller: tabController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            HomeScreen(),
            SavedPage(),
            QuotesScreen(),
            AboutGitaScreen()
          ],
        ),
      ),
    );
  }

  Widget menu() {
    return SafeArea(
      child: Container(
        height: 56,
        child: TabBar(
          onTap: (int index) {
            setState(() {
              tabController.index = index;
            });
          },
          labelColor: Colors.black,
          unselectedLabelColor: textLightGreyColor,
          indicatorWeight: 1,
          indicatorPadding: EdgeInsets.all(5.0),
          indicatorColor: Colors.transparent,
          tabs: [
            Tab(
              child: Column(
                children: [
                  Container(
                      width: 30,
                      height: 30,
                      child: SvgPicture.asset(tabController.index == 0
                          ? 'assets/icons/icn_home_selected.svg'
                          : 'assets/icons/icn_home.svg')),
                  SizedBox(
                    height: kDefaultPadding * 0.2,
                  ),
                  Text(StringConstant.strTabbarTitleHome,
                      style: tabController.index == 0
                          ? TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            )
                          : TextStyle(
                              fontSize: 10,
                              color: textLightGreyColor,
                              fontWeight: FontWeight.w500,
                            )),
                ],
              ),
            ),
            Tab(
              child: Column(
                children: [
                  Container(
                      width: 30,
                      height: 30,
                      child: SvgPicture.asset(tabController.index == 1
                          ? 'assets/icons/icn_saved_selected.svg'
                          : 'assets/icons/icn_saved.svg')),
                  SizedBox(
                    height: kDefaultPadding * 0.2,
                  ),
                  Text(StringConstant.strTabbarTitleSaved,
                      style: tabController.index == 1
                          ? TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            )
                          : TextStyle(
                              fontSize: 10,
                              color: textLightGreyColor,
                              fontWeight: FontWeight.w500,
                            )),
                ],
              ),
            ),
            Tab(
              child: Column(
                children: [
                  Container(
                      width: 30,
                      height: 30,
                      child: SvgPicture.asset(tabController.index == 2
                          ? 'assets/icons/icon_quotes_selected.svg'
                          : 'assets/icons/icon_quotes.svg')),
                  SizedBox(
                    height: kDefaultPadding * 0.2,
                  ),
                  Text(StringConstant.strTabbarTitleQuotes,
                      style: tabController.index == 2
                          ? TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            )
                          : TextStyle(
                              fontSize: 10,
                              color: textLightGreyColor,
                              fontWeight: FontWeight.w500,
                            )),
                ],
              ),
            ),
            Tab(
              child: Column(
                children: [
                  Container(
                      width: 30,
                      height: 30,
                      child: Padding(
                        padding: EdgeInsets.all(
                            tabController.index == 3 ? 0.0 : 2.0),
                        child: SvgPicture.asset(tabController.index == 3
                            ? 'assets/icons/icn_about_selected.svg'
                            : 'assets/icons/icn_about.svg'),
                      )),
                  SizedBox(
                    height: kDefaultPadding * 0.2,
                  ),
                  Text(StringConstant.strTabbarTitleAbout,
                      style: tabController.index == 3
                          ? TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            )
                          : TextStyle(
                              fontSize: 10,
                              color: textLightGreyColor,
                              fontWeight: FontWeight.w500,
                            )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
