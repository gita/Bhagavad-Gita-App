import 'dart:math';
import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/Constant/quotes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class QuotesScreen extends StatefulWidget {
  @override
  _QuotesScreenState createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  String quote = "";

  @override
  void initState() {
    super.initState();
    getQuote();
  }

  getQuote() {
    final random = Random();
    var result = quotesList[random.nextInt(quotesList.length)];
    setState(() {
      quote = result;
    });
  }

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
              top: width / kDefaultPadding * 4,
              right: width / kDefaultPadding,
              child: InkWell(
                onTap: () {
                  print('Shear Quote');
                },
                child: Container(
                  child: SvgPicture.asset("assets/icons/icon_shareQuotes.svg"),
                ),
              ),
            ),
            Positioned(
              top: height / kPadding * 2.3,
              left: width / kPadding * 0.5,
              child: Container(
                child: SvgPicture.asset("assets/icons/icon_Quote.svg"),
              ),
            ),
            Positioned(
              top: height / kPadding * 2.8,
              left: width / kPadding * 0.5,
              child: Container(
                width: 360,
                child: Text(
                  quote,
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
              child: InkWell(
                onTap: () {
                  getQuote();
                },
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
            ),
            Positioned(
              bottom: kDefaultPadding,
              right: kDefaultPadding,
              child: InkWell(
                onTap: () {
                  getQuote();
                },
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
            ),
          ],
        ),
      ),
    );
  }
}
