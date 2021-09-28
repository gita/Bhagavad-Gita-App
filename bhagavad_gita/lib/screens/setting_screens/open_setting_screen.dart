import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/Constant/string_constant.dart';
import 'package:bhagavad_gita/routes/route_names.dart';
import 'package:bhagavad_gita/services/navigator_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../locator.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final NavigationService navigationService = locator<NavigationService>();

  bool isTranslationsource = false;
  bool isCommentarySource = false;
  bool isNotificationOn = false;

  List<bool> _switchValues = List.generate(7, (_) => false);

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
            onTap: () {
              navigationService.goBack();
            },
            child: Container(
              width: 50,
              child: Center(
                child: SvgPicture.asset('assets/icons/icon_back_arrow.svg'),
              ),
            ),
          ),
          Spacer(),
          Center(
            child: Text(
              StringConstant.strSetting,
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: blackColor, fontSize: 18),
            ),
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
      body: Column(
        children: [
          Container(
            height: kPadding * 3,
            width: double.infinity,
            color: Colors.orange[50],
            child: Row(
              children: [
                SizedBox(width: kDefaultPadding),
                Text(
                  StringConstant.strLANGUAGE,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: settingColor,
                        fontSize: 12,
                        letterSpacing: 1,
                      ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: InkWell(
              onTap: () {
                navigationService.pushNamed(r_Language);
              },
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 0.5, color: textLightGreyColor),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: kPadding * 2, right: kDefaultPadding),
                  child: Row(
                    children: [
                      Text('🇬🇧  English'),
                      Spacer(),
                      SvgPicture.asset('assets/icons/icn_arrow_forward.svg')
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: kPadding * 3,
            width: double.infinity,
            color: Colors.orange[50],
            child: Row(
              children: [
                SizedBox(width: kDefaultPadding),
                Text(
                  StringConstant.strAUTHOR,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: settingColor, fontSize: 12, letterSpacing: 1),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: kPadding * 2, right: kPadding * 2, top: kPadding),
            child: Row(
              children: [
                Text(
                  StringConstant.strHideShowLanguage,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: textLightGreyColor, fontSize: 12),
                ),
              ],
            ),
          ),
          SwitchListTile(
            value: _switchValues[0],
            onChanged: (value) {
              setState(() {
                _switchValues[0] = value;
              });
            },
            title: Text(
              StringConstant.strVarseTranslationLanguage,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: greyScalBodyColor),
            ),
          ),
          Divider(
            indent: kPadding * 2,
            endIndent: kPadding * 2,
          ),
          SwitchListTile(
            value: _switchValues[1],
            onChanged: (value) {
              setState(() {
                _switchValues[1] = value;
                isTranslationsource = !isTranslationsource;
              });
            },
            title: Text(
              StringConstant.strVerseTanslationSource,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: greyScalBodyColor),
            ),
          ),
          AnimatedContainer(
            height: isTranslationsource ? 70 : 0,
            duration: Duration(milliseconds: 300),
            child: Padding(
              padding: EdgeInsets.all(kPadding * 1.5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 0.5, color: textLightGreyColor),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: kPadding * 2, right: kDefaultPadding),
                  child: Row(
                    children: [
                      Text('Sanskrit'),
                      Spacer(),
                      SvgPicture.asset('assets/icons/icn_arrow_forward.svg')
                    ],
                  ),
                ),
              ),
            ),
          ),
          Divider(
            indent: kPadding * 2,
            endIndent: kPadding * 2,
          ),
          SwitchListTile(
            value: _switchValues[2],
            onChanged: (value) {
              setState(() {
                _switchValues[2] = value;
                isCommentarySource = !isCommentarySource;
              });
            },
            title: Text(
              StringConstant.strVerseCommentrySource,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: greyScalBodyColor),
            ),
          ),
          AnimatedContainer(
            height: isCommentarySource ? 70 : 0,
            duration: Duration(milliseconds: 300),
            child: Padding(
              padding: EdgeInsets.all(kPadding * 1.5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 0.5, color: textLightGreyColor),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: kPadding * 2, right: kDefaultPadding),
                  child: Row(
                    children: [
                      Text('Swami Chinmayananda (Hindi)'),
                      Spacer(),
                      SvgPicture.asset('assets/icons/icn_arrow_forward.svg')
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: kPadding * 3,
            width: double.infinity,
            color: Colors.orange[50],
            child: Row(
              children: [
                SizedBox(width: kDefaultPadding),
                Text(
                  StringConstant.strVERSEOFTHEDAY,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: settingColor,
                        fontSize: 12,
                        letterSpacing: 1,
                      ),
                ),
              ],
            ),
          ),
          SwitchListTile(
            value: _switchValues[3],
            onChanged: (value) {
              setState(() {
                _switchValues[3] = value;
                isNotificationOn = !isNotificationOn;
              });
            },
            title: Text(
              StringConstant.strNotification,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: greyScalBodyColor),
            ),
          ),
          AnimatedContainer(
            height: isNotificationOn ? 70 : 0,
            duration: Duration(milliseconds: 300),
            child: Padding(
              padding: EdgeInsets.all(kPadding * 1.5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 0.5, color: textLightGreyColor),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: kPadding * 2, right: kDefaultPadding),
                  child: Row(
                    children: [
                      Text('Sanskrit'),
                      Spacer(),
                      SvgPicture.asset(
                          'assets/icons/icon_downsidearrow.svg')
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
