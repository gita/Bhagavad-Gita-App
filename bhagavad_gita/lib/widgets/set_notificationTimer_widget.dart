import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/localization/demo_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SetNotificationTimerWidget extends StatelessWidget {
  const SetNotificationTimerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: kPadding),
        Container(
          height: 5,
          width: 50,
          decoration: BoxDecoration(
              color: editBoxBorderColor,
              borderRadius: BorderRadius.circular(10)),
        ),
        Container(
          height: 215,
          child: CupertinoDatePicker(
              onDateTimeChanged: (DateTime dateTime) {},
              minimumDate: DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
              ),
              mode: CupertinoDatePickerMode.time,
              minuteInterval: 1),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromRGBO(245, 121, 3, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                child: Expanded(
                  child: Center(
                    child: Text(
                      DemoLocalization.of(context)!
                          .getTranslatedValue('save')
                          .toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: whiteColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
