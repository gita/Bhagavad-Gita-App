import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/localization/demo_localization.dart';
import 'package:bhagavad_gita/models/verse_detail_model.dart';
import 'package:flutter/material.dart';

class LastReadWidget extends StatelessWidget {
  const LastReadWidget({
    Key? key,
    required this.lastReadVerse,
    required this.onButtonTap,
  }) : super(key: key);

  final LastReadVerse lastReadVerse;
  final Function onButtonTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                DemoLocalization.of(context)!
                    .getTranslatedValue('lastRead')
                    .toString(),
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(color: greyScalBodyColor, fontSize: 20),
              ),
              Spacer(),
              Text(
                "${DemoLocalization.of(context)!.getTranslatedValue('VERSE').toString()}  ${lastReadVerse.gitaVerseById!.chapterNumber ?? 0}.${lastReadVerse.gitaVerseById!.verseNumber}",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: greyScalLableColor, fontSize: 14),
              ),
            ],
          ),
          SizedBox(
            height: kDefaultPadding,
          ),
          Text(
            lastReadVerse.gitaVerseById!.gitaTranslationsByVerseId!.nodes!
                        .length >
                    0
                ? lastReadVerse.gitaVerseById!.gitaTranslationsByVerseId!
                    .nodes![0].description!
                : "---",
            maxLines: 4,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: greyScalLableColor,
                fontSize: (Localizations.localeOf(context).languageCode == 'hi')
                    ? 18
                    : 16),
          ),
          InkWell(
            onTap: () {
              onButtonTap();
            },
            child: Padding(
              padding: EdgeInsets.only(top: kPadding, bottom: kPadding),
              child: Text(
                DemoLocalization.of(context)!
                    .getTranslatedValue('continueReading')
                    .toString(),
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: primaryColor, fontSize: width * 0.037),
              ),
            ),
          )
        ],
      ),
    );
  }
}
