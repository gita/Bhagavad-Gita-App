import 'dart:convert';
import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/Constant/static_model.dart';
import 'package:bhagavad_gita/localization/demo_localization.dart';
import 'package:bhagavad_gita/locator.dart';
import 'package:bhagavad_gita/models/tanslation_response_model.dart';
import 'package:bhagavad_gita/services/navigator_service.dart';
import 'package:bhagavad_gita/services/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart' as rootBundle;

class VerseTranslationScreen extends StatefulWidget {
  @override
  _VerseTranslationScreenState createState() => _VerseTranslationScreenState();
}

class _VerseTranslationScreenState extends State<VerseTranslationScreen> {
  final NavigationService navigationService = locator<NavigationService>();
  List<TranslationResponseModel> listTranslationResponseModel = [];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    readFromJson().then((value) {
      setState(() {
        listTranslationResponseModel = value;
      });
      var temp = value.indexWhere((element) {
        return element.authorName!.toLowerCase() ==
                savedVerseTranslation.authorName!.toLowerCase() &&
            element.language!.toLowerCase() ==
                savedVerseTranslation.language!.toLowerCase();
      });
      print("Index : $temp");
      setState(() {
        selectedIndex = temp;
      });
    });
  }

  Future<List<TranslationResponseModel>> readFromJson() async {
    final jsonData =
        await rootBundle.rootBundle.loadString('lib/jsonfile/translation.json');
    final list = jsonDecode(jsonData) as List<dynamic>;
    return list.map((e) => TranslationResponseModel.fromJson(e)).toList();
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
                  .getTranslatedValue('verseTanslationSource')
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
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: listTranslationResponseModel.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                        SharedPref.saveVerseTranslationSelection(
                            listTranslationResponseModel[index]);
                        setState(() {
                          savedVerseTranslation =
                              listTranslationResponseModel[index];
                        });
                      },
                      child: Container(
                        height: 40,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              listTranslationResponseModel[index].title ?? "",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                      ),
                    ),
                    trailing: selectedIndex == index
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
                      Navigator.of(context).pop(true);
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
            SizedBox(height: kDefaultPadding)
          ],
        ),
      ),
    );
  }
}
