import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/Constant/string_constant.dart';
import 'package:bhagavad_gita/services/navigator_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../locator.dart';

class InterClick extends StatefulWidget {
  const InterClick({Key? key}) : super(key: key);

  @override
  _InterClickState createState() => _InterClickState();
}

class _InterClickState extends State<InterClick> {
  final NavigationService navigationService = locator<NavigationService>();
  int selectedFont = 0;
  var alllangauge = ['Inter', 'Georgia', 'Avenir', 'Proxima Nova'];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: kDefaultPadding * 1.8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  StringConstant.strFontFamily,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
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
                itemCount: alllangauge.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: InkWell(
                      onTap: () {
                        setState(() {
                          selectedFont = index;
                        });
                      },
                      child: Row(
                        children: [
                          Text(
                            alllangauge[index],
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              height: 1.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: selectedFont == index
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
