// import 'dart:io' show Platform;
import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/localization/demo_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:in_app_review/in_app_review.dart';

class AboutGitaScreen extends StatefulWidget {
  @override
  _AboutGitaScreenState createState() => _AboutGitaScreenState();
}

class _AboutGitaScreenState extends State<AboutGitaScreen>
    with AutomaticKeepAliveClientMixin {
  final InAppReview inAppReview = InAppReview.instance;
  // final Uri _url = Uri.parse(
  //     'https://bhagavadgita.io/privacy-policy/');

  @override
  Widget build(BuildContext context) {
    super.build(context);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image:
                              AssetImage('assets/images/image_aboutGita.jpg'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/black_imageAboutGita.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height / kPadding * 2.7,
                    left: kDefaultPadding,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DemoLocalization.of(context)!
                                .getTranslatedValue('about_gita')
                                .toString(),
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(fontSize: 30, color: whiteColor),
                          ),
                          // Text(
                          //   DemoLocalization.of(context)!
                          //       .getTranslatedValue('gita')
                          //       .toString(),
                          //   textAlign: TextAlign.justify,
                          //   style: Theme.of(context)
                          //       .textTheme
                          //       .headline1!
                          //       .copyWith(fontSize: 28, color: orangeColor),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Stack(
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 20, bottom: 70),
                            child: SvgPicture.asset(
                              'assets/icons/icon_quote_AboutGita.svg',
                              height: 30,
                              width: 30,
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: kDefaultPadding * 2.7,
                        left: 0,
                        right: 0,
                        child: Container(
                          child: Text(
                            DemoLocalization.of(context)!
                                .getTranslatedValue('unlikeModernWriting')
                                .toString(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                    fontSize: (Localizations.localeOf(context)
                                                .languageCode ==
                                            'hi')
                                        ? 21
                                        : 20,
                                    color: orangeColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Column(
                  children: [
                    RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: DemoLocalization.of(context)!
                                .getTranslatedValue('gitaStory')
                                .toString(),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontSize: (Localizations.localeOf(context)
                                                .languageCode ==
                                            'hi')
                                        ? 20
                                        : 18,
                                    color: blackColor),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: kDefaultPadding * 1.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                            "assets/icons/icon_left_rtansection.svg"),
                        SizedBox(width: kDefaultPadding),
                        Text(
                          DemoLocalization.of(context)!
                              .getTranslatedValue('story')
                              .toString(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontSize: (Localizations.localeOf(context)
                                              .languageCode ==
                                          'hi')
                                      ? 20
                                      : 18,
                                  fontWeight: FontWeight.w600),
                        ),
                        SizedBox(width: kDefaultPadding),
                        SvgPicture.asset(
                            "assets/icons/icon_right_translation.svg")
                      ],
                    ),
                    SizedBox(height: kDefaultPadding),
                    Text(
                        DemoLocalization.of(context)!
                            .getTranslatedValue('gitaStoryDetail')
                            .toString(),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontSize: (Localizations.localeOf(context)
                                            .languageCode ==
                                        'hi')
                                    ? 20
                                    : 18,
                                color: blackColor)),
                    SizedBox(height: kDefaultPadding * 1.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/icon_left_rtansection.svg",
                          height: height * 0.020,
                        ),
                        SizedBox(width: kDefaultPadding),
                        Text(
                          DemoLocalization.of(context)!
                              .getTranslatedValue('conclusion')
                              .toString(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontSize: (Localizations.localeOf(context)
                                              .languageCode ==
                                          'hi')
                                      ? 20
                                      : 18,
                                  fontWeight: FontWeight.w600),
                        ),
                        SizedBox(width: kDefaultPadding),
                        SvgPicture.asset(
                          "assets/icons/icon_right_translation.svg",
                          height: height * 0.020,
                        )
                      ],
                    ),
                    SizedBox(height: kDefaultPadding),
                    Text(
                      DemoLocalization.of(context)!
                          .getTranslatedValue('conclusionDetail')
                          .toString(),
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize:
                              (Localizations.localeOf(context).languageCode ==
                                      'hi')
                                  ? 20
                                  : 18,
                          color: blackColor),
                    ),
                    SizedBox(height: kDefaultPadding),
                  ],
                ),
              ),
              SizedBox(height: kDefaultPadding * 1.5),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.small(
          onPressed: () async {
            final avaialable = await inAppReview.isAvailable();
            debugPrint("Avial==> $avaialable");
            await inAppReview.openStoreListing(
                appStoreId: "com.gitainitiative.bhagavadgita");
          },
          child: Icon(
            Icons.star,
            color: Color(0xFFFFFFFF),
          ),
          backgroundColor: Color(0xFFF57903),
        ),
      ),
    );
  }

  /* final _dialog = RatingDialog(
    starSize: 35,
    title: Text(
      Platform.isAndroid ? 'Rate Us On Play Store' : 'Rate Us On App Store',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ),
    message: Text(
      'Tap a star to set your rating',
      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
    ),
    image: Image.asset(
      "assets/images/splashScreenLogo.JPG",
      height: 100,
    ),
    submitButtonText: "Submit",
    onSubmitted: (response) {
      print('rating: ${response.rating}, comment: ${response.comment}');
        StoreRedirect.redirect(
            androidAppId: 'com.gitainitiative.bhagavadgita',
            iOSAppId: 'com.gitainitiative.bhagavadgita');
    },
  ); */

  @override
  bool get wantKeepAlive => true;
}
