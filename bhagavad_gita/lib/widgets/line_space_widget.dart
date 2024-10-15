import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LineSpaceWidget extends StatelessWidget {
  const LineSpaceWidget({
    Key? key,
    required this.imagePath,
    required this.showBorder,
  }) : super(key: key);

  final String imagePath;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(
            color: showBorder
                ? Colors.orange[50] ?? Colors.transparent
                : Colors.transparent,
            width: 5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        width: 140,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(
              color: showBorder ? orangeColor : Colors.transparent, width: 3),
          borderRadius: BorderRadius.circular(11),
        ),
        child: Container(
          width: 100,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(
              color: editBoxBorderColor,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SvgPicture.asset(
            imagePath,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}
