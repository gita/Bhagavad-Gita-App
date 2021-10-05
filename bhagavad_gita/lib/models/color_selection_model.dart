import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:flutter/material.dart';

class FormatingColor {
  final String id;
  final Color bgColor;
  final Color textColor;
  final Color style1;
  final Color naviagationIconColor;

  FormatingColor(this.id, this.bgColor, this.textColor, this.style1,
      this.naviagationIconColor);
}

FormatingColor whiteFormatingColor =
    FormatingColor("1", Colors.white, appBarTitleColor, orangeColor, Colors.black);
FormatingColor orangeFormatingColor =
    FormatingColor("2", lightOrangeColor, appBarTitleColor, primaryColor, Colors.black);
FormatingColor blackFormatingColor =
    FormatingColor("3", Colors.black, whiteColor, darkOrangeColor, whiteColor);
