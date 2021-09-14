import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/routes/route_names.dart';
import 'package:bhagavad_gita/services/navigator_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../locator.dart';

class ChapterDetailScreen extends StatefulWidget {
  @override
  _ChapterDetailScreenState createState() => _ChapterDetailScreenState();
}

class _ChapterDetailScreenState extends State<ChapterDetailScreen> {
  final NavigationService navigationService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        actions: [
          SizedBox(width: kDefaultPadding),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset("assets/icons/icon_back_arrow.svg"),
          ),
          Spacer(),
          TextButton(
            onPressed: () {},
            child: Text(
              "Aa",
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: 18, fontWeight: FontWeight.w100),
            ),
          ),
          SizedBox(width: kPadding),
          InkWell(
            onTap: () {
              navigationService.pushNamed(r_ChapterTableView);
            },
            child: SvgPicture.asset('assets/icons/Icon_menu_bottom.svg'),
          ),
          SizedBox(width: kDefaultPadding),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            // top: MediaQuery.of(context).size.height / kPadding,
            child: SvgPicture.asset("assets/icons/flower_chapterDetail.svg"),
          ),
          Positioned(
            right: 0,
            // top: MediaQuery.of(context).size.height / kPadding,
            child:
                SvgPicture.asset("assets/icons/flower_chapterDetail_right.svg"),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kPadding * 2),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: kDefaultPadding * 2),
                    Center(
                      child: Text(
                        "CHAPTER 1",
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              color: orangeColor,
                              fontSize: 16,
                            ),
                      ),
                    ),
                    SizedBox(height: kPadding),
                    Text(
                      "Arjuna Visada Yoga",
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(fontSize: 18),
                    ),
                    SizedBox(height: kDefaultPadding * 2),
                    Text(
                      "The first chapter of the Bhagavad Gita - Arjuna Vishada Yoga introduces the setup, the setting, the characters and the circumstances that led to the epic battle of Mahabharata, fought between ",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "SHOW MORE",
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(color: textLightGreyColor),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: kDefaultPadding),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (BuildContext context, index) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/icon_verseLogo.svg",
                                ),
                                SizedBox(width: kPadding),
                                Text(
                                  "Verse 1",
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                                Spacer(),
                                SvgPicture.asset(
                                  "assets/icons/icn_arrow_forward.svg",
                                ),
                              ],
                            ),
                            SizedBox(height: kPadding),
                            Text(
                              "Dhṛtarāṣṭra said: O Sañjaya, after my sons and the sons of Pāṇḍu assembled in the place of pilgrimage at Kurukṣetra, desiring to fight, what did they do?",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Divider(height: kDefaultPadding * 2)
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
