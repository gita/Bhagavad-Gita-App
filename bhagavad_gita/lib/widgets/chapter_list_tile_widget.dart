import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/Constant/string_constant.dart';
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
                            .headline2!
                            .copyWith(color: primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: kDefaultPadding,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chapter.nameTranslated ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(fontSize: 16, color: titleLableColor),
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
                            '${chapter.versesCount ?? ""} ${StringConstant.strVerse}',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                    fontSize: 14, color: greyScalLableColor),
                          ),
                        ],
                      )
                    ],
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
