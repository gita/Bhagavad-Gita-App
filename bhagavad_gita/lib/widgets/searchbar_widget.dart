import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/Constant/string_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(left: kPadding * 2.7, right: kPadding * 2.7),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: kPadding,
          ),
          child: TextField(
            decoration: InputDecoration(
              icon: Icon(
                Icons.search,
                color: blackColor,
              ),
              hintText: StringConstant.strSearchLanguage,
              hintStyle: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: textLightGreyColor),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}