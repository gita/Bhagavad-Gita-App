import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/http_link_string.dart';
import 'package:bhagavad_gita/localization/demo_localization.dart';
import 'package:bhagavad_gita/screens/home_screen.dart/about_gita_page.dart';
import 'package:bhagavad_gita/screens/home_screen.dart/home_screen.dart';
import 'package:bhagavad_gita/screens/home_screen.dart/quotes_page.dart';
import 'package:bhagavad_gita/screens/home_screen.dart/saved_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class TabScreenController extends StatefulWidget {
  const TabScreenController({Key? key}) : super(key: key);

  @override
  _TabScreenControllerState createState() => _TabScreenControllerState();
}

class _TabScreenControllerState extends State<TabScreenController>
    with SingleTickerProviderStateMixin {
  int seletecTab = 0;
  late TabController tabController;
  final HttpLink httpLink = HttpLink(strGitaHttpLink);
  late ValueNotifier<GraphQLClient> client;

  @override
  void initState() {
    super.initState();
    client = ValueNotifier<GraphQLClient>(
        GraphQLClient(link: httpLink, cache: GraphQLCache()));
    tabController = TabController(length: 4, vsync: this);
    tabController.index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: whiteColor,
            type: BottomNavigationBarType.fixed,
            unselectedLabelStyle: TextStyle(
              fontSize: 12,
              color: textLightGreyColor,
              fontWeight: FontWeight.w500,
            ),
            selectedLabelStyle: TextStyle(
              fontSize: 12,
              color: blackColor,
              fontWeight: FontWeight.w600,
            ),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  width: 30,
                  height: 25,
                  child: SvgPicture.asset(
                    tabController.index == 0
                        ? 'assets/icons/icn_home_selected.svg'
                        : 'assets/icons/icn_home.svg',
                  ),
                ),
                label: DemoLocalization.of(context)!
                    .getTranslatedValue('tabBar_Home')
                    .toString(),
              ),
              BottomNavigationBarItem(
                icon: Container(
                  width: 30,
                  height: 25,
                  child: SvgPicture.asset(tabController.index == 1
                      ? 'assets/icons/icn_saved_selected.svg'
                      : 'assets/icons/icn_saved.svg'),
                ),
                label: DemoLocalization.of(context)!
                    .getTranslatedValue('tabBar_Saved')
                    .toString(),
              ),
              BottomNavigationBarItem(
                icon: Container(
                  width: 30,
                  height: 25,
                  child: SvgPicture.asset(tabController.index == 2
                      ? 'assets/icons/icon_quotes_selected.svg'
                      : 'assets/icons/icon_quotes.svg'),
                ),
                label: DemoLocalization.of(context)!
                    .getTranslatedValue('tabBar_Quotes')
                    .toString(),
              ),
              BottomNavigationBarItem(
                icon: Container(
                  width: 30,
                  height: 25,
                  child: Padding(
                    padding:
                        EdgeInsets.all(tabController.index == 3 ? 0.0 : 2.0),
                    child: SvgPicture.asset(tabController.index == 3
                        ? 'assets/icons/icn_about_selected.svg'
                        : 'assets/icons/icn_about.svg'),
                  ),
                ),
                label: DemoLocalization.of(context)!
                    .getTranslatedValue('tabBar_About')
                    .toString(),
              )
            ],
            currentIndex: tabController.index,
            selectedItemColor: blackColor,
            unselectedItemColor: textLightGreyColor,
            onTap: (int index) {
              if (tabController.index != index) {
                setState(() {
                  tabController.index = index;
                });
              }
            },
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
      ),
      client: client,
    );
  }
}
