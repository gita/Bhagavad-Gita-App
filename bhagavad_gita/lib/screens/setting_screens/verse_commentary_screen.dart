import 'dart:convert';
import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/Constant/static_model.dart';
import 'package:bhagavad_gita/localization/demo_localization.dart';
import 'package:bhagavad_gita/models/tanslation_response_model.dart';
import 'package:bhagavad_gita/services/navigator_service.dart';
import 'package:bhagavad_gita/services/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../locator.dart';
import 'package:flutter/services.dart' as rootBundle;

class VerseCommentaryScreen extends StatefulWidget {
  @override
  State<VerseCommentaryScreen> createState() => _VerseCommentaryScreenState();
}

class _VerseCommentaryScreenState extends State<VerseCommentaryScreen> {
  final NavigationService navigationService = locator<NavigationService>();
  List<TranslationResponseModel> listTranslationResponseModel = [];
  int isSelectedIndex = 0;

  @override
  void initState() {
    super.initState();
    readFromJson().then((val) {
      setState(() {
        listTranslationResponseModel = val;
      });
      var temp1 = val.indexWhere((element) {
        return element.authorName!.toLowerCase() ==
                savedVerseCommentary.authorName!.toLowerCase() &&
            element.language!.toLowerCase() ==
                savedVerseCommentary.language!.toLowerCase();
      });
      print("Index : $temp1");
      setState(() {
        isSelectedIndex = temp1;
      });
    });
  }

  Future<List<TranslationResponseModel>> readFromJson() async {
    final jsonData = await rootBundle.rootBundle
        .loadString('lib/jsonfile/commentaries.json');
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
                  .getTranslatedValue('verseCommentrySource')
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
                          isSelectedIndex = index;
                        });
                        SharedPref.saveVerseTranslationSelection(
                            listTranslationResponseModel[index]);
                        setState(() {
                          savedVerseCommentary =
                              listTranslationResponseModel[index];
                        });
                      },
                      child: Container(
                        height: 50,
                        child: Text(
                          listTranslationResponseModel[index].title ?? "",
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                    ),
                    trailing: isSelectedIndex == index
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
                      Navigator.of(context).pop();
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
