import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/Constant/quotes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share/share.dart';

class QuotesScreen extends StatefulWidget {
  @override
  _QuotesScreenState createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen>
    with AutomaticKeepAliveClientMixin {
  String quote = "";
  final PageController controller = PageController();
  int index = 0;
  @override
  void initState() {
    super.initState();
    quotesListHindi.shuffle();
    quotesList.shuffle();
    Future.delayed(Duration.zero, () {
      getFirstQuote();
    });
  }

  /*  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    this.getFirstQuote();
  } */

  /* getQuote() {
    final random = Random();
    var result = (Localizations.localeOf(context).languageCode == 'hi') ?
        quotesListHindi[random.nextInt(quotesListHindi.length)] :
        quotesList[random.nextInt(quotesList.length)];
    setState(() {
      quote = result;
    });
  } */

  getFirstQuote() {
    var result = (Localizations.localeOf(context).languageCode == 'hi')
        ? quotesListHindi[index]
        : quotesList[index];
    setState(() {
      quote = result;
    });
  }

  getQuote() {
    index++;
    var result = (Localizations.localeOf(context).languageCode == 'hi')
        ? quotesListHindi[index]
        : quotesList[index];
    setState(() {
      quote = result;
    });
  }

  reverseQuote() {
    index--;
    var result = (Localizations.localeOf(context).languageCode == 'hi')
        ? quotesListHindi[index]
        : quotesList[index];
    setState(() {
      quote = result;
    });
  }

  share(BuildContext context) async {
    final RenderBox box = context.findRenderObject() as RenderBox;
    await Share.share(quote,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
              child: Material(
                color: Colors.transparent,
                shape: CircleBorder(),
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  onTap: () async {
                    print('Share Quote');
                    share(context);
                  },
                  child: Container(
                    child:
                        SvgPicture.asset("assets/icons/icon_shareQuotes.svg"),
                  ),
                ),
              ),
            ),
            Positioned(
              top: height / kPadding * 2.2,
              left: width / kPadding * 0.5,
              child: Container(
                child: SvgPicture.asset("assets/icons/icon_Quote.svg"),
              ),
            ),
            Positioned(
              top: height / kPadding * 2.8,
              left: width / kPadding * 0.5,
              child: Container(
                width: 340,
                child: Text(
                  quote,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: whiteColor,
                      fontSize:
                          (Localizations.localeOf(context).languageCode == 'hi')
                              ? 21
                              : 18,
                      fontWeight: FontWeight.w500,
                      height: 1.7),
                ),
              ),
            ),
            Positioned(
              bottom: kDefaultPadding,
              left: kDefaultPadding,
              child: Visibility(
                visible: index > 0,
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
                  child: Material(
                    color: Colors.transparent,
                    shape: CircleBorder(),
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                      onTap: () {
                        if (index > 0) {
                          reverseQuote();
                        }
                      },
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/icons/icon_slider_verse.svg",
                        ),
                      ),
                    ),
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
                child: Material(
                  color: Colors.transparent,
                  shape: CircleBorder(),
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    onTap: () {
                      getQuote();
                    },
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/icons/Icon_slider_verseNext.svg",
                      ),
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

  @override
  bool get wantKeepAlive => true;
}
