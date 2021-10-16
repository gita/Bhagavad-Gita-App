import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/localization/demo_localization.dart';
import 'package:bhagavad_gita/locator.dart';
import 'package:bhagavad_gita/models/notes_model.dart';
import 'package:bhagavad_gita/services/navigator_service.dart';
import 'package:bhagavad_gita/services/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddNotesWidget extends StatefulWidget {
  final VerseNotes verseNotes;

  const AddNotesWidget({Key? key, required this.verseNotes}) : super(key: key);

  @override
  State<AddNotesWidget> createState() => _AddNotesWidgetState();
}

class _AddNotesWidgetState extends State<AddNotesWidget> {
  NavigationService navigationService = locator<NavigationService>();
  String strNotes = "";
  late VerseNotes verseNotes;
  List<VerseNotes> writeNotes = [];
  @override
  void initState() {
    super.initState();
    this.verseNotes = widget.verseNotes;
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size.height;
    MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            navigationService.goBack();
          },
          child: Container(
            height: 40,
            width: 50,
            child: Center(
              child: SvgPicture.asset('assets/icons/icon_back_arrow.svg'),
            ),
          ),
        ),
        title: Text(
          verseNotes.verseNote == ""
              ? DemoLocalization.of(context)!
                  .getTranslatedValue('addNotes')
                  .toString()
              : DemoLocalization.of(context)!
                  .getTranslatedValue('editNote')
                  .toString(),
          style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 18),
        ),
        actions: [
          strNotes.length > 0
              ? Center(
                  child: Container(
                    height: 30,
                    width: 71,
                    decoration: BoxDecoration(
                        color: orangeColor,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () async {
                          verseNotes.verseNote = strNotes;
                          await SharedPref.saveVerseNotes(verseNotes);
                          Navigator.of(context).pop();
                        },
                        child: Expanded(
                          child: Center(
                            child: Text(
                              DemoLocalization.of(context)!
                                  .getTranslatedValue('save')
                                  .toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(fontSize: 14, color: whiteColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          strNotes.length <= 0
              ? Center(
                  child: Container(
                    height: 30,
                    width: 71,
                    decoration: BoxDecoration(
                        color: orangeColor,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () async {
                          verseNotes.verseNote = strNotes;
                          await SharedPref.removeVerseNotesFromSaved(
                              verseNotes.verseNote);
                          Navigator.of(context).pop();
                        },
                        child: Expanded(
                          child: Center(
                            child: Text(
                              DemoLocalization.of(context)!
                                  .getTranslatedValue('delete')
                                  .toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(fontSize: 14, color: whiteColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          SizedBox(
            width: kDefaultPadding,
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: TextFormField(
            keyboardType: TextInputType.multiline,
            initialValue: verseNotes.verseNote,
            maxLines: 100,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: DemoLocalization.of(context)!
                  .getTranslatedValue('pleaseAddYourNote')
                  .toString(),
            ),
            onChanged: (String value) {
              setState(() {
                strNotes = value;
              });
            },
          ),
        ),
      ),
    );
  }
}
