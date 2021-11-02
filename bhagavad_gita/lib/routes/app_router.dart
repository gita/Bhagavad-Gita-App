// ignore_for_file: unused_element

import 'package:bhagavad_gita/models/notes_model.dart';
import 'package:bhagavad_gita/routes/route_names.dart';
import 'package:bhagavad_gita/screens/chapter_detail/chapter_detail_screen.dart';
import 'package:bhagavad_gita/screens/chapter_detail/chapter_tableview.dart';
import 'package:bhagavad_gita/screens/home_screen.dart/about_gita_page.dart';
import 'package:bhagavad_gita/screens/home_screen.dart/home_screen.dart';
import 'package:bhagavad_gita/screens/home_screen.dart/quotes_page.dart';
import 'package:bhagavad_gita/screens/home_screen.dart/saved_page.dart';
import 'package:bhagavad_gita/screens/home_screen.dart/spalsh_screen.dart';
import 'package:bhagavad_gita/screens/on_board_screen/OnBoardingScreen_one.dart';
import 'package:bhagavad_gita/screens/setting_screens/open_setting_screen.dart';
import 'package:bhagavad_gita/screens/setting_screens/verse_commentary_screen.dart';
import 'package:bhagavad_gita/screens/setting_screens/verse_translation_screen.dart';
import 'package:bhagavad_gita/screens/tabbar/tabbar_controller.dart';
import 'package:bhagavad_gita/widgets/add_notes_widget.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case r_Onboarding:
        return _getPageRoute(
          routeName: settings.name!,
          viewToShow: OnbordingScreen(),
        );
      case r_Tabbar:
        return _getPageRoute(
          routeName: settings.name!,
          viewToShow: TabScreenController(),
        );
      case r_HomePage:
        return _getPageRoute(
          routeName: settings.name!,
          viewToShow: HomeScreen(),
        );
      case r_ChapterDetail:
        int chapterNumber = settings.arguments as int;
        return _getPageRoute(
          routeName: settings.name!,
          viewToShow: ChapterDetailScreen(
            chapterNumber: chapterNumber,
          ),
        );
      case r_ChapterTableView:
        return _getPageRoute(
          routeName: settings.name!,
          viewToShow: ChapterTableViewScreen(),
        );
      case r_QuotesPage:
        return _getPageRoute(
          routeName: settings.name!,
          viewToShow: QuotesScreen(),
        );
      case r_AboutGitaPage:
        return _getPageRoute(
          routeName: settings.name!,
          viewToShow: AboutGitaScreen(),
        );
      case r_SavedPage:
        return _getPageRoute(
          routeName: settings.name!,
          viewToShow: SavedPage(),
        );
      case r_Setting:
        return _getPageRoute(
          routeName: settings.name!,
          viewToShow: SettingScreen(
            refresh: () {},
          ),
        );
      case r_SpalshScreen:
        return _getPageRoute(
          routeName: settings.name!,
          viewToShow: SplashScreen(),
        );
      case r_AddNote:
        VerseNotes notes = settings.arguments as VerseNotes;
        return _getPageRoute(
          routeName: settings.name!,
          viewToShow: AddNotesWidget(
            verseNotes: notes,
          ),
        );
      case r_VerseTranslation:
        return _getPageRoute(
          routeName: settings.name!,
          viewToShow: VerseTranslationScreen(),
        );
      case r_VerseCommentary:
        return _getPageRoute(
          routeName: settings.name!,
          viewToShow: VerseCommentaryScreen(),
        );
      default:
        print('Route Name : ${settings.name}');
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined yet'),
            ),
          ),
        );
    }
  }
}

PageRoute _getPageRoute(
    {required String routeName, required Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}

PageRoute _getPageRouteWithAnimation(Widget child, RouteSettings settings) {
  return _FadeRoute(child: child, routeName: settings.name!);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;

  _FadeRoute({required this.child, required this.routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
