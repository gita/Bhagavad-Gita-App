import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/Constant/string_constant.dart';
import 'package:bhagavad_gita/localization/demo_localization.dart';
import 'package:bhagavad_gita/main.dart';
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
                  .headline1!
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
                              style: Theme.of(context).textTheme.subtitle1,
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
                      Navigator.pop(context);
                    },
                    child: Expanded(
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
        break;
      default:
        _temp = Locale('hi', 'IN');
    }
    MyApp.setLocales(context, _temp);
  }
}
