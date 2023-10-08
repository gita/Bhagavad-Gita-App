import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/localization/demo_localization.dart';
import 'package:bhagavad_gita/services/navigator_service.dart';
import 'package:bhagavad_gita/services/shared_preferences.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../locator.dart';

class InterClick extends StatefulWidget {
  const InterClick({
    Key? key,
    required this.selectedFontFamily,
  }) : super(key: key);

  @override
  _InterClickState createState() => _InterClickState();

  final Function(String) selectedFontFamily;
}

class _InterClickState extends State<InterClick> {
  final NavigationService navigationService = locator<NavigationService>();
  var isSelectedFont = 0;
  List<String> allFontFamily = ['Inter', 'Times New Roman', 'Arial', 'Roboto'];

  @override
  void initState() {
    super.initState();
    SharedPref.getSavedVerseListCustomisation().then((value) {
      var index = allFontFamily.indexWhere(
          (element) => element.toLowerCase() == value.fontfamily.toLowerCase());
      setState(() {
        isSelectedFont = index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: kPadding),
        child: Column(
          children: [
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
                InkWell(
                  onTap: () {
                    navigationService.goBack();
                  },
                  child: Container(
                    width: 50,
                    child: Center(
                      child:
                          SvgPicture.asset('assets/icons/icon_back_arrow.svg'),
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  DemoLocalization.of(context)!
                      .getTranslatedValue('fontFamily')
                      .toString(),
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: Colors.black,
                      fontSize: 14,
                      height: 1.5,
                      fontFamily: "fonts/Inter-SemiBold.ttf"),
                ),
                Spacer(),
                Container(
                  width: 50,
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/icon_back_arrow.svg',
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: kDefaultPadding),
            Expanded(
              child: ListView.builder(
                itemCount: allFontFamily.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: InkWell(
                      onTap: () {
                        setState(() {
                          isSelectedFont = index;
                        });
                        widget.selectedFontFamily(allFontFamily[index]);
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        children: [
                          Text(
                            allFontFamily[index],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              height: 1.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: isSelectedFont == index
                        ? SvgPicture.asset('assets/icons/Icon_true.svg')
                        : Text(''),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
