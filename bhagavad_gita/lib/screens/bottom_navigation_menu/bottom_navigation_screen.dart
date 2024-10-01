import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/localization/demo_localization.dart';
import 'package:bhagavad_gita/models/color_selection_model.dart';
import 'package:bhagavad_gita/services/navigator_service.dart';
import 'package:bhagavad_gita/widgets/line_space_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../locator.dart';
import 'font_family_screen.dart';

class BottomNavigationMenu extends StatefulWidget {
  const BottomNavigationMenu(
      {Key? key,
      required this.lineSpacing,
      required this.initialLineSpacing,
      required this.selectedFontFamily,
      required this.selectedFontSize,
      required this.fontName,
      required this.fontSizeIncrease,
      required this.formatingColorSelection,
      required this.formatingColor})
      : super(key: key);

  @override
  _BottomNavigationMenuState createState() => _BottomNavigationMenuState();
  final Function(double) lineSpacing;
  final double initialLineSpacing;
  final FormatingColor formatingColor;
  final Function(String) selectedFontFamily;
  final Function(int) selectedFontSize;
  final Function(bool) fontSizeIncrease;
  final String fontName;
  final Function(FormatingColor) formatingColorSelection;
}

class _BottomNavigationMenuState extends State<BottomNavigationMenu> {
  final NavigationService navigationService = locator<NavigationService>();

  String fontFamilyName = 'Inter';
  FormatingColor colorMode = whiteFormatingColor;

  double selectedLineSpacing = 1.5;
  @override
  void initState() {
    super.initState();
    fontFamilyName = widget.fontName;
    selectedLineSpacing = widget.initialLineSpacing;
    colorMode = widget.formatingColor;
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        children: [
          SizedBox(height: kPadding),
          Container(
            height: 5,
            width: 50,
            decoration: BoxDecoration(
                color: editBoxBorderColor,
                borderRadius: BorderRadius.circular(10)),
          ),
          SizedBox(height: kDefaultPadding),
          Row(
            children: [
              Text(
                DemoLocalization.of(context)!
                    .getTranslatedValue('fontSize')
                    .toString(),
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(height: 1.5, color: greyScalBodyColor),
              ),
              SizedBox(width: 175),
              Text(
                DemoLocalization.of(context)!
                    .getTranslatedValue('fontFamily')
                    .toString(),
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(height: 1.5, color: greyScalBodyColor),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            child: Row(
              children: [
                Material(
                  child: InkWell(
                    onTap: () {
                      widget.fontSizeIncrease(true);
                    },
                    child: Container(
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
                  ),
                ),
                Material(
                  child: InkWell(
                    onTap: () {
                      widget.fontSizeIncrease(false);
                    },
                    child: Container(
                      height: 40,
                      width: 76,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: editBoxBorderColor,
                            style: BorderStyle.solid),
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
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Material(
                      child: InkWell(
                        onTap: () {
                          print('change font family');
                          _onPressedInter(context,
                              selectedFontFamily: (String fontFamily) {
                            setState(() {
                              fontFamilyName = fontFamily;
                            });
                            print('Selected font family 0: $fontFamily');
                            widget.selectedFontFamily(fontFamily);
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 180,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: editBoxBorderColor,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              fontFamilyName,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontSize: 18, color: titleLableColor),
                            ),
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
                DemoLocalization.of(context)!
                    .getTranslatedValue('spacing')
                    .toString(),
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
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
                        print('line sapcing');
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
                DemoLocalization.of(context)!
                    .getTranslatedValue('colorMode')
                    .toString(),
                style: Theme.of(context).textTheme.displayMedium,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        colorMode = whiteFormatingColor;
                      });
                      widget.formatingColorSelection(whiteFormatingColor);
                    },
                    child: ColorSelectionWidget(
                      formatingColor: whiteFormatingColor,
                      isSelected: colorMode.id == "1" ? true : false,
                    ),
                  ),
                  SizedBox(width: 24),
                  InkWell(
                    onTap: () {
                      setState(() {
                        colorMode = orangeFormatingColor;
                      });
                      widget.formatingColorSelection(orangeFormatingColor);
                    },
                    child: ColorSelectionWidget(
                      formatingColor: orangeFormatingColor,
                      isSelected: colorMode.id == "2" ? true : false,
                    ),
                  ),
                  SizedBox(width: 24),
                  InkWell(
                    onTap: () {
                      setState(() {
                        colorMode = blackFormatingColor;
                      });
                      widget.formatingColorSelection(blackFormatingColor);
                    },
                    child: ColorSelectionWidget(
                      formatingColor: blackFormatingColor,
                      isSelected: colorMode.id == "3" ? true : false,
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

  _onPressedInter(BuildContext context,
      {required Function(String) selectedFontFamily}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Color(0X80000000).withOpacity(0.80),
          height: 350,
          child: Container(
            child: InterClick(
              selectedFontFamily: (String fontFamily) {
                selectedFontFamily(fontFamily);
              },
            ),
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

class ColorSelectionWidget extends StatelessWidget {
  const ColorSelectionWidget({
    Key? key,
    required this.formatingColor,
    required this.isSelected,
  }) : super(key: key);

  final FormatingColor formatingColor;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return isSelected == true
        ? Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: Colors.orange[50] ?? Colors.orange, width: 6),
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
                  color: formatingColor.bgColor,
                ),
              ),
            ),
          )
        : Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: formatingColor.bgColor,
              border: Border.all(
                  style: BorderStyle.solid,
                  color: Colors.deepPurple.shade100,
                  width: 1),
            ),
          );
  }
}
