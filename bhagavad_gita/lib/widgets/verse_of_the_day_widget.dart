import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/Constant/string_constant.dart';
import 'package:flutter/material.dart';

class VerseOfTheDayWidget extends StatelessWidget {
  const VerseOfTheDayWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding * 0.5, vertical: kDefaultPadding * 0.5),
      child: Container(
        height: (width - kDefaultPadding) * 0.526,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/home_verse_of_the_day.png'),
                fit: BoxFit.fill),
            borderRadius: BorderRadius.circular(kDefaultCornerRadius)),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/black_layer.png'),
                      fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(kDefaultCornerRadius)),
            ),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    StringConstant.strVerseOfTheDay,
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: whiteColor, fontSize: width * 0.037),
                  ),
                  Spacer(),
                  VerseOfTheDayTextWidget(),
                  Spacer(),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'READ MORE',
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: whiteColor, fontSize: width * 0.037),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class VerseOfTheDayTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 4,
      text: TextSpan(
        text: '10.18 | ',
        style: Theme.of(context)
            .textTheme
            .headline2!
            .copyWith(color: primaryColor, fontSize: width * 0.037),
        children: <TextSpan>[
          TextSpan(
              text:
                  'Intelligence, wisdom, non-delusion, forgiveness, truth, control of the external organs, control of the internal organs',
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: whiteColor, fontSize: width * 0.037)),
        ],
      ),
    );
  }
}
