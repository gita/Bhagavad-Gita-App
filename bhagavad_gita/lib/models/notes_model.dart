import 'package:bhagavad_gita/models/verse_detail_model.dart';

class VerseNotes {
  String? verseID;
  GitaVerseById? gitaVerseById;
  DateTime addedDate = DateTime.now();
  String verseNote;

  VerseNotes({this.verseID, this.gitaVerseById, required this.verseNote});

  factory VerseNotes.fromJson(Map<String, dynamic> json) => VerseNotes(
      gitaVerseById: GitaVerseById.fromJson(json["gitaVerseById"]),
      verseID: json["verseID"],
      verseNote: json["verseNote"]);

  Map<String, dynamic> toJson() => {
        "verseID": verseID,
        "gitaVerseById": gitaVerseById,
        "verseNote": verseNote
      };
}

class VerseCustomissation {
  int fontsize = 16;
  String fontfamily = "Inter";
  double lineSpacing = 1.5;
  String colorId = "1";

  VerseCustomissation(
      {required this.fontsize,
      required this.fontfamily,
      required this.lineSpacing,
      required this.colorId});
  factory VerseCustomissation.fromJson(Map<String, dynamic> json) =>
      VerseCustomissation(
        fontsize: json['fontsize'],
        fontfamily: json['fontFamily'],
        lineSpacing: json['lineSpacing'],
        colorId: json['colorId'],
      );
  Map<String, dynamic> toJson() => {
        'fontsize': fontsize,
        'fontFamily': fontfamily,
        'lineSpacing': lineSpacing,
        'colorId': colorId,
      };
}
