import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/services/navigator_service.dart';
import 'package:bhagavad_gita/widgets/searchbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../locator.dart';

class LanguageSettingScreen extends StatefulWidget {
  @override
  _LanguageSettingScreenState createState() => _LanguageSettingScreenState();
}

class _LanguageSettingScreenState extends State<LanguageSettingScreen> {
  final NavigationService navigationService = locator<NavigationService>();
  int val = -1;
  int lastPage = 0;
  int selectedFont = -1;

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
              'Language',
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
                itemCount: 30,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: InkWell(
                      onTap: () {
                        setState(() {
                          selectedFont = index;
                        });
                      },
                      child: Container(
                        height: 40,
                        child: Row(
                          children: [
                            Text(
                              "English",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                      ),
                    ),
                    trailing: selectedFont == index
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
                child: Center(
                  child: Text(
                    'SAVE CHANGE',
                    style: TextStyle(
                      fontSize: 14,
                      color: whiteColor,
                      fontWeight: FontWeight.w400,
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
}
