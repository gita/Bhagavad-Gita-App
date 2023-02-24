import 'dart:io' show Platform;
import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/localization/demo_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:bhagavad_gita/screens/setting_screens/open_setting_screen.dart';
import 'package:url_launcher/url_launcher.dart';


class BibliographyScreen extends StatefulWidget {

  @override
  State<BibliographyScreen> createState() => _BibliographyScreenState();
}

class _BibliographyScreenState extends State<BibliographyScreen> {
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    Future _launchURLApp({
      required String url,
    }) async {
      var a = Uri.parse(url);

      if (await canLaunchUrl(a)) {
        await launchUrl(a);
      } else {
        throw 'Could not launch $url';
      }
    }

    return SafeArea(
      child: Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:8.0, top:27.0, bottom:8.0, right:8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/icons/icon_left_rtansection.svg"),
                      SizedBox(width: kDefaultPadding),
                      Text(
                        DemoLocalization.of(context)!
                            .getTranslatedValue('InformationSources')
                            .toString(),
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: 
                                (Localizations.localeOf(context).languageCode ==
                                        'hi')
                                    ? 15
                                    : 13,
                            fontWeight: FontWeight.w600,
                            ),
                      ),
                      SizedBox(width: kDefaultPadding),
                      SvgPicture.asset("assets/icons/icon_right_translation.svg")
                    ],
                  ),
                ),
                SizedBox(height: kDefaultPadding),
          
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
                          onTap: () {
                                      _launchURL();
                                    },
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: kPadding * 2, right: kDefaultPadding),
                            child: Align(
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text("Text")),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
          
                Padding(
                  padding: EdgeInsets.all(kDefaultPadding),
                  child: GestureDetector(
                    onTap: _launchURL1,
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
                            onTap: () {
                                      _launchURL1();
                                    },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: kPadding * 2, right: kDefaultPadding),
                              child: Row(
                                children: [
                                  Text("Audio"),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
          
                Padding(
                  padding: EdgeInsets.all(kDefaultPadding),
                  child: GestureDetector(
                    onTap: _launchURL1,
                    child: Container(
                      height: 90,
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
                            onTap: () {
                          _launchURLApp(url: 'mailto:admin@bhagavadgita.io');
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: kPadding * 2, right: kDefaultPadding),
                              child: Row(
                                children: [
                                  Text(
                                      "Email us at admin@bhagavadgita.io \n to report copyright voilations"),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _launchURL() async {
    const url = 'https://www.gitasupersite.iitk.ac.in/';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
  
  _launchURL1() async {
    const url = 'https://www.bhagavad-gita.org/';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
