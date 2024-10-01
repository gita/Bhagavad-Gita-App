import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/localization/demo_localization.dart';
import 'package:bhagavad_gita/models/chapter_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChapterListTileWidget extends StatelessWidget {
  const ChapterListTileWidget({
    Key? key,
    required this.index,
    required this.onTap,
    required this.chapter,
  }) : super(key: key);

  final int index;
  final Function onTap;
  final Chapter chapter;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: kDefaultPadding,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                        color: primaryLightColor,
                        borderRadius: BorderRadius.circular(4.0)),
                    child: Center(
                      child: Text(
                        "${chapter.chapterNumber ?? index}",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(color: primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: kDefaultPadding,
                  ),
                  Expanded(flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (Localizations.localeOf(context).languageCode == 'hi') ? (chapter.name ?? "") : chapter.nameTranslated ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontSize: (Localizations.localeOf(context).languageCode == 'hi') ?
                          18 : 16, color: titleLableColor),
                        ),
                        SizedBox(
                          height: kDefaultPadding * 0.5,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset('assets/icons/icn_list.svg'),
                            SizedBox(
                              width: kDefaultPadding * 0.5,
                            ),
                            Text(
                              '${chapter.versesCount ?? ""} ${DemoLocalization.of(context)!.getTranslatedValue('verses').toString()}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontSize: 14, color: greyScalLableColor),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    child: Column(
                      children: [
                        SvgPicture.asset('assets/icons/icn_arrow_forward.svg'),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: kDefaultPadding,
              ),
              Divider()
            ],
          ),
        ),
      ),
    );
  }
}
