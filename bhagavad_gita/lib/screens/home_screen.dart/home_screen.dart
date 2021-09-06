import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/Constant/string_constant.dart';
import 'package:bhagavad_gita/widgets/chapter_list_tile_widget.dart';
import 'package:bhagavad_gita/widgets/last_read_widget.dart';
import 'package:bhagavad_gita/widgets/verse_of_the_day_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: kDefaultPadding),
          child: Text(
            StringConstant.strAppTitle,
            style: AppBarTheme.of(context).textTheme!.headline1,
          ),
        ),
        actions: [
          InkWell(
              onTap: () {
                print('Tap on setting icon');
              },
              child: SvgPicture.asset('assets/icons/icn_settings.svg')),
          SizedBox(
            width: kDefaultPadding,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            VerseOfTheDayWidget(),
            LastReadWidget(),
            Padding(
              padding: EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  bottom: kDefaultPadding),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        StringConstant.strChapters,
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(color: greyScalBodyColor, fontSize: 20),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          print('Sort button tap');
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          child: Center(
                            child:
                                SvgPicture.asset('assets/icons/icn_sort.svg'),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 18,
                itemBuilder: (context, index) {
                  return ChapterListTileWidget(
                    index: index,
                    onTap: () {
                      print("Chapter List time widget tap");
                    },
                  );
                }),
            SizedBox(
              height: kDefaultPadding * 2,
            )
          ],
        ),
      ),
    );
  }
}
