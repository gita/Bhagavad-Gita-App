import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/services/navigator_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../locator.dart';

class ContinueReading extends StatefulWidget {
  @override
  _ContinueReadingState createState() => _ContinueReadingState();
}

class _ContinueReadingState extends State<ContinueReading> {
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
          SizedBox(
            width: kDefaultPadding,
          ),
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
          SizedBox(
            width: kPadding,
          ),
          InkWell(
            onTap: () {
              print('Tap on setting icon');
            },
            child: SvgPicture.asset('assets/icons/icon_setting_nonsele.svg'),
          ),
          SizedBox(
            width: kDefaultPadding,
          )
        ],
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Column(
                  children: [
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    Text(
                      "10.18",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    Text(
                      "धृतराष्ट्र उवाच |\nधर्मक्षेत्रे कुरुक्षेत्रे समवेता युयुत्सवः |\nमामकाः पाण्डवाश्चैव किमकुर्वत सञ्जय ||1||",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: orangeColor, height: 2.25),
                    ),
                    SizedBox(
                      height: kPadding * 3,
                    ),
                    Text(
                      "dhṛitarāśhtra uvācha\ndharma-kṣhetre kuru-kṣhetre\nsamavetā yuyutsavaḥ\nmāmakāḥ pāṇḍavāśhchaiva\nkimakurvata sañjaya",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(
                      height: kDefaultPadding * 2,
                    ),
                    Text(
                      "dhṛitarāśhtraḥ uvācha—Dhritarashtra said;\ndharma-kṣhetre—the land of dharma;\nkuru-kṣhetre—at Kurukshetra;\nsamavetāḥ—having gathered;\nyuyutsavaḥ—desiring to fight;\nmāmakāḥ—my sons; pāṇḍavāḥ—the sons\nof Pandu; cha—and; eva—certainly;\nkim—what; akurvata—did they do;\nsañjaya—Sanjay",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(height: kDefaultPadding * 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                            "assets/icons/icon_left_rtansection.svg"),
                        SizedBox(width: kDefaultPadding),
                        Text(
                          "TRANSLATION",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(width: kDefaultPadding),
                        SvgPicture.asset(
                            "assets/icons/icon_right_translation.svg")
                      ],
                    ),
                    SizedBox(height: kDefaultPadding),
                    Text(
                      "Dhritarashtra said: O Sanjay, after gathering on the holy field of Kurukshetra, and desiring to fight, what did my sons and the sons of Pandu do?  ",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                            "assets/icons/icon_left_rtansection.svg"),
                        SizedBox(width: kDefaultPadding),
                        Text(
                          "COMMENTARY",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(width: kDefaultPadding),
                        SvgPicture.asset(
                            "assets/icons/icon_right_translation.svg")
                      ],
                    ),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    Text(
                      "The two armies had gathered on the battlefield of Kurukshetra, well prepared to fight a war that was inevitable. Still, in this verse, King Dhritarashtra asked Sanjay, what his sons and his brother Pandu’s sons were doing on the battlefield? It was apparent that they would fight, then why did he ask such a question?The blind King Dhritarashtra’s fondness for his own sons had clouded his spiritual wisdom and deviated him from the path of virtue. He had usurped the kingdom of Hastinapur from the rightful heirs; the Pandavas, sons of his brother Pandu. Feeling guilty of the injustice he had done towards his nephews, his conscience worried him about the outcome of this battle.The words dharma kṣhetre, the land of dharma (virtuous conduct) used by Dhritarashtra depict the dilemma he was experiencing.  Kurukshetra is described as kurukṣhetraṁ deva yajanam in the Shatapath Brahman, the Vedic textbook detailing rituals. It means “Kurukshetra is the sacrificial arena of the celestial gods.” Hence, it was regarded as the sacred land that nourished dharma. Dhritarashtra feared that the holy land might influence the minds of his sons. If it aroused the faculty of discrimination, they might turn away from killing their cousins and negotiate a truce. A peaceful settlement meant that the Pandavas would continue being a hindrance for them. He felt great displeasure at these possibilities, instead preferred that this war transpires. He was uncertain of the consequences of the war, yet desired to determine the fate of his sons. Therefore, he asked Sanjay about the activities of the two armies on the battleground.",
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 100 * 70,
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
              top: MediaQuery.of(context).size.height / 100 * 70,
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
      bottomNavigationBar: BottomAppBar(
        elevation: 15,
        child: Container(
          height: 48,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {},
                child: SvgPicture.asset("assets/icons/Icon_menu_bottom.svg"),
              ),
              InkWell(
                onTap: () {},
                child: SvgPicture.asset("assets/icons/Icon_shear_bottom.svg"),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _onPressedEditButton(context);
                    // _onPressedEditButton();
                  });
                },
                child: SvgPicture.asset("assets/icons/Icon_write_bottom.svg"),
              ),
              InkWell(
                onTap: () {},
                child: SvgPicture.asset("assets/icons/Icon_save_bottom.svg"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressedEditButton(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0XFF737373),
            // height: height * 0.33,
            height: 350,
            child: Container(
              child: BottomNavigationMenu(),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            ),
          );
        });
  }
}

