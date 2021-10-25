import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/Constant/http_link_string.dart';
import 'package:bhagavad_gita/localization/demo_localization.dart';
import 'package:bhagavad_gita/models/chapter_detail_model.dart';
import 'package:bhagavad_gita/models/color_selection_model.dart';
import 'package:bhagavad_gita/screens/home_screen.dart/read_more_page.dart';
import 'package:bhagavad_gita/services/navigator_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../locator.dart';

class VerseDetailWidget extends StatefulWidget {
  VerseDetailWidget({
    Key? key,
    required this.verse,
    required this.formatingColor,
    required this.lineSpacing,
    required this.fontSize,
    required this.fontFamily, required this.refreshEditing,
  }) : super(key: key);

  final GitaVersesByChapterIdNode verse;
  final FormatingColor formatingColor;
  final double lineSpacing;
  final double fontSize;
  final String fontFamily;
  final Function refreshEditing;

  @override
  State<VerseDetailWidget> createState() => _VerseDetailWidgetState();
}

class _VerseDetailWidgetState extends State<VerseDetailWidget> {
  final NavigationService navigationService = locator<NavigationService>();
  final HttpLink httpLink = HttpLink(strGitaHttpLink);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContinueReading(
                verseID: widget.verse.gitaTranslationsByVerseId!.nodes!.length >
                        0
                    ? "${widget.verse.gitaTranslationsByVerseId!.nodes![0].verseId ?? 0}"
                    : "0"),
          ),
        );
        widget.refreshEditing();
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
                "${DemoLocalization.of(context)!.getTranslatedValue('verse').toString()} ${widget.verse.verseNumber}",
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontFamily: widget.fontFamily,
                      fontSize: widget.fontSize,
                      height: widget.lineSpacing,
                      color: widget.formatingColor.naviagationIconColor,
                    ),
              ),
              Spacer(),
              SvgPicture.asset(
                "assets/icons/icn_arrow_forward.svg",
                color: widget.formatingColor.naviagationIconColor,
              ),
            ],
          ),
          SizedBox(height: kPadding),
          Text(
            widget.verse.gitaTranslationsByVerseId!.nodes!.length > 0
                ? widget.verse.gitaTranslationsByVerseId!.nodes![0].description!
                    .replaceAll("\n", "")
                : "---".replaceAll("\n", ""),
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontFamily: widget.fontFamily,
                  fontSize: widget.fontSize,
                  height: widget.lineSpacing,
                  color: widget.formatingColor.naviagationIconColor,
                ),
          ),
          SizedBox(
            height: kDefaultPadding,
          ),
          Divider(color: widget.formatingColor.naviagationIconColor)
        ],
      ),
    );
  }
}
