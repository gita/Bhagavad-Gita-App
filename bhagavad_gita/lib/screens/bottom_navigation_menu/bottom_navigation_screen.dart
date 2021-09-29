import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/Constant/string_constant.dart';
import 'package:bhagavad_gita/services/navigator_service.dart';
import 'package:bhagavad_gita/widgets/line_space_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../locator.dart';
import 'font_family_screen.dart';

class BottomNavigationMenu extends StatefulWidget {
  const BottomNavigationMenu(
      {Key? key, required this.lineSpacing, required this.initialLineSpacing})
      : super(key: key);

  @override
  _BottomNavigationMenuState createState() => _BottomNavigationMenuState();
  final Function(double) lineSpacing;
  final double initialLineSpacing;
}

class _BottomNavigationMenuState extends State<BottomNavigationMenu> {
  final NavigationService navigationService = locator<NavigationService>();

  final int colorMode = 0;

  double selectedLineSpacing = 1.5;
  @override
  void initState() {
    super.initState();
    selectedLineSpacing = widget.initialLineSpacing;
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: 29),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                StringConstant.strFontSize(),
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(height: 1.5, color: greyScalBodyColor),
              ),
              SizedBox(width: 175),
              Text(
                StringConstant.strFontFamily(),
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(height: 1.5, color: greyScalBodyColor),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 76,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: editBoxBorderColor,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/image_aa_pluse.svg',
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: 76,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: editBoxBorderColor, style: BorderStyle.solid),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/image_aa_min.svg',
                    ),
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    InkWell(
                      onTap: () => _onPressedInter(context),
                      child: Container(
                        height: 40,
                        width: 144,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: editBoxBorderColor,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            StringConstant.strInter(),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(fontSize: 18, color: titleLableColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringConstant.strSpacing(),
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(height: 1.5, color: greyScalBodyColor),
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedLineSpacing = 2.5;
                        });
                        widget.lineSpacing(2.5);
                      },
                      child: LineSpaceWidget(
                          imagePath: 'assets/icons/image_spacing_one.svg',
                          showBorder:
                              selectedLineSpacing == 2.5 ? true : false),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedLineSpacing = 1.5;
                        });
                        widget.lineSpacing(1.5);
                      },
                      child: LineSpaceWidget(
                          imagePath: 'assets/icons/image_spacing_two.svg',
                          showBorder:
                              selectedLineSpacing == 1.5 ? true : false),
                    ),
                  ),
                  SizedBox(width: 20),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedLineSpacing = 1.0;
                        });
                        widget.lineSpacing(1.0);
                      },
                      child: LineSpaceWidget(
                          imagePath: 'assets/icons/image_spacing_three.svg',
                          showBorder:
                              selectedLineSpacing == 1.0 ? true : false),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18),
              Text(
                StringConstant.strColorMode(),
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.orange[50] ?? Colors.orange,
                            width: 6),
                      ),
                      child: Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: orangeColor, width: 3),
                        ),
                        child: Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 24),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(251, 240, 218, 1),
                        border: Border.all(
                            style: BorderStyle.solid,
                            color: Colors.deepPurple.shade100,
                            width: 2),
                      ),
                    ),
                  ),
                  SizedBox(width: 24),
                  InkWell(
                    onTap: () {
                      setState(() {});
                    },
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: blackColor,
                        border: Border.all(
                            style: BorderStyle.solid,
                            color: Colors.deepPurple.shade100,
                            width: 1),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  void _onPressedInter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Color(0X80000000).withOpacity(0.80),
          height: 350,
          child: Container(
            child: InterClick(),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          ),
        );
      },
    );
  }
}
