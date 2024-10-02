import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/Constant/static_model.dart';
import 'package:bhagavad_gita/Constant/string_constant.dart';
import 'package:bhagavad_gita/localization/demo_localization.dart';
import 'package:bhagavad_gita/main.dart';
import 'package:bhagavad_gita/models/color_selection_model.dart';
import 'package:bhagavad_gita/models/tanslation_response_model.dart';
import 'package:bhagavad_gita/services/last_read_services.dart';
import 'package:bhagavad_gita/services/navigator_service.dart';
import 'package:bhagavad_gita/services/shared_preferences.dart';
import 'package:bhagavad_gita/widgets/searchbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../locator.dart';

class LanguageSettingScreen extends StatefulWidget {
  const LanguageSettingScreen({
    Key? key,
  }) : super(key: key);

  @override
  _LanguageSettingScreenState createState() => _LanguageSettingScreenState();
}

class _LanguageSettingScreenState extends State<LanguageSettingScreen> {
  final NavigationService navigationService = locator<NavigationService>();
  int selectedlanguage = 0;

  List<String> listLang = ["English", "Hindi"];

  @override
  void initState() {
    super.initState();

    var index = listLang.indexWhere(
        (element) => element.toLowerCase() == langauge.toLowerCase());
    setState(() {
      selectedlanguage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: whiteFormatingColor.bgColor,
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
            onTap: () {
              navigationService.goBack();
            },
            child: Container(
              width: 50,
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/icon_close_btn.svg',
                ),
              ),
            ),
          ),
          Spacer(),
          Center(
            child: Text(
              DemoLocalization.of(context)!
                  .getTranslatedValue('Language')
                  .toString(),
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: blackColor, fontSize: 18),
            ),
          ),
          Spacer(),
          Container(width: 50),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: kDefaultPadding),
            SearchBarWidget(),
            SizedBox(height: kPadding),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: listLang.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: InkWell(
                      onTap: () {
                        setState(() {
                          selectedlanguage = index;
                        });
                      },
                      child: Container(
                        height: 40,
                        child: Row(
                          children: [
                            Text(
                              listLang[index],
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                    trailing: selectedlanguage == index
                        ? SvgPicture.asset('assets/icons/Icon_true.svg')
                        : Text(''),
                  );
                },
              ),
            ),
            SizedBox(height: kDefaultPadding),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(245, 121, 3, 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      if (selectedlanguage == -1) {
                        return;
                      }
                      _changeLanguage(listLang[selectedlanguage]);
                      Navigator.pop(context, true);
                    },
                    child: Center(
                      child: Text(
                        DemoLocalization.of(context)!
                            .getTranslatedValue('saveChange')
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
            SizedBox(height: kDefaultPadding),
          ],
        ),
      ),
    );
  }

  void _changeLanguage(String strlang) {
    SharedPref.savelanguage(strlang.toLowerCase());
    langauge = strlang.toLowerCase();
    Locale _temp;
    switch (strlang.toLowerCase()) {
      case 'english':
        _temp = Locale('en', 'US');
        SharedPref.saveBoolValue(
            PreferenceConstant.verseTransliterationSetting, true);
        TranslationResponseModel temp = TranslationResponseModel(
          authorName: 'Swami Adidevananda',
          language: 'english',
          title: 'English translation by Swami Adidevananda',
        );
        SharedPref.saveVerseTranslationSelection(temp);
        SharedPref.saveBoolValue(
            PreferenceConstant.verseCommentarySetting, true);
        TranslationResponseModel temp2 = TranslationResponseModel(
          authorName: 'Swami Sivananda',
          language: 'english',
          title: 'English Commentary by Swami Sivananda',
        );
        SharedPref.saveVerseCommentarySetting(temp2);
        setState(() {
          savedVerseTranslation = temp;
          savedVerseCommentary = temp2;
        });
        LocalNotification.instance.refreshVerseOfTheDay();
        break;
      default:
        _temp = Locale('hi', 'IN');
        SharedPref.saveBoolValue(
            PreferenceConstant.verseTransliterationSetting, false);
        TranslationResponseModel temp = TranslationResponseModel(
          authorName: 'Swami Tejomayananda',
          language: 'hindi',
          title: 'Hindi translation by Swami Tejomayananda',
        );
        SharedPref.saveVerseTranslationSelection(temp);
        SharedPref.saveBoolValue(
            PreferenceConstant.verseCommentarySetting, true);
        TranslationResponseModel temp2 = TranslationResponseModel(
          authorName: 'Swami Chinmayananda',
          language: 'hindi',
          title: 'Hindi Commentary by Swami Chinmayananda',
        );
        SharedPref.saveVerseCommentarySetting(temp2);
        setState(() {
          savedVerseTranslation = temp;
          savedVerseCommentary = temp2;
        });
        LocalNotification.instance.refreshVerseOfTheDay();
    }
    MyApp.setLocales(context, _temp);
  }
}
