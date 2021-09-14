import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AboutGitaScreen extends StatefulWidget {
  @override
  _AboutGitaScreenState createState() => _AboutGitaScreenState();
}

class _AboutGitaScreenState extends State<AboutGitaScreen> {
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                        image: AssetImage('assets/images/image_aboutGita.png'),
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
                          'About',
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(fontSize: 28, color: whiteColor),
                        ),
                        Text(
                          'Gita',
                          textAlign: TextAlign.justify,
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(fontSize: 28, color: orangeColor),
                        ),
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
                      children: [
                        Padding(
                          padding: EdgeInsets.all(kDefaultPadding * 2),
                          child: SvgPicture.asset(
                            'assets/icons/icon_quote_AboutGita.svg',
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
                          "Unlike modern writing, The\nGita is not linear.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(fontSize: 18, color: orangeColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
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
                          text: 'Bhagavad Gita,',
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(fontSize: 16, color: blackColor),
                        ),
                        TextSpan(
                            text:
                                " also known as the Gita - 'The Song of The Lord' is a practical guide to one's life that guides one to re-organise their life, achieve inner peace and approach the Supreme Lord (the Ultimate Reality). It is a 700-verse text in Sanskrit which comprises chapters 23 through 40 in the Bhishma-Parva section of the Mahabharata.",
                            style: Theme.of(context).textTheme.subtitle1)
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
                        "STORY",
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: kDefaultPadding),
                      SvgPicture.asset(
                          "assets/icons/icon_right_translation.svg")
                    ],
                  ),
                  SizedBox(height: kDefaultPadding),
                  Text(
                      "The Bhagavad Gita is a dialogue between Arjuna, a supernaturally gifted warrior and his guide and charioteer Lord Krishna on the battlefield of Kurukshetra. As both armies stand ready for the battle, the mighty warrior Arjuna, on observing the warriors on both sides becomes overwhelmed with grief and compassion due to the fear of losing his relatives and friends and the consequent sins attributed to killing his own relatives. So, he surrenders to Lord Krishna, seeking a solution. Thus, follows the wisdom of the Bhagavad Gita. ",
                      style: Theme.of(context).textTheme.subtitle1),
                  SizedBox(height: kDefaultPadding * 1.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                          "assets/icons/icon_left_rtansection.svg"),
                      SizedBox(width: kDefaultPadding),
                      Text(
                        "CONCLUSION",
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: kDefaultPadding),
                      SvgPicture.asset(
                          "assets/icons/icon_right_translation.svg")
                    ],
                  ),
                  SizedBox(height: kDefaultPadding),
                  Text(
                    'Over 18 chapters, Gita packs an intense analysis of life, emotions and ambitions, discussion of various types of yoga, including Jnana, Bhakti, Karma and Raja, the difference between Self and the material body as well as the revelation of the Ultimate Purpose of Life.',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(height: kDefaultPadding),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
