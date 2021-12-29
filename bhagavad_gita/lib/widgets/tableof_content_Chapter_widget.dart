import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/localization/demo_localization.dart';
import 'package:bhagavad_gita/models/chapter_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TableOfContentChapterWidget extends StatelessWidget {
  final Chapter chapter;
  final Function onTap;

  const TableOfContentChapterWidget(
      {Key? key, required this.chapter, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: kDefaultPadding * 0.5,
          ),
          Row(
            children: [
              Text(
                "${DemoLocalization.of(context)!.getTranslatedValue('chapter').toString()} ${chapter.chapterNumber ?? 0}",
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 14),
              ),
              Spacer(),
              Container(
                height: 30,
                width: 30,
                child: Center(
                  child: SvgPicture.asset(!chapter.isExpanded!
                      ? "assets/icons/icon_downsidearrow.svg"
                      : 'assets/icons/icon_upside_arrow.svg'),
                ),
              )
            ],
          ),
          Text(
              "${(Localizations.localeOf(context).languageCode == 'hi') ? (chapter.name ?? "") : chapter.nameTranslated ?? ""}",
              style: Theme.of(context).textTheme.subtitle1),
          SizedBox(height: kDefaultPadding),
          !chapter.isExpanded!
              ? Row(
                  children: [
                    Container(
                      height: 9.33,
                      width: 12,
                      child: SvgPicture.asset(
                          "assets/icons/Icon_menu_bottom.svg",
                          color: textLightGreyColor),
                    ),
                    SizedBox(width: kPadding),
                    Text(
                      "${chapter.versesCount ?? 0} ${DemoLocalization.of(context)!.getTranslatedValue('verses').toString()}",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontSize: 14, color: textLightGreyColor),
                    ),
                  ],
                )
              : Container(),
          SizedBox(
            height: kDefaultPadding * 0.5,
          ),
        ],
      ),
    );
  }
}
