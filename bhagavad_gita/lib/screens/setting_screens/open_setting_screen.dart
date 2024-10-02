import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/Constant/static_model.dart';
import 'package:bhagavad_gita/Constant/string_constant.dart';
import 'package:bhagavad_gita/localization/demo_localization.dart';
import 'package:bhagavad_gita/models/color_selection_model.dart';
import 'package:bhagavad_gita/screens/setting_screens/language_setting.dart';
import 'package:bhagavad_gita/screens/setting_screens/verse_commentary_screen.dart';
import 'package:bhagavad_gita/screens/setting_screens/verse_translation_screen.dart';
import 'package:bhagavad_gita/services/navigator_service.dart';
import 'package:bhagavad_gita/services/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import '../../locator.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key, required this.refresh}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();

  final Function refresh;
}

class _SettingScreenState extends State<SettingScreen> {
  final NavigationService navigationService = locator<NavigationService>();

  bool isTranslationsource = false;
  bool isCommentarySource = false;
  bool isNotificationOn = false;

  List<bool> _switchValues = List.generate(7, (_) => false);

  @override
  void initState() {
    super.initState();
    setDefaultVar();
  }

  setDefaultVar() {
    Future.delayed(Duration(milliseconds: 10), () async {
      var temp1 = await SharedPref.getSavedBoolValue(
          PreferenceConstant.verseTransliterationSetting);
      var temp2 = await SharedPref.getSavedBoolValue(
          PreferenceConstant.verseTranslationSetting);
      var temp3 = await SharedPref.getSavedBoolValue(
          PreferenceConstant.verseCommentarySetting);

      setState(() {
        _switchValues[0] = temp1;
        _switchValues[1] = temp2;
        isTranslationsource = temp2;
        _switchValues[2] = temp3;
        isCommentarySource = temp3;
      });
    });
  }

  Future<bool> _willPopCallback() async {
    widget.refresh();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: whiteFormatingColor.bgColor,
          automaticallyImplyLeading: false,
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop(true);
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
                DemoLocalization.of(context)!
                    .getTranslatedValue('setting')
                    .toString(),
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: kPadding * 3,
                width: double.infinity,
                color: Colors.orange[50],
                child: Row(
                  children: [
                    SizedBox(width: kDefaultPadding),
                    Text(
                      DemoLocalization.of(context)!
                          .getTranslatedValue('Language')
                          .toString(),
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
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
                child: Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 0.5, color: textLightGreyColor),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LanguageSettingScreen(),
                            ),
                          );
                          setDefaultVar();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: kPadding * 2, right: kDefaultPadding),
                          child: Row(
                            children: [
                              Text(langauge.toUpperCase().replaceAll("\"", "")),
                              Spacer(),
                              SvgPicture.asset(
                                  'assets/icons/icn_arrow_forward.svg')
                            ],
                          ),
                        ),
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
                      DemoLocalization.of(context)!
                          .getTranslatedValue('author')
                          .toString(),
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
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
                      DemoLocalization.of(context)!
                          .getTranslatedValue('hideShowLanguage')
                          .toString(),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: textLightGreyColor, fontSize: 12),
                    ),
                  ],
                ),
              ),
              ListTileSwitch(
                value: _switchValues[0],
                onChanged: (value) {
                  setState(() {
                    _switchValues[0] = value;
                  });
                  SharedPref.saveBoolValue(
                      PreferenceConstant.verseTransliterationSetting, value);
                },
                switchActiveColor: orangeColor,
                switchScale: 0.8,
                switchType: SwitchType.cupertino,
                title: Text(
                  DemoLocalization.of(context)!
                      .getTranslatedValue('varseTranslationLanguage')
                      .toString(),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: greyScalBodyColor),
                ),
              ),
              Divider(
                indent: kPadding * 2,
                endIndent: kPadding * 2,
              ),
              ListTileSwitch(
                value: _switchValues[1],
                onChanged: (value) {
                  setState(() {
                    _switchValues[1] = value;
                    isTranslationsource = !isTranslationsource;
                  });
                  SharedPref.saveBoolValue(
                      PreferenceConstant.verseTranslationSetting, value);
                },
                switchActiveColor: orangeColor,
                switchScale: 0.8,
                switchType: SwitchType.cupertino,
                title: Text(
                  DemoLocalization.of(context)!
                      .getTranslatedValue('verseTanslationSource')
                      .toString(),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VerseTranslationScreen(),
                              ),
                            );
                            setDefaultVar();
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: kPadding * 1.5, right: kPadding * 1.5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    savedVerseTranslation.title!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontSize: 13),
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    softWrap: false,
                                  ),
                                ),
                                SizedBox(width: 4),
                                SvgPicture.asset(
                                    'assets/icons/icn_arrow_forward.svg')
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                indent: kPadding * 2,
                endIndent: kPadding * 2,
              ),
              ListTileSwitch(
                value: _switchValues[2],
                onChanged: (value) {
                  setState(() {
                    _switchValues[2] = value;
                    isCommentarySource = !isCommentarySource;
                  });
                  SharedPref.saveBoolValue(
                      PreferenceConstant.verseCommentarySetting, value);
                },
                switchActiveColor: orangeColor,
                switchScale: 0.8,
                switchType: SwitchType.cupertino,
                title: Text(
                  DemoLocalization.of(context)!
                      .getTranslatedValue('verseCommentrySource')
                      .toString(),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VerseCommentaryScreen(),
                              ),
                            );
                            setDefaultVar();
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: kPadding * 1.5, right: kPadding * 1.5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    savedVerseCommentary.title!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontSize: 13),
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    softWrap: false,
                                  ),
                                ),
                                SizedBox(width: 4),
                                SvgPicture.asset(
                                    'assets/icons/icn_arrow_forward.svg')
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              /*Container(
                height: kPadding * 3,
                width: double.infinity,
                color: Colors.orange[50],
                child: Row(
                  children: [
                    SizedBox(width: kDefaultPadding),
                    Text(
                      DemoLocalization.of(context)!
                          .getTranslatedValue('verseOfTheDay')
                          .toString(),
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            color: settingColor,
                            fontSize: 12,
                            letterSpacing: 1,
                          ),
                    ),
                  ],
                ),
              ),
              ListTileSwitch(
                value: _switchValues[3],
                onChanged: (value) {
                  setState(() {
                    _switchValues[3] = value;
                    isNotificationOn = !isNotificationOn;
                  });
                },
                switchActiveColor: orangeColor,
                switchScale: 0.8,
                switchType: SwitchType.cupertino,
                title: Text(
                  DemoLocalization.of(context)!
                      .getTranslatedValue('notification')
                      .toString(),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: greyScalBodyColor),
                ),
              ),
              AnimatedContainer(
                height: isNotificationOn ? 60 : 0,
                duration: Duration(milliseconds: 300),
                child: InkWell(
                  onTap: () {
                    print('timer');
                    setNotificationTimer(context);
                  },
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: kPadding * 1.5),
                      child: Row(
                        children: [
                          Text(
                            'Timer',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: greyScalBodyColor),
                          ),
                          Spacer(),
                          Text('13:00 PM'),
                          SizedBox(width: kPadding),
                          SvgPicture.asset('assets/icons/icon_downsidearrow.svg')
                        ],
                      ),
                    ),
                  ),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }

  /*setNotificationTimer(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 320,
          color: Color(0XFF737373),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: SetNotificationTimerWidget(),
          ),
        );
      },
    );
  }*/
}