class BottomNavigationMenu extends StatefulWidget {
  const BottomNavigationMenu({Key? key}) : super(key: key);

  @override
  _BottomNavigationMenuState createState() => _BottomNavigationMenuState();
}

class _BottomNavigationMenuState extends State<BottomNavigationMenu> {
  final NavigationService navigationService = locator<NavigationService>();
  // int isSelectColor = 0;
  // int _currentColorIndex = 0;
  // List<Color> _colors = <Color>[
  //   Colors.blue,
  //   Colors.red,
  //   Colors.black,
  //   Colors.green
  // ];

  // var backgroungColor = ['', '', ''];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: 29),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Font Size",
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(height: 1.5, color: greyScalBodyColor),
              ),
              SizedBox(width: 175),
              Text(
                "Font Family",
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(height: 1.5, color: greyScalBodyColor),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 76,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: editBoxBorderColor,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/image_aa_pluse.svg',
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: 76,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: editBoxBorderColor, style: BorderStyle.solid),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/image_aa_min.svg',
                    ),
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    InkWell(
                      onTap: () => _onPressedInter(context),
                      child: Container(
                        height: 40,
                        width: 144,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: editBoxBorderColor,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            'Inter',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(fontSize: 18, color: titleLableColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Spacing",
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(height: 1.5, color: greyScalBodyColor),
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: editBoxBorderColor,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/image_spacing_one.svg',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(
                      width: 180,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.orange[50] ?? Colors.orange,
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        width: 140,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.orange,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          width: 100,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: SvgPicture.asset(
                            'assets/icons/image_spacing_two.svg',
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: editBoxBorderColor,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/image_spacing_three.svg',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18),
              Text(
                "Color Mode",
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.orange[50] ?? Colors.orange,
                            width: 6),
                      ),
                      child: Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: orangeColor, width: 3),
                        ),
                        child: Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 24),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(251, 240, 218, 1),
                        border: Border.all(
                            style: BorderStyle.solid,
                            color: Colors.deepPurple.shade100,
                            width: 2),
                      ),
                    ),
                  ),
                  SizedBox(width: 24),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                        border: Border.all(
                            style: BorderStyle.solid,
                            color: Colors.deepPurple.shade100,
                            width: 1),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

void _onPressedInter(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Color(0X80000000).withOpacity(0.80),
          // height: height * 0.33,
          height: 350,
          child: Container(
            child: InterClick(),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          ),
        );
      });
}

class InterClick extends StatefulWidget {
  const InterClick({Key? key}) : super(key: key);

  @override
  _InterClickState createState() => _InterClickState();
}

class _InterClickState extends State<InterClick> {
  final NavigationService navigationService = locator<NavigationService>();
  int selectedFont = 0;
  var alllangauge = ['Inter', 'Georgia', 'Avenir', 'Proxima Nova'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(kPadding * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset('assets/icons/icon_back_arrow.svg'),
                SizedBox(width: 108.25),
                Text(
                  "Font Family",
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Colors.black,
                      fontSize: 14,
                      height: 1.5,
                      fontFamily: "fonts/Inter-SemiBold.ttf"),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: alllangauge.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: InkWell(
                      onTap: () {
                        print('Ritvik');
                        setState(() {
                          selectedFont = index;
                        });
                      },
                      child: Text(
                        alllangauge[index],
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            height: 1.1,
                            fontStyle: FontStyle.normal),
                      ),
                    ),
                    trailing: selectedFont == index
                        ? SvgPicture.asset('assets/icons/Icon_true.svg')
                        : Text(''),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
