import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class QuotesScreen extends StatefulWidget {
  @override
  _QuotesScreenState createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/image_gitaFrontQuotes.png"),
              fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/black full.png",
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.width / kDefaultPadding * 4,
              right: MediaQuery.of(context).size.width / kDefaultPadding,
              child: Container(
                child: SvgPicture.asset("assets/icons/icon_shareQuotes.svg"),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / kPadding * 2.3,
              left: MediaQuery.of(context).size.width / kPadding * 0.5,
              child: Container(
                child: SvgPicture.asset("assets/icons/icon_Quote.svg"),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / kPadding * 2.8,
              left: MediaQuery.of(context).size.width / kPadding * 0.5,
              child: Container(
                width: 370,
                child: Text(
                  " Those who worship the devas will go to the realmof the devas; those who worship their ancestors will be united with them after death. Those who worship phantoms will become phantoms; but my devotees will come to me. Those who worship the devas will go to the realm of the devas; those who worship their ancestors will be united with them after death. Those who worship phantoms will become phantoms; but my devotees will come to me.",
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: whiteColor, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Positioned(
              bottom: kDefaultPadding,
              left: kDefaultPadding,
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: whiteColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: textLightGreyColor,
                      blurRadius: 10,
                    )
                  ],
                ),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/icon_slider_verse.svg",
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: kDefaultPadding,
              right: kDefaultPadding,
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: whiteColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: textLightGreyColor,
                      blurRadius: 10,
                    )
                  ],
                ),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/Icon_slider_verseNext.svg",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
