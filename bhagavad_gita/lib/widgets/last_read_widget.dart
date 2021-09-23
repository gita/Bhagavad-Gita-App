import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/Constant/string_constant.dart';
import 'package:flutter/material.dart';

class LastReadWidget extends StatelessWidget {
  const LastReadWidget({
    Key? key,
  }) : super(key: key);

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
                StringConstant.strLastRead,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: greyScalBodyColor, fontSize: 20),
              ),
              Spacer(),
              Text(
                StringConstant.strVerseNo,
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
            'Dhṛtarāṣṭra said: O Sañjaya, after my sons and the sons of Pāṇḍu assembled in the place of pilgrimage at Kurukṣetra...',
            maxLines: 4,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: greyScalLableColor),
          ),
          SizedBox(
            height: kDefaultPadding,
          ),
          InkWell(
            onTap: () {},
            child: Container(
              height: 30,
              child: Text(
                'CONTINUE READING',
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: primaryColor, fontSize: width * 0.037),
              ),
            ),
          )
        ],
      ),
    );
  }
}
