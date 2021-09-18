import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/Constant/http_link_string.dart';
import 'package:bhagavad_gita/models/chapter_detail_model.dart';
import 'package:bhagavad_gita/routes/route_names.dart';
import 'package:bhagavad_gita/screens/home_screen.dart/read_more_page.dart';
import 'package:bhagavad_gita/services/navigator_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../locator.dart';

class VerseDetailWidget extends StatelessWidget {
  final NavigationService navigationService = locator<NavigationService>();
  final HttpLink httpLink = HttpLink(strGitaHttpLink);

  VerseDetailWidget({
    Key? key,
    required this.verse,
  }) : super(key: key);

  final GitaVersesByChapterIdNode verse;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // print('Vrese Detail Ritvik');
        navigationService.pushNamed(r_ContinueReading,
            arguments: "${verse.verseNumber ?? 0}");
      },
      child: Column(
        children: [
          SizedBox(
            height: kDefaultPadding,
          ),
          Row(
            children: [
              SvgPicture.asset(
                "assets/icons/icon_verseLogo.svg",
              ),
              SizedBox(width: kPadding),
              Text(
                "Verse ${verse.verseNumber}",
                style: Theme.of(context).textTheme.headline2,
              ),
              Spacer(),
              SvgPicture.asset(
                "assets/icons/icn_arrow_forward.svg",
              ),
            ],
          ),
          SizedBox(height: kPadding),
          Text(
            verse.gitaTranslationsByVerseId!.nodes![0].description!
                .replaceAll("\n", ""),
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: kDefaultPadding,
          ),
          Divider()
        ],
      ),
    );
  }
}
