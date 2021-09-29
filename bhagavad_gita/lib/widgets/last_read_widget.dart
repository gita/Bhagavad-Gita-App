import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/Constant/string_constant.dart';
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
                StringConstant.strLastRead(),
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: greyScalBodyColor, fontSize: 20),
              ),
              Spacer(),
              Text(
                "${StringConstant.strVerse()}  ${lastReadVerse.gitaVerseById!.chapterNumber ?? 0}.${lastReadVerse.gitaVerseById!.verseNumber}",
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: greyScalLableColor, fontSize: 14),
              ),
            ],
          ),
          SizedBox(
            height: kDefaultPadding,
          ),
          Text(
            lastReadVerse.gitaVerseById!.gitaTranslationsByVerseId!.nodes![0]
                .description!,
            maxLines: 4,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: greyScalLableColor),
          ),
          SizedBox(height: kPadding),
          TextButton(
            onPressed: () {
              onButtonTap();
            },
            child: Text(
              StringConstant.strContinueReading(),
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: primaryColor, fontSize: width * 0.037),
            ),
          )
        ],
      ),
    );
  }
}
